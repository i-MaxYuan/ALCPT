import re

from string import punctuation
from datetime import datetime

from django.shortcuts import render, redirect
from django.views.decorators.http import require_http_methods

from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.core.exceptions import ObjectDoesNotExist
from django.db import IntegrityError
from django.contrib import messages

from alcpt.managerfuncs import systemmanager
from alcpt.models import User, Student, Department, Squadron, Proclamation, AnswerSheet, Exam
from alcpt.definitions import UserType
from alcpt.decorators import permission_check
from alcpt.exceptions import IllegalArgumentError

import plotly.offline as pyo
import plotly.graph_objs as go
import pandas as pd
import numpy as np

@permission_check(UserType.Viewer)
def index(request):
    exams = Exam.objects.filter(is_public=True)
    now_time = datetime.now()

    return render(request, 'viewer/exam_score_list.html', locals())


@permission_check(UserType.Viewer)
def exam_score_detail(request, exam_id):
    try:
        exam = Exam.objects.get(id=exam_id)
        testees = exam.testeeList.all()

        testee_number = len(testees)

        qualified = 0
        unqualified = 0
        not_tested = 0
        testee_not_tested = 0
        testee_scores = []
        answer_sheets = []
        SCORE_RANGE = {'one': 0,'two': 0,'three': 0,'four': 0,'five': 0,'six': 0,'seven': 0,'eight': 0,'nine': 0,'ten': 0}

        for testee in testees:
            try:
                answer_sheet = AnswerSheet.objects.get(exam=exam, user_id=testee.id)
                if answer_sheet.is_tested is False:
                    not_tested += 1
                    testee_not_tested += 1
                elif answer_sheet.score >= 60:
                    testee_scores.append(answer_sheet.score)
                    qualified += 1
                elif answer_sheet.score < 60:
                    testee_scores.append(answer_sheet.score)
                    unqualified += 1

                answer_sheets.append(answer_sheet)
            except ObjectDoesNotExist:
                not_tested += 1
                answer_sheets.append(None)

        #計算成績分布
        for testee in testees:
            count = 0
            try:
                answer_sheet = AnswerSheet.objects.get(exam=exam, user_id=testee.id)
                if answer_sheet.is_tested is False:
                    pass
                else:
                    if count <= answer_sheet.score <= count + 10:
                        SCORE_RANGE['one'] += 1
                    else:
                        count += 10
                        for name in list(SCORE_RANGE.keys())[1:]:
                            if count < answer_sheet.score <= count + 10:
                                SCORE_RANGE[name] += 1
                                break
                            else:
                                count += 10
            except ObjectDoesNotExist:
                pass


        #平均分數
        # if testee_scores:
        #     testee_score_means = np.mean(testee_scores)
        # else:
        #     testee_score_means = '無考試成績'

        testeeData = list(zip(testees, answer_sheets))

        #Bar Chart
        #xaxis: score
        #yaxis: the number of different range's score

        x_data = [str(num) for num in range(10, 101, 10)]
        y_data = list(SCORE_RANGE.values())
        color = ['#FF0000','#FF5B00','#FF7900','#FFB600','#FFE700','#E1FF00','#B6FF00','#86FF00','#55FF00','#18FF00']

        df = pd.DataFrame(list(zip(x_data, y_data)))

        df['color'] = color
        df = df.rename(columns={0: 'score', 1: 'student number'})

        trace = go.Bar(x=df['score'], y=df['student number'],
                    opacity=0.8,
                    marker_color=df['color'])

        data = [trace]

        layout = go.Layout(
            title = '考生成績分佈圖',
            xaxis = dict(title = '成績'),
            yaxis = dict(title = '學生人數')
        )

        fig = go.Figure(data=data, layout=layout)
        bar_chart = pyo.plot(fig, output_type='div')

        #Pie chart
        status = ['未進行測驗', '合格', '不合格']
        status_count = [not_tested, qualified, unqualified]
        colors = ['grey','green', 'red']
        trace = go.Pie(labels = status,
                       values = status_count,
                       hole = .4,
                       type = 'pie')
        data = [trace]
        layout = go.Layout({
            'title': '考試狀態',
            'annotations': [
                 {
                    'font': {
                       'size': 20
                    },
                    'showarrow': False,
                    'text': '考試狀態',
                 },
              ]
        })
        fig = go.Figure(data=data, layout=layout)
        fig.update_traces(marker = dict(colors=colors))
        pie_chart = pyo.plot(fig, output_type='div')

        return render(request, 'viewer/exam_score_detail.html', locals())
    except ObjectDoesNotExist:
        messages.error(request, 'Exam does not exist, exam id - {}'.format(exam_id))
        return redirect('exam_score_list')


@permission_check(UserType.Viewer)
def view_testee_info(request, exam_id, reg_id):
    try:
        exam = Exam.objects.get(id=exam_id)
        try:
            viewed_testee = User.objects.get(reg_id=reg_id)

            answer_sheets = AnswerSheet.objects.filter(user=viewed_testee).order_by("-finish_time")

            if viewed_testee.last_login == None:
                messages.error(request, "User hasn't login before, user register id - {}".format(reg_id))
                return redirect('exam_score_detail', exam_id=exam.id)
            else:
                return render(request, 'viewer/view_testee_info.html', locals())


        except ObjectDoesNotExist:
            messages.error(request, "User does not exist, user register id - {}".format(reg_id))
            return redirect('exam_score_detail', exam_id=exam.id)



    except ObjectDoesNotExist:
        messages.error(request, "Exam does not exist, exam id - {}".format(exam_id))
        return redirect('exam_score_list')
