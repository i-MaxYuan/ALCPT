import re

from string import punctuation
from datetime import datetime

from django.utils.translation import gettext as _ #translation
from django.shortcuts import render, redirect
from django.views.decorators.http import require_http_methods

from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.core.exceptions import ObjectDoesNotExist
from django.db import IntegrityError
from django.contrib import messages

from alcpt.managerfuncs import systemmanager
from alcpt.models import User, Student, Department, Squadron, Proclamation, AnswerSheet, Exam, ExamResult
from alcpt.definitions import UserType
from alcpt.decorators import permission_check
from alcpt.exceptions import IllegalArgumentError
from alcpt.testee import IntegrateTestResults

from django.views.generic import View
from alcpt.views import OnlineUserStat
from django.utils.decorators import method_decorator

import plotly.offline as pyo
import plotly.graph_objs as go
import pandas as pd
import numpy as np

from django.http import HttpResponse, HttpResponseRedirect
import csv
from django.urls import reverse

@method_decorator(permission_check(UserType.Viewer), name='get')
class IndexView(View, OnlineUserStat):

    template_name = 'viewer/exam_score_list.html'

    def do_content_works(self, request):

        # 1. 基本查詢：公開考試
        exams = Exam.objects.filter(is_public=True)

        # 2. 搜尋功能：搜尋考試名稱
        keyword = request.GET.get("keyword", "")
        if keyword:
            exams = exams.filter(name__icontains=keyword)

        # 3. 日期篩選（開始、結束）
        start_date = request.GET.get("start_date")
        end_date = request.GET.get("end_date")

        if start_date:
            exams = exams.filter(start_time__date__gte=start_date)
        if end_date:
            exams = exams.filter(finish_time__date__lte=end_date)

        # 4. 排序功能
        sort = request.GET.get("sort")
        if sort == "avg_asc":
            exams = exams.order_by("average_score")
        elif sort == "avg_desc":
            exams = exams.order_by("-average_score")
        elif sort == "start_asc":
            exams = exams.order_by("start_time")
        elif sort == "start_desc":
            exams = exams.order_by("-start_time")
        elif sort == "count_desc":
            exams = sorted(exams, key=lambda x: x.testeeList.count(), reverse=True)
        elif sort == "count_asc":
            exams = sorted(exams, key=lambda x: x.testeeList.count())

        # 5. 分頁（可加可不加）
        paginator = Paginator(exams, 20)
        page = request.GET.get("page")

        try:
            exams_page = paginator.page(page)
        except PageNotAnInteger:
            exams_page = paginator.page(1)
        except EmptyPage:
            exams_page = paginator.page(paginator.num_pages)

        return {
            "exams": exams_page,
            "keyword": keyword,
            "sort": sort,
            "start_date": start_date,
            "end_date": end_date
        }
    
    def get(self, request):
        exams = Exam.objects.filter(is_public=True)

        # 搜尋功能
        keyword = request.GET.get('q', '').strip()
        if keyword:
            exams = exams.filter(name__icontains=keyword)

        # 日期過濾
        date_str = request.GET.get('date', '').strip()
        if date_str:
            exams = exams.filter(start_time__date=date_str)

        # 排序 (可擴充)
        sort = request.GET.get('sort', '')
        if sort == 'avg_asc':
            exams = exams.order_by('average_score')
        elif sort == 'avg_desc':
            exams = exams.order_by('-average_score')
        elif sort == 'start_asc':
            exams = exams.order_by('start_time')
        elif sort == 'start_desc':
            exams = exams.order_by('-start_time')

        # 分頁
        paginator = Paginator(exams, 20)
        page = request.GET.get('page', 1)
        try:
            exams_page = paginator.page(page)
        except PageNotAnInteger:
            exams_page = paginator.page(1)
        except EmptyPage:
            exams_page = paginator.page(paginator.num_pages)

        context = {
            'exams': exams_page,
            'request': request,  # 保留 GET 參數給 template
        }

        return render(request, self.template_name, context)

@permission_check(UserType.Viewer)
def export_exam_list_pdf(request):
    # 目前先回傳一個簡單文字，之後可以換成真正的 PDF 匯出
    return HttpResponse("PDF export not implemented yet.")


@permission_check(UserType.Viewer)
def export_exam_list(request):

    exams = Exam.objects.filter(is_public=True)

    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="exam_list.csv"'

    writer = csv.writer(response)
    writer.writerow(["Name", "Average", "Testee Count", "Start Time", "Finish Time"])

    for e in exams:
        writer.writerow([
            e.name,
            e.average_score,
            e.testeeList.count(),
            e.start_time.strftime('%Y/%m/%d %H:%M'),
            e.finish_time.strftime('%Y/%m/%d %H:%M')
        ])

    return response



# @method_decorator(permission_check(UserType.Viewer),name='get')
# def exam_score_detail(request, exam_id):
    # try:
    #     exam = Exam.objects.get(id=exam_id)
    #     testees = exam.testeeList.all()

    #     testee_number = len(testees)

    #     qualified = 0
    #     unqualified = 0
    #     not_tested = 0
    #     testee_not_tested = 0
    #     testee_scores = []
    #     answer_sheets = []
    #     testee_grade = []
    #     SCORE_RANGE = {'one': 0,'two': 0,'three': 0,'four': 0,'five': 0,'six': 0,'seven': 0,'eight': 0,'nine': 0,'ten': 0}

    #     for testee in testees:
    #         try:
    #             answer_sheet = AnswerSheet.objects.get(exam=exam, user_id=testee.id)

    #             if answer_sheet.is_tested is False:
    #                 not_tested += 1
    #                 testee_not_tested += 1
    #             elif answer_sheet.score >= 60:
    #                 testee_scores.append(answer_sheet.score)
    #                 qualified += 1
    #             elif answer_sheet.score < 60:
    #                 testee_scores.append(answer_sheet.score)
    #                 unqualified += 1

    #             answer_sheets.append(answer_sheet)
    #         except ObjectDoesNotExist:
    #             not_tested += 1
    #             answer_sheets.append(None)
    #         except TypeError:
    #             messages.warning(request, 'The test is finished, but not all testee had submitted test paper.')
    #             return redirect('exam_score_list')                

    # #級距
    #     def grade(score, breakpoints=[60,70,80,90], grades='FDCBA'):
    #         i = bisect.bisect(breakpoints, score)
    #         return grades[i]

    #     #計算成績分布
    #     for testee in testees:
    #         count = 0
    #         try:
    #             answer_sheet = AnswerSheet.objects.get(exam=exam, user_id=testee.id)
    #             if answer_sheet.is_tested is False:
    #                 testee_grade.append(grade(0))
    #                 pass
    #             else:
    #                 testee_grade.append(grade(answer_sheet.score))
    #                 if count <= answer_sheet.score <= count + 10:
    #                     SCORE_RANGE['one'] += 1
    #                 else:
    #                     count += 10
    #                     for name in list(SCORE_RANGE.keys())[1:]:
    #                         if count < answer_sheet.score <= count + 10:
    #                             SCORE_RANGE[name] += 1
    #                             break
    #                         else:
    #                             count += 10
    #         except ObjectDoesNotExist:
    #             pass

    #     testeeData = list(zip(testees, answer_sheets, testee_grade))

    #     #Bar Chart
    #     #xaxis: score
    #     #yaxis: the number of different range's score

    #     x_data = [str(num) for num in range(10, 101, 10)]
    #     y_data = list(SCORE_RANGE.values())
    #     color = ['#FF0000','#FF5B00','#FF7900','#FFB600','#FFE700','#E1FF00','#B6FF00','#86FF00','#55FF00','#18FF00']

    #     df = pd.DataFrame(list(zip(x_data, y_data)))

    #     df['color'] = color
    #     df = df.rename(columns={0: 'score', 1: 'student number'})

    #     trace = go.Bar(x=df['score'], y=df['student number'],
    #                 opacity=0.8,
    #                 marker_color=df['color'])

    #     data = [trace]

    #     layout = go.Layout(
    #         title = '考生成績分佈圖',
    #         xaxis = dict(title = '成績'),
    #         yaxis = dict(title = '學生人數'))

    #     fig = go.Figure(data=data, layout=layout)
    #     bar_chart = pyo.plot(fig, output_type='div')

    #     #Pie chart
    #     status = ['未進行測驗', '合格', '不合格']
    #     status_count = [not_tested, qualified, unqualified]
    #     colors = ['grey','green', 'red']
    #     trace = go.Pie(labels = status,
    #                    values = status_count,
    #                    hole = .4,
    #                    type = 'pie')
    #     data = [trace]
    #     layout = go.Layout({
    #         'title': '考試狀態',
    #         'annotations': [{'font': {'size': 20},
    #                          'showarrow': False,
    #                          'text': '考試狀態',}]})
    #     fig = go.Figure(data=data, layout=layout)
    #     fig.update_traces(marker = dict(colors=colors))
    #     pie_chart = pyo.plot(fig, output_type='div')

    #     return render(request, 'viewer/exam_score_detail.html', locals())
    # except ObjectDoesNotExist:
    #     messages.error(request, 'Exam does not exist, exam id - {}'.format(exam_id))
    #     return redirect('exam_score_list')



# 假設 permission_check、UserType、Exam、ExamResult 已正確導入

class ExamScoreDetail(View):
    template_name = 'viewer/exam_score_detail.html'

    def get_context_data(self, exam_id):
        context = {}
        try:
            # 取得 Exam
            exam = Exam.objects.get(id=exam_id)
            testees = exam.testeeList.all()

            # 取得或建立 ExamResult
            exam_result, created = ExamResult.objects.get_or_create(
                exam=exam,
                defaults={
                    'range_times': [0]*10,
                    'testee_num': len(testees),
                    'tested': 0,
                    'not_tested_num': len(testees),
                    'testee_score': [None]*len(testees),
                    'testee_grade': [None]*len(testees),
                    'qualified_num': 0,
                    'unqualified_num': 0
                }
            )

            # 初始化未作答考生成績
            if not exam.is_started and (not exam_result.testee_score or not exam_result.testee_grade):
                exam_result.testee_score = [None] * len(testees)
                exam_result.testee_grade = [None] * len(testees)
                exam_result.save()

            # 組合考生資料
            testeeData = list(zip(testees, exam_result.testee_score, exam_result.testee_grade))
            if not testeeData:
                testeeData = []  # 確保不為 None

            # 錯題分析
            top_wrong_questions = getattr(exam_result, 'top_wrong_questions', [])
            weakest_category = getattr(exam_result, 'weakest_category', '無')

            # 成績分布
            score_ranges = getattr(exam_result, 'range_times_dict', {})
            if not score_ranges:
                # 初始化空圖表數據，保證前端能渲染空圖
                score_ranges = {f'{i*10+1}-{(i+1)*10}': 0 for i in range(10)}

            # Bar Chart
            x_data = list(score_ranges.keys())
            y_data = list(score_ranges.values())
            colors = ['#FF0000','#FF5B00','#FF7900','#FFB600','#FFE700',
                      '#E1FF00','#B6FF00','#86FF00','#55FF00','#18FF00']
            trace = go.Bar(x=x_data, y=y_data, marker_color=colors)
            bar_chart = pyo.plot(go.Figure(data=[trace], layout=go.Layout(title='考生成績分佈圖')), output_type='div')

            # Pie Chart
            status = ['未進行測驗','合格','不合格']
            status_count = [
                exam_result.not_tested_num or len(testees),
                exam_result.qualified_num or 0,
                exam_result.unqualified_num or 0
            ]
            pie_trace = go.Pie(labels=status, values=status_count, hole=.4, marker=dict(colors=['grey','green','red']))
            pie_chart = pyo.plot(go.Figure(data=[pie_trace], layout=go.Layout(title='考試狀態')), output_type='div')

            # URL
            export_excel_url = reverse('export_exam_list_excel') + f'?exam_id={exam.id}'
            view_testee_info_url = {t.reg_id: reverse('view_testee_info', args=[exam.id, t.reg_id]) for t in testees}

            # 更新 context
            context.update({
                'exam': exam,
                'testeeData': testeeData,
                'testee_number': len(testees),
                'testee_not_tested': exam_result.not_tested_num or len(testees),
                'qualified': exam_result.qualified_num or 0,
                'unqualified': exam_result.unqualified_num or 0,
                'pie_chart': pie_chart,
                'bar_chart': bar_chart,
                'top_wrong_questions': top_wrong_questions,
                'weakest_category': weakest_category,
                'score_ranges': score_ranges,
                'export_excel_url': export_excel_url,
                'view_testee_info_url': view_testee_info_url,
                'exam_score_list_url': reverse('exam_score_list'),
            })

            return context

        except ObjectDoesNotExist:
            messages.error(self.request, f'Exam does not exist, exam id - {exam_id}')
            return redirect('exam_score_list')

    def get(self, request, exam_id):
        context = self.get_context_data(exam_id)
        if isinstance(context, HttpResponseRedirect):
            return context
        return self.render_to_response(context)

    def render_to_response(self, context):
        from django.template.response import TemplateResponse
        return TemplateResponse(self.request, self.template_name, context)


@method_decorator(permission_check(UserType.Viewer),name='get')
# def view_testee_info(request, exam_id, reg_id):
#     try:
#         exam = Exam.objects.get(id=exam_id)
#         try:
#             viewed_testee = User.objects.get(reg_id=reg_id)

#             answer_sheets = AnswerSheet.objects.filter(user=viewed_testee).order_by("-finish_time")

#             if viewed_testee.last_login == None:
#                 messages.error(request, "User hasn't login before, user register id - {}".format(reg_id))
#                 return redirect('exam_score_detail', exam_id=exam.id)
#             else:
#                 return render(request, 'viewer/view_testee_info.html', locals())

#         except ObjectDoesNotExist:
#             messages.error(request, "User does not exist, user register id - {}".format(reg_id))
#             return redirect('exam_score_detail', exam_id=exam.id)

#     except ObjectDoesNotExist:
#         messages.error(request, "Exam does not exist, exam id - {}".format(exam_id))
#         return redirect('exam_score_list')
class ViewTesteeInfo(View, OnlineUserStat):
    template_name = 'viewer/view_testee_info.html'

    def get_context_data(self, request, exam_id, reg_id):
        context = {}
        try:
            exam = Exam.objects.get(id=exam_id)
            try:
                viewed_testee = User.objects.get(reg_id=reg_id)
                answer_sheets = AnswerSheet.objects.filter(user=viewed_testee).order_by("-finish_time")

                if viewed_testee.last_login is None:
                    messages.error(request, f"User hasn't login before, user register id - {reg_id}")
                    return redirect('exam_score_detail', exam_id=exam.id)

                context.update({
                    'exam': exam,
                    'viewed_testee': viewed_testee,
                    'answer_sheets': answer_sheets,
                })
                return context

            except ObjectDoesNotExist:
                messages.error(request, f"User does not exist, user register id - {reg_id}")
                return redirect('exam_score_detail', exam_id=exam.id)

        except ObjectDoesNotExist:
            messages.error(request, f"Exam does not exist, exam id - {exam_id}")
            return redirect('exam_score_list')

    def get(self, request, exam_id, reg_id):
        context = self.get_context_data(request, exam_id, reg_id)
        if isinstance(context, redirect):
            return context
        from django.template.response import TemplateResponse
        return TemplateResponse(request, self.template_name, context)

