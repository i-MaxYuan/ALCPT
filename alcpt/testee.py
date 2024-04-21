import json
import random
from datetime import datetime, timedelta
from string import punctuation

from django.shortcuts import render, redirect
from django.http.response import HttpResponse
from django.core.exceptions import ObjectDoesNotExist
from django.contrib import messages
from django.views.decorators.http import require_http_methods
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage

from .models import Question, AnswerSheet, Student, User, Exam, TestPaper, Answer, ReportCategory, Report, Achievement, UserAchievement, Forum, Word_library, ScoreRecord, ExamResult
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType, QuestionType, ExamType, AchievementCategory
from .managerfuncs import practicemanager, testmanager, testee
from django.utils.translation import gettext as _

import plotly.offline as pyo
import plotly.graph_objs as go
import pandas as pd
import bisect

from django.db.models.signals import post_save
from django.core.signals import request_finished
from django.dispatch import receiver, Signal
from .achievement.achievement import TestAchievement, achievement_create, new_user_achievement_create, old_user_achievement_update
from django.views.generic import View
from django.utils.decorators import method_decorator
from alcpt.views import OnlineUserStat

request_achievement_signal = Signal(providing_args=['user', 'score', 'exam_type'])

#統整user practices/all testees exam的結果
class IntegrateTestResults:
    
    #更新user在某類型(exam_type)考試中合格次數
    def score_records(self, user, exam_type):                 
        score_record = ScoreRecord.objects.get(user=user, exam_type=exam_type)
        score_record.qualified_times = len(AnswerSheet.objects.all().filter(user=user, exam__exam_type=exam_type, score__gte=60))   #score >= 60 data
        score_record.unqualified_times = len(AnswerSheet.objects.all().filter(user=user, exam__exam_type=exam_type, score__lt=60))   #score < 60 data
        score_record.save()
    
    #record Exam qualified_num
    def exam_results(self, exam, score):
        exam_result =  ExamResult.objects.get(exam=exam)
        testee_scores = exam_result.testee_score
        testee_grades = exam_result.testee_grade
        exam_result.tested += 1
        exam_result.not_tested_num = len(exam.testeeList.all())-exam_result.tested
        exam_result.range_times[score//10-1] += 1
        
        def grade(score, breakpoints=[60,70,80,90], grades='FDCBA'):
            i = bisect.bisect(breakpoints, score)
            return grades[i]
        
        testees = exam.testeeList.all()
        for testee in testees:
            answer_sheet = AnswerSheet.objects.get(exam=exam, user_id=testee.id)
        
            if answer_sheet.is_tested:
                
                if score >= 60:
                    exam_result.qualified_num += 1
                    testee_scores.append(score)
                    testee_grades.append(grade(score))
                    
                elif score < 60:
                    exam_result.unqualified_num += 1
                    testee_scores.append(score)
                    testee_grades.append(grade(score))
            
            else:
                testee_scores.append(None)
                testee_grades.append(grade(0))
        exam_result.save()

@receiver(post_save, sender=Achievement)
def achievement_create_receiver(sender, instance, **kwargs):
    achievement_create(instance)

@receiver(post_save, sender=User)
def new_user_achievement_create_receiver(sender, instance, created, **kwargs):
    if created == False:
        old_user_achievement_update(instance)
        pass
    else:
        new_user_achievement_create(instance)



# @receiver(request_finished)
# def special_exam_achievement_receiver(sender, **kwargs):
#     exam = Exam.objects.all().filter(exam_type=1)[0]
#     now = datetime.now()
#     if (now > exam.finish_time) & (now < (exam.finish_time+datetime.timedelta(hours=1))):
#         special_achievement_exam_settle(exam.id)


@permission_check(UserType.Testee)
@receiver(request_achievement_signal)
def post_achievement_receiver(sender, **kwargs):
    user = 0
    score = 0
    for key, value in kwargs.items():
        if key == 'user':
            user = value
        if key == 'score':
            score = value
        if key == 'exam_type': # 過濾是哪種考試類別
            #傳入考試別到函數
            if value == 1:
                achievement_cal = TestAchievement(user, score, value, 5) #建立物件 Exam
                achievement_cal.test_achievement()
            elif value == 3:
                achievement_cal = TestAchievement(user, score, value, 6) #建立物件 listening
                achievement_cal.test_achievement()
            elif value == 4:
                achievement_cal = TestAchievement(user, score, value, 7) #建立物件 reading
                achievement_cal.test_achievement()



#再寫個Signal
@require_http_methods(["GET", "POST"])
@permission_check(UserType.Testee)
def accept_achievement(request, achievement_id, achievement_category):
    achievement = Achievement.objects.get(id=achievement_id)
    try:
        achievement.filter(userachievements__user=request.user)
        messages.warning(request, "Not a valid achievement")
        return redirect("testee_achievement_list")

    except:
        accept_achievement = UserAchievement.objects.create(user=request.user,
                                                            achievement=achievement)
        accept_achievement.save()

        print(achievement_category)

        achievement_cal = TestAchievement(request.user.id, int(achievement_category)) #建立物件
        result = achievement_cal.test_achievement()

        if result != None:
            messages.success(request,"You get the achievement {}".format(result))
            return redirect("testee_achievement_list")
        else:
            messages.success(request, "Accept achievement successfully! ")
            return redirect("testee_achievement_list")



@method_decorator(permission_check(UserType.Testee),name='get')
class AchievementListView(View,OnlineUserStat):
    
    template_name='testee/achievement.html'
    
    def do_content_works(self,request):
        all_achievements = Achievement.objects.all()
        #還沒接的成就
        unreceived_achievements = Achievement.objects.all().exclude(userachievements__user=request.user).filter(level__lte=request.user.level)
        #已經接的成就
        received_achievements = UserAchievement.objects.all().filter(user=request.user).filter(unlock=False)
        #已完成成就
        completed_achievements = UserAchievement.objects.all().filter(user=request.user).filter(unlock=True)

        return dict(all_achievements=all_achievements,
                    received_achievements=received_achievements,
                    completed_achievements=completed_achievements)


class LeaderBoardView(View,OnlineUserStat):
    
    template_name='testee/leaderboard.html'
    
    def do_content_works(self,request):
        now_time = datetime.now()
        # 等級排名
        user_level = User.objects.all().order_by('-level')
        # 模擬考排名
        exam = Exam.objects.all().filter(exam_type=1).order_by('-id')
        if exam:
            latest_exam = exam[0]
            leaderboard = AnswerSheet.objects.all().filter(exam_id=latest_exam.id).order_by("-score")

        return dict(now_time=now_time,
                    user_level=user_level,
                    exam=exam,
                    latest_exam=latest_exam,
                    leaderboard=leaderboard)


@method_decorator(permission_check(UserType.Testee),name='get')
class ExamListView(View,OnlineUserStat):
    
    template_name='testee/exam_list.html'
    
    def do_content_works(self,request,exam_type):
        examList = []
        
        if exam_type == '1':
            exams = Exam.objects.filter(is_public=True).filter(testeeList=request.user)
        else:
            exams = Exam.objects.filter(is_public=False).filter(created_by=request.user)
        
        for exam in exams:
            examList.append(exam)
        
        context={'examList':examList,
                 'exam_type':exam_type,}
        
        return render(request, 'testee/exam_list.html', context)
    # def get(self,request):  
    #     examList = []
    #     exams = Exam.objects.filter(is_public=True).filter(testeeList=request.user)
    #     for exam in exams:
    #         examList.append(exam)
       
    #     practiceList = []
    #     practices = Exam.objects.filter(is_public=False).filter(created_by=request.user)
        
    #     for practice in practices:
    #         practiceList.append(practice)
        
    #     context={'examList':examList,
    #              'exams':exams,
    #              'practiceList': practiceList,
    #              'practices':practices,}
        
    #     return render(request, 'testee/exam_list.html', context)
    

@permission_check(UserType.Testee)
def pending(request, exam_id):
    exam = Exam.objects.get(id=exam_id)

    if exam.remaining_time is not None:    #remaining_time != 0 時才可按save按鈕，考試結束時會直接顯示彈跳視窗離開頁面(有限制考試時間時，if永遠成立; )
        now_time = datetime.now()          #可不限制考試時間，所以if不可省略
        exam.remaining_time = exam.remaining_time - timedelta.total_seconds(now_time - exam.modified_time)
        exam.save()
    return redirect('testee_exam_list', exam_type=exam.exam_type)

@method_decorator(permission_check(UserType.Testee),name='get')
@method_decorator(require_http_methods(["GET"]),name='get')
class ScoreList(View,OnlineUserStat):
    
    template_name = 'testee/score_list.html'
    
    def do_content_works(self,request,exam_type):
        answer_sheets = AnswerSheet.objects.all().filter(user=request.user,exam__exam_type=exam_type).order_by('exam__created_time')
        tests_score = [i.name for i in list(ExamType) if int(exam_type) == i.value[0]]
      
    # Line chart
        layouts = go.Layout(title={'text':'成績分布圖(僅顯示近8次成績)'}, yaxis={'title':'score','range':[0,101]},
                            xaxis_title='finished_time', font=dict(size=10,color='Black')) 
    
        x_finish_time = list(x[0].strftime('%Y%m%d%R') for x in answer_sheets.values_list('finish_time'))[-8:]
        traces = go.Scatter(x=x_finish_time, y=list(i[0] for i in answer_sheets.values_list('score'))[-8:],
                            mode='lines+markers', marker={'color':'#FF5B00'})
    
        exam_fig = go.Figure(data=traces,layout=layouts)
        
        exam_line_chart = pyo.plot(exam_fig,output_type='div')
    
    # Pie chart
        qualify = ['合格', '不合格']
        colors = ['green', 'red']
        
        layout = go.Layout({
            'title': '模擬鑑測合格率分析',
            'annotations': [
                {
                'font': {'size': 20},
                'showarrow': False,
                'text': '合格率',
                },
            ]
        })

        is_qualify = ScoreRecord.objects.get(user=request.user,exam_type=exam_type)
        trace = go.Pie(labels = qualify,
                       values = [is_qualify.qualified_times,is_qualify.unqualified_times],
                       hole = .4,
                       type= 'pie',
                       marker=dict(colors=colors))
        data = [trace]
    
        fig = go.Figure(data=data, layout=layout)
        
        exam_pie_chart = pyo.plot(fig, output_type='div')
        
        context = {'tests_score':tests_score[0],
                    'answer_sheets_exam':answer_sheets,
                    'exam_line_chart':exam_line_chart, 'exam_pie_chart':exam_pie_chart,}

        return context

    #==========================================================================================
    # answer_sheets = AnswerSheet.objects.all().filter(user=request.user)
    # answer_sheets_all = answer_sheets.order_by('-exam__created_time')
    # answer_sheets_reading = answer_sheets.filter(exam__name__contains="閱讀練習").order_by('-exam__created_time')
    # answer_sheets_listening = answer_sheets.filter(exam__name__contains="聽力練習").order_by('-exam__created_time')
    # answer_sheets_exam = answer_sheets.exclude(exam__name__contains="閱讀練習").exclude(exam__name__contains="聽力練習").order_by('-exam__created_time')



    # EXAM_QUALIFICATION = {'qualified': 0,'unqualified': 0}
    # READING_QUALIFICATION = {'qualified': 0,'unqualified': 0}
    # LISTENING_QUALIFICATION = {'qualified': 0,'unqualified': 0}

    # EXAM_SCORE_RANGE = {'zero':0, 'one': 0,'two': 0,'three': 0,'four': 0,'five': 0,'six': 0,'seven': 0,'eight': 0,'nine': 0, 'ten': 0}
    # READING_SCORE_RANGE = {'zero':0, 'one': 0,'two': 0,'three': 0,'four': 0,'five': 0,'six': 0,'seven': 0,'eight': 0,'nine': 0, 'ten': 0}
    # LISTENING_SCORE_RANGE = {'zero':0, 'one': 0,'two': 0,'three': 0,'four': 0,'five': 0,'six': 0,'seven': 0,'eight': 0,'nine': 0, 'ten': 0}

    # #EXAM
    # #計算是否及格
    # for answer_sheet in answer_sheets_exam:
    #     if answer_sheet.score is None:
    #         pass
    #     elif answer_sheet.score >= 60:
    #         EXAM_QUALIFICATION['qualified'] += 1
    #     else:
    #         EXAM_QUALIFICATION['unqualified'] += 1

    # #計算成績分布
    # for answer_sheet in answer_sheets_exam:
    #     count = 0
    #     if answer_sheet.score is None:
    #         pass
    #     else:
    #         if count <= answer_sheet.score < count + 10:
    #             EXAM_SCORE_RANGE['zero'] += 1
    #         else:
    #             count += 10
    #             for name in list(EXAM_SCORE_RANGE.keys())[1:]:
    #                 if count <= answer_sheet.score < count + 10:
    #                     EXAM_SCORE_RANGE[name] += 1
    #                     break
    #                 elif count < answer_sheet.score == 100:
    #                     EXAM_SCORE_RANGE['ten'] += 1
    #                 else:
    #                     count += 10

    # #READING
    # #計算是否及格
    # for answer_sheet in answer_sheets_reading:
    #     if answer_sheet.score is None:
    #         pass
    #     elif answer_sheet.score >= 60:
    #         READING_QUALIFICATION['qualified'] += 1
    #     else:
    #         READING_QUALIFICATION['unqualified'] += 1

    # #計算成績分布
    # for answer_sheet in answer_sheets_reading:
    #     count = 0
    #     if answer_sheet.score is None:
    #         pass
    #     else:
    #         if count <= answer_sheet.score < count + 10:
    #             READING_SCORE_RANGE['zero'] += 1
    #         else:
    #             count += 10
    #             for name in list(READING_SCORE_RANGE.keys())[1:]:
    #                 if count <= answer_sheet.score < count + 10:
    #                     READING_SCORE_RANGE[name] += 1
    #                     break
    #                 elif count < answer_sheet.score == 100:
    #                     EXAM_SCORE_RANGE['ten'] += 1
    #                 else:
    #                     count += 10
    # #LISTENING
    # #計算是否及格
    # for answer_sheet in answer_sheets_listening:
    #     if answer_sheet.score is None:
    #         pass
    #     elif answer_sheet.score >= 60:
    #         LISTENING_QUALIFICATION['qualified'] += 1
    #     else:
    #         LISTENING_QUALIFICATION['unqualified'] += 1

    # #計算成績分布
    # for answer_sheet in answer_sheets_listening:
    #     count = 0
    #     if answer_sheet.score is None:
    #         pass
    #     else:
    #         if count <= answer_sheet.score < count + 10:
    #             LISTENING_SCORE_RANGE['zero'] += 1
    #         else:
    #             count += 10
    #             for name in list(LISTENING_SCORE_RANGE.keys())[1:]:
    #                 if count <= answer_sheet.score < count + 10:
    #                     LISTENING_SCORE_RANGE[name] += 1
    #                     break
    #                 elif count < answer_sheet.score == 100:
    #                     EXAM_SCORE_RANGE['ten'] += 1
    #                 else:
    #                     count += 10
    # # xaxis : Score
    # # yaxis : Times
    # # Bar chart
    # x_data = [ str(num) for num in range(0, 101, 10)]
    # y_exam_data = list(EXAM_SCORE_RANGE.values())
    # y_reading_data = list(READING_SCORE_RANGE.values())
    # y_listening_data = list(LISTENING_SCORE_RANGE.values())
    # color = ['#FF0000','#FF5B00','#FF7900','#FFB600','#FFE700','#E1FF00','#B6FF00','#86FF00','#55FF00','#18FF00', '#18FF00']

    # #Exam
    # df = pd.DataFrame(list(zip(x_data,y_exam_data)))

    # df['color'] = color
    # df = df.rename(columns={0: 'score', 1: 'time'})


    # trace = go.Bar(x=df['score'], y=df['time'],
    #             opacity=0.8,
    #             marker_color=df['color'])
    # data=[trace]
    # layout = go.Layout(
    #     title='模擬鑑測總成績分佈',
    #     xaxis = dict(title = '成績'),
    #     yaxis = dict(title = '鑑測成績範圍次數')
    # )
    # fig = go.Figure(data=data, layout=layout)
    # exam_bar_chart = pyo.plot(fig, output_type='div')

    # #Reading
    # df = pd.DataFrame(list(zip(x_data,y_reading_data)))

    # df['color'] = color
    # df = df.rename(columns={0: 'score', 1: 'time'})


    # trace = go.Bar(x=df['score'], y=df['time'],
    #             opacity=0.8,
    #             marker_color=df['color'])
    # data=[trace]
    # layout = go.Layout(
    #     title='閱讀練習總成績分佈',
    #     xaxis = dict(title = '成績'),
    #     yaxis = dict(title = '練習成績範圍次數')
    # )
    # fig = go.Figure(data=data, layout=layout)
    # reading_bar_chart = pyo.plot(fig, output_type='div')

    # #Listening
    # df = pd.DataFrame(list(zip(x_data,y_listening_data)))

    # df['color'] = color
    # df = df.rename(columns={0: 'score', 1: 'time'})


    # trace = go.Bar(x=df['score'], y=df['time'],
    #             opacity=0.8,
    #             marker_color=df['color'])
    # data=[trace]
    # layout = go.Layout(
    #     title='聽力練習總成績分佈',
    #     xaxis = dict(title = '成績'),
    #     yaxis = dict(title = '練習成績範圍次數')
    # )
    # fig = go.Figure(data=data, layout=layout)
    # listening_bar_chart = pyo.plot(fig, output_type='div')

    # # Pie chart
    # qualify = ['合格', '不合格']
    # colors = ['green', 'red']
    # #Exam
    # trace = go.Pie(labels = qualify,
    #                values = list(EXAM_QUALIFICATION.values()),
    #                hole = .4,
    #                type= 'pie')

    # data = [trace]
    # layout = go.Layout({
    #     'title': '模擬鑑測合格率分析',
    #     'annotations': [
    #         {
    #             'font': {
    #                 'size': 20
    #             },
    #             'showarrow': False,
    #             'text': '合格率',
    #         },
    #     ]
    # })
    # fig = go.Figure(data=data, layout=layout)
    # fig.update_traces(marker=dict(colors=colors))
    # exam_pie_chart = pyo.plot(fig, output_type='div')
    # #Reading
    # trace = go.Pie(labels = qualify,
    #                values = list(READING_QUALIFICATION.values()),
    #                hole = .4,
    #                type= 'pie')

    # data = [trace]
    # layout = go.Layout({
    #     'title': '閱讀練習合格率分析',
    #     'annotations': [
    #          {
    #             'font': {
    #                'size': 20
    #             },
    #             'showarrow': False,
    #             'text': '合格率',
    #          },
    #       ]
    #     }
    # )
    # fig = go.Figure(data=data, layout=layout)
    # fig.update_traces(marker=dict(colors=colors))
    # reading_pie_chart = pyo.plot(fig, output_type='div')

    # #Listening
    # trace = go.Pie(labels = qualify,
    #                values = list(LISTENING_QUALIFICATION.values()),
    #                hole = .4,
    #                type= 'pie')

    # data = [trace]
    # layout = go.Layout({
    #     'title': '聽力練習合格率分析',
    #     'annotations': [
    #          {
    #             'font': {
    #                'size': 20
    #             },
    #             'showarrow': False,
    #             'text': '合格率',
    #          },
    #       ]
    #     }
    # )
    # fig = go.Figure(data=data, layout=layout)
    # fig.update_traces(marker=dict(colors=colors))
    # listening_pie_chart = pyo.plot(fig, output_type='div')

    # page = request.GET.get('page', 1)
    # paginator = Paginator(answer_sheets, 10)

    # try:
    #     answersheetList = paginator.page(page)
    # except PageNotAnInteger:
    #     answersheetList = paginator.page(1)
    # except EmptyPage:
    #     answersheetList = paginator.page(paginator.num_pages)

    # context = {'answer_sheets_exam':answer_sheets_exam, 'answer_sheets_reading':answer_sheets_reading, 'answer_sheets_listening': answer_sheets_listening,
    #             'exam_bar_chart':exam_bar_chart, 'exam_pie_chart':exam_pie_chart,
    #             'reading_bar_chart':reading_bar_chart, 'reading_pie_chart':reading_pie_chart,
    #             'listening_bar_chart':listening_bar_chart, 'listening_pie_chart':listening_pie_chart,}

    # return render(request, 'testee/score_list.html', context)


@method_decorator(permission_check(UserType.Testee),name='get')
class PracticeCreateView(View,OnlineUserStat):
    
    template_name='practice/select.html'
    
    def do_content_works(self,request,kind):
        return dict(kind=kind)
    def post (self,request,kind):
        user = User.objects.get(id=request.user.id)

        duration = request.POST.get('duration')
        finish_time = None
        
        if duration == "":
            remaining_time = None
        else:
            remaining_time = int(duration) * 60 # turn to seconds
            #finish_time = datetime.strptime(datetime.now().strftime('%Y-%m-%d %H:%M:%S'), '%Y-%m-%d %H:%M:%S') + timedelta(minutes=int(duration))

        question_num = int(request.POST.get('question_num', ))

        practice_type = ExamType.Listening if kind == 'listening' else ExamType.Reading
        
        if ScoreRecord.objects.filter(user=user,exam_type=practice_type.value[0]).exists() == False: 
            ScoreRecord.objects.create(user=user,exam_type=practice_type.value[0])

        # getlist's element type is str.
        selected_types = request.POST.getlist('question_type', )
        question_types = []
        for item in selected_types:  # Here, it turn all elements to int
            question_types.append(int(item))

        q_types = []  # element's type is QuestionType
        for valid_type in QuestionType:
            if valid_type.value[0] in question_types:
                q_types.append(valid_type)

        practice_exam = practicemanager.create_practice(user=user,
                                                        practice_type=practice_type,
                                                        question_types=selected_types,
                                                        question_num=question_num,
                                                        finish_time=finish_time,
                                                        remaining_time=remaining_time)

        messages.success(request,'創建成功, {}'.format(practice_exam))
        return redirect('testee_exam_list', exam_type=practice_type.value[0]) 


@method_decorator(permission_check(UserType.Testee),name='get')
class ViewAnswersheetContent(View,OnlineUserStat):
    
    template_name='testee/answersheet_content.html'
    
    def do_content_works(self,request, answersheet_id):
        now_time = datetime.now()
        try:
            answersheet = AnswerSheet.objects.get(id=answersheet_id)

            if answersheet.exam.is_public:
                if answersheet.is_finished == False:
                    messages.warning(request, _("You hadn't finish your test, please keep answering the exam"))
                    return redirect('testee_exam_list', exam_type=answersheet.exam__exam_type)
                elif datetime.now() < answersheet.exam.finish_time:
                    messages.warning(request, 'This exam does not finish.')
                    return redirect('testee_score_list', exam_type=answersheet.exam__exam_type)
                elif answersheet.is_tested == False:
                    messages.warning(request, _("You hadn't take this exam!"))
                    return redirect('testee_score_list', exam_type=answersheet.exam__exam_type)

        except ObjectDoesNotExist:
            messages.error(request, 'Answer sheet does not exist, answersheet_id: {}'.format(answersheet_id))
            return redirect('testee_score_list', exam_type=answersheet.exam__exam_type)

        testee_count=0
        if answersheet.is_finished:
            if answersheet.exam.exam_type == 1:
                exam_average_score = answersheet.exam.average_score #平均成績
                #PR = (100/有考試成績的人數*贏過的人數)+(100/有考試成績的人數*1/2)
                exam_score_list = list(AnswerSheet.objects.filter(exam = answersheet.exam.id).order_by("score").exclude(score=None))
                testee_count = len(exam_score_list) #有考試成績的人數


                testee_surpassed = 0
                for exam_score in exam_score_list:
                    if request.user.id != exam_score.user_id:
                        testee_surpassed+=1
                    else:
                        break

                PR = int((100/testee_count*testee_surpassed)+(100/testee_count*1/2))
                rank = testee_count - testee_surpassed


            all_questions = Question.objects.all()#.filter(forum=False)
            answers = answersheet.answer_set.all() #QuerySet
            questions = Question.objects.all().filter(favorite=request.user)
            question_correction_list, q_type_list= testee.question_correction(answersheet)
            is_favorite = []
            forum_comment_search = Forum.objects.all()
            #return 那題題目 is True or False 的 list
            for answer in answers:
                try:
                    questions.get(id=answer.question.id)
                    is_favorite.append(1)

                except ObjectDoesNotExist:
                    is_favorite.append(0)
                    # answers_correction_favorites = zip(answers, question_correction_list, is_favorite)
                    answers_correction_favorites = zip(answers, question_correction_list, is_favorite, all_questions)

            y_data = []
            x_data1 = []
            x_data2 = []
            listening, listening_correct = 0, 0
            reading, reading_correct = 0, 0
            listening_correct_percentage, listening_wrong_percentage = 0, 0
            reading_correct_percentage, reading_wrong_percentage = 0, 0

            for question_correction, q_type in zip(question_correction_list, q_type_list):
                if question_correction:
                    if q_type == 1 or q_type == 2:
                        listening += 1
                        listening_correct += 1
                    else:
                        reading += 1
                        reading_correct += 1
                else:
                    if q_type == 1 or q_type == 2:
                        listening += 1
                    else:
                        reading += 1
            #沒聽力也沒閱讀
            if listening == 0 and reading == 0:
                return dict(answers_correction_favorites=answers_correction_favorites,
                            answersheet=answersheet,
                            exam_average_score=exam_average_score,
                            PR=PR,
                            rank=rank,
                            forum_comment_search=forum_comment_search,
                            testee_count=testee_count,
                            all_questions=all_questions,
                            answers=answers,
                            questions=questions,
                            question_correction_list=question_correction_list,
                            q_type_list=q_type_list,
                            is_favorite=is_favorite)

            else:
                #有聽力有閱讀
                if listening != 0 and reading != 0:
                    listening_correct_percentage  = int(listening_correct/ listening * 100)
                    listening_wrong_percentage = 100 - listening_correct_percentage
                    reading_correct_percentage = int(reading_correct/ reading * 100)
                    reading_wrong_percentage = 100 - reading_correct_percentage
                    y_data = ['Listening', 'Reading']
                    x_data1 = [listening_correct_percentage, reading_correct_percentage]
                    x_data2 = [listening_wrong_percentage, reading_wrong_percentage]
                    width=[0.5, 0.5]

                #沒有閱讀題，代表只有聽力
                elif reading == 0:
                    listening_correct_percentage  = int(listening_correct/ listening * 100)
                    listening_wrong_percentage = 100 - listening_correct_percentage
                    y_data = ['Listening']
                    x_data1 = [listening_correct_percentage]
                    x_data2 = [listening_wrong_percentage]
                    width=[0.25, 0.25]

                #沒有聽力題，代表只有閱讀
                if listening == 0:
                    reading_correct_percentage = int(reading_correct/ reading * 100)
                    reading_wrong_percentage = 100 - reading_correct_percentage
                    y_data = ['Reading']
                    x_data1 = [reading_correct_percentage]
                    x_data2 = [reading_wrong_percentage]
                    width=[0.25, 0.25]

                #x_axis: category of Listening or READING
                #y_axis: correction percentage
                trace1 = go.Bar(
                    y = y_data,
                    x = x_data1,
                    width=width,
                    name = '正確率',
                    orientation = 'h',
                    marker=dict(color='#44E18F',
                            line=dict(width=1)))

                trace2 = go.Bar(
                    y = y_data,
                    x = x_data2,
                    width=width,
                    name = '錯誤率',
                    orientation = 'h',
                    marker=dict(color='#FA483C',
                            line=dict(width=1)))
                data = [trace1, trace2]

                layout = go.Layout(title="本次答題正確率",barmode = 'stack')
                fig = go.Figure(data=data, layout=layout)
                correction_bar_chart = pyo.plot(fig, output_type='div')

                return dict(correction_bar_chart=correction_bar_chart,
                            answersheet=answersheet,
                            testee_count=testee_count,
                            all_questions=all_questions,
                            answers=answers,
                            questions=questions,
                            is_favorite=is_favorite,
                            forum_comment_search=forum_comment_search,
                            answers_correction_favorites=answers_correction_favorites)
        elif answersheet.is_finished  == False and now_time > answersheet.finish_time:

            messages.success(request, {{trans("You hadn't finish your test, please keep answering the exam")}})   
            return redirect('testee_exam_list')
        else:
            messages.warning(request, 'Does not finished this practice. Reject your request.')
            return redirect('testee_score_list', exam_type=answersheet.exam__exam_type)

@permission_check(UserType.Testee)
def favorite_question(request, question_id, answersheet_id):
    question = Question.objects.get(id=question_id)
    try:
        testee = User.objects.all().filter(id=request.user.id)
        testee.get(question__id=question_id)
        user = User.objects.get(id=request.user.id)
        question.favorite.remove(user)
        messages.warning(request, 'Question has removed from your favorite...')

    except ObjectDoesNotExist:
        user = User.objects.get(id=request.user.id)
        question.favorite.add(user)
        messages.success(request, _('Question has added to your favorite!'))
    return redirect('view_answersheet_content', answersheet_id)

@permission_check(UserType.Testee)
def forum_question(request, question_id, answersheet_id):
    # question = Question.objects.all().filter(id=question_id)
    question = Question.objects.get(id=question_id)
    if question.in_forum:
        return redirect('forum')
    else:
        messages.success(request, ('Add the question to the forum'))
        return redirect('view_answersheet_content', answersheet_id)

@permission_check(UserType.Testee)
@require_http_methods(["POST"])
def forum_question_add(request, question_id, answersheet_id):
    if 'forum_comment' in request.POST and request.POST['forum_comment'] != "":
        forum_comment = Forum.objects.create(
            f_question = Question.objects.all().get(id = question_id),
            f_content = request.POST['forum_comment'],
            f_creator = request.user,
            data_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
        if forum_comment.f_question.in_forum == 0:
            Question.objects.all().filter(id=question_id).update(in_forum=1)
        messages.success(request, ('Successfully add the question to the forum.'))
    else:
        messages.warning(request, ('Failure! This space cannot be left blank!'))
    return redirect('view_answersheet_content', answersheet_id)

@permission_check(UserType.Testee)
@require_http_methods(["POST"])
def forum_comment_add(request, question_id):
    if 'forum_comment' in request.POST and request.POST['forum_comment'] != "":
        forum_comment = Forum.objects.create(
            f_question = Question.objects.all().get(id = question_id),
            # f_content = tinymce.get("mytextarea").getContent()
            f_content = request.POST['forum_comment'],
            f_creator = request.user,
            data_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
        messages.success(request, ('Successfully add the comment to the question.'))
    else:
        messages.warning(request, ('Failure! This space cannot be left blank!'))
    return redirect('forum')

@permission_check(UserType.Testee)
def forum_comment_delete(request, forum_comment_id):
    forum_comment = Forum.objects.get(id=forum_comment_id)
    forum_comment.delete()
    messages.warning(request, 'The comment has removed from the forum...')
    if Forum.objects.filter(f_question=forum_comment.f_question.id).count()==0:
        forum_question = Question.objects.filter(id=forum_comment.f_question.id).update(in_forum=0)
    return redirect('forum')

@permission_check(UserType.Testee)
def answersheet_comment_delete(request, forum_comment_id, answersheet_id):
    forum_comment = Forum.objects.get(id=forum_comment_id)
    forum_comment.delete()
    messages.warning(request, 'The comment has removed from the forum...')
    if Forum.objects.filter(f_question=forum_comment.f_question.id).count()==0:
        forum_question = Question.objects.filter(id=forum_comment.f_question.id).update(in_forum=0)
    return redirect('view_answersheet_content', answersheet_id)

@method_decorator(permission_check(UserType.Testee),name='get')
class ForumView(View,OnlineUserStat):
    
    template_name='testee/forum.html'
    
    def do_content_works(self,request):
        forum_questions_search = Question.objects.all().filter(in_forum=1)
        forum_comment_search = Forum.objects.all()
        return dict(forum_questions_search=forum_questions_search,
                    forum_comment_search=forum_comment_search)      


# @permission_check(UserType.TBManager)
# def add_best_reply(request. question_id, q_reply):
#     question = Question.objects.all().get(id=question_id)
#     question.best_reply = q_reply
#     question.replier = request.user
#     return render(request, )



@method_decorator(permission_check(UserType.Testee),name='get')
class FavoriteQuestionListView(View,OnlineUserStat):
    
    template_name='testee/favorite_question_list.html'
    
    def do_content_works(self,request):
        favorite_questions_search = Question.objects.all().filter(favorite=request.user)
        question_types = [_ for _ in QuestionType]

        difficulty_choices =[(1, _('Easy')),
                             (2, _('Medium')),
                             (3, _('Hard'))]

        keywords = {'testee': request.user,
                    'question_content': request.GET.get('question_content'),}

        for keyword in ['question_type', 'difficulty']:
            try:
                keywords[keyword] = int(request.GET.get(keyword))
            except (KeyError, TypeError, ValueError):
                keywords[keyword] = None

        if keywords['question_content'] and any(char in punctuation for char in keywords['question_content']):
            keywords['question_content'] = None
            messages.warning(request, "Name cannot contains any special character.")

        # 使用搜尋功能，系統會至後端資料庫filter出符合條件的題目。所以，頁面會有重新載入的效果。
        # 若是使用Javascript，因是使用cache檔案，所以不會有進入後端抓資料一樣的問題。
        query_content, favorite_questions_search = testee.query_questions(**keywords)

        page = request.GET.get('page', 1)
        paginator = Paginator(favorite_questions_search, 10)  # the second parameter is used to display how many items. Now is display 10

        try:
            questionList = paginator.page(page)
        except PageNotAnInteger:
            questionList = paginator.page(1)
        except EmptyPage:
            questionList = paginator.page(paginator.num_pages)

        return dict(question_types=question_types,
                    difficulty_choices=difficulty_choices,
                    favorite_questions_search=favorite_questions_search,
                    query_content=query_content,
                    questionList=questionList,
                    keywords=keywords)
        
        
@permission_check(UserType.Testee)
def favorite_question_delete(request, question_id):
    user = User.objects.get(id=request.user.id)
    question = Question.objects.get(id=question_id)
    try:
        testee = User.objects.all().filter(id=request.user.id)
        testee.get(question__id=question_id)
        question.favorite.remove(user)
        messages.warning(request, 'Question has removed from your favorite...')
        return redirect('favorite_question_list')
    except ObjectDoesNotExist:
        return redirect('favorite_question_list')


# @permission_check(UserType.Testee)
# @require_http_methods(["GET"])
# def start_exam(request, exam_id):
#     try:
#         exam = Exam.objects.get(id=exam_id)
#         answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user)

#         now_time = datetime.now()
#         if not exam.is_public:
#             pass
#         elif exam.start_time < now_time < exam.finish_time:
#             pass
#         elif now_time < exam.start_time:
#             messages.warning(request, 'Exam does not start.')
#             return redirect('testee_exam_list')

#         elif now_time > exam.finish_time and answer_sheet.is_tested == False:
#             answer_sheet.is_finished = True
#             answer_sheet.save()
#             messages.warning(request, _("You hadn't take this exam!"))
#             return redirect('testee_score_list', exam_type=exam.exam_type)

#         elif now_time > exam.finish_time and answer_sheet.is_tested == True:
#             score = testmanager.calculate_score(exam_id, answer_sheet)
#             messages.warning(request, 'You had not complete this exam. Your score is {}'.format(score))
#             return redirect('testee_score_list', exam_type=exam.exam_type)

#         exam.is_started = True
#         exam.save()

#     except ObjectDoesNotExist:
#         messages.error(request,
#                        'Exam does not exist, Exam id: {}'.format(exam_id))
#         return redirect('testee_exam_list')

#     answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user)
#     if answer_sheet.is_finished:
#         messages.warning(request, 'You had done this exam.')
#         return redirect('testee_exam_list')
#     else:
#         exam = Exam.objects.get(id=exam_id)
#         answer_sheet.is_tested = True
#         answer_sheet.save()
#         return redirect('testee_answering',
#                     exam_id=exam.id,
#                     answer_id=Answer.objects.filter(answer_sheet=answer_sheet)[0].id)   # transfer the first question
@method_decorator(permission_check(UserType.Testee),name='get')
@method_decorator(require_http_methods(["GET"]),name='get')
class StartExam(View, IntegrateTestResults):
    
    def get(self,request,exam_id):
        try:
            exam = Exam.objects.get(id=exam_id)
            answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user)

            now_time = datetime.now()
            if not exam.is_public:
                pass
            elif exam.start_time < now_time < exam.finish_time:
                pass
            elif now_time < exam.start_time:
                messages.warning(request, 'Exam does not start.')
                return redirect('testee_exam_list', exam_type=exam.exam_type)

            elif now_time > exam.finish_time and answer_sheet.is_tested == False:
                answer_sheet.is_finished = True
                answer_sheet.save()
                messages.warning(request, _("You hadn't take this exam!"))
                return redirect('testee_score_list', exam_type=exam.exam_type)

            elif now_time > exam.finish_time and answer_sheet.is_tested == True:
                score = testmanager.calculate_score(exam_id, answer_sheet)
                super().exam_results(exam,score)
                messages.warning(request, 'You had not complete this exam. Your score is {}'.format(score))
                return redirect('testee_score_list', exam_type=exam.exam_type)

            exam.is_started = True
            exam.save()

        except ObjectDoesNotExist:
            messages.error(request,
                           'Exam does not exist, Exam id: {}'.format(exam_id))
            return redirect('testee_exam_list', exam_type=exam.exam_type)

        answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user)
        if answer_sheet.is_finished:
            messages.warning(request, 'You had done this exam.')
            return redirect('testee_exam_list', exam_type=exam.exam_type)
        else:
            exam = Exam.objects.get(id=exam_id)
            answer_sheet.is_tested = True
            answer_sheet.save()
            return redirect('testee_answering',
                        exam_id=exam.id,
                        answer_id=Answer.objects.filter(answer_sheet=answer_sheet)[0].id)   # transfer the first question

@permission_check(UserType.Testee)
@require_http_methods(["GET"])
def start_practice(request, exam_id):
    try:
        exam = Exam.objects.get(id=exam_id)
        now_time = datetime.now()
        
        if not exam.is_public:
            pass
        elif exam.start_time < now_time < exam.finish_time:
            pass
        elif now_time < exam.start_time:
            messages.warning(request, 'Exam does not start.')
            return redirect('testee_exam_list', exam_type=exam.exam_type)
        elif now_time > exam.finish_time:
            messages.warning(request, 'Exam had finished.')
            return redirect('testee_exam_list', exam_type=exam.exam_type)
        
        exam.is_started = True
        
        if exam.remaining_time is not None:
            exam.modified_time = now_time
            exam.finish_time = exam.modified_time + timedelta(seconds=exam.remaining_time)
        
        exam.save()

    except ObjectDoesNotExist:
        messages.error(request, 'Exam does not exist, Exam id: {}'.format(exam_id))
        return redirect('testee_exam_list', exam_type=exam.exam_type)

    try:
        answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user)
        if answer_sheet.is_finished:
            messages.warning(request, 'You had done this exam.')
            return redirect('testee_exam_list', exam_type=exam.exam_type)
    except ObjectDoesNotExist:
        answer_sheet = AnswerSheet.objects.create(exam=exam, user=request.user)
        answer_sheet.is_tested = True
        answer_sheet.save()

        all_questions = list(exam.testpaper.question_list.all())
        random.shuffle(all_questions)

        for question in all_questions:
            Answer.objects.create(answer_sheet=answer_sheet, question=question)

    return redirect('testee_answering',
                        exam_id=exam.id,
                        answer_id=Answer.objects.filter(answer_sheet=answer_sheet)[0].id)   # transfer the first question

@method_decorator(permission_check(UserType.Testee),name='get')
class AnsweringView(View,OnlineUserStat):
    
    template_name='testee/answering.html'
    
    def do_content_works(self,request,exam_id,answer_id):
        exam = Exam.objects.get(id=exam_id)
        if exam.finish_time is None:
            deadline = None
        else:
            deadline = exam.finish_time.strftime("%Y-%m-%dT%H:%M:%S")

        if exam.exam_type == 1:
            hour = exam.finish_time.hour
            minute = exam.finish_time.minute
        try:
            exam = Exam.objects.get(id=exam_id)
            answer = Answer.objects.get(id=answer_id)
            selected_answer = Answer.objects.get(id=answer_id)
            answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user)
            answers = answer_sheet.answer_set.all()
            if answer_sheet.is_finished:
                messages.warning(request, _("You had completed this exam"))
                return redirect('testee_score_list', exam_type=exam.exam_type)
            if answer not in answer_sheet.answer_set.all():
                messages.warning(request, 'Not your answer: {}'.format(answer_id))
                return redirect('testee_answering',
                            exam_id=exam.id,
                            answer_id=list(answer_sheet.answer_set.all())[0].id)

        except ObjectDoesNotExist:
            messages.error(request,'Answer id error, answer id: {}'.format(answer_id))
            return redirect('testee_exam_list', exam_type=exam.exam_type)
        answer_count  = len(Answer.objects.filter(answer_sheet=answer_sheet).filter(selected=-1))
        return dict(exam=exam,
                    answer=answer,
                    selected_answer=selected_answer,
                    answer_sheet=answer_sheet,
                    answers=answers,
                    deadline=deadline)
    
    def post(self,request,exam_id,answer_id):
        exam=Exam.objects.get(id=exam_id)
        answering_ans = Answer.objects.get(id=answer_id)
        selected_answer = request.POST.get('answer_{}'.format(answer_id))
        answer_sheet=AnswerSheet.objects.get(exam=exam,user=request.user)
    
        answering_ans.selected = selected_answer
        answering_ans.save()

        answer_count  = len(Answer.objects.filter(answer_sheet=answer_sheet).filter(selected=-1))
        # context={'exam':exam,
        #          'selected_answer':selected_answer,
        #          'answer_sheet':answer_sheet}

        #還有題目尚未回答
        #answer_count == 0 : 所有題目已答題
        #answer_count != 0 : 還有題目未答題  
        if answer_count != 0:
            the_next_question = list(Answer.objects.filter(answer_sheet=answer_sheet).filter(selected=-1)).pop(0)
            return redirect('testee_answering',
                            exam_id=exam_id,
                            answer_id=the_next_question.id)

        else:
            return redirect('testee_answering',
                            exam_id=exam_id,
                            answer_id=answer_id)
  

# @permission_check(UserType.Testee)
# @require_http_methods(["GET", "POST"])
# def unmodified_answering(request, exam_id, answer_id):
#     exam = Exam.objects.get(id=exam_id)
#     if exam.exam_type == 1:
#         hour = exam.finish_time.hour
#         minute = exam.finish_time.minute
#     try:
#         exam = Exam.objects.get(id=exam_id)
#         answer = Answer.objects.get(id=answer_id)
#         answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user)
#         if answer_sheet.is_finished:
#             messages.warning(request, "You had completed this exam.")
#             return redirect('testee_score_list')
#         if answer not in answer_sheet.answer_set.all():
#             messages.warning(request, 'Not your answer: {}'.format(answer_id))
#             return redirect('testee_answering',
#                                     exam_id=exam.id,
#                                     answer_id=list(
#                                         answer_sheet.answer_set.all())[0].id)
#
#     except ObjectDoesNotExist:
#         messages.error(request,
#                                'Answer id error, answer id: {}'.format(answer_id))
#         return redirect('testee_exam_list')
#
#     try:
#         the_next_question = Answer.objects.filter(
#                     answer_sheet=answer_sheet).filter(selected=-1)[0]
#
#         if answer.selected != -1:
#             messages.warning(
#                         request,
#                         'This question had answered, please answer from answer id: {}'.
#                         format(the_next_question.id))
#             return redirect('testee_answering',
#                                     exam_id=exam_id,
#                                     answer_id=the_next_question.id)
#
#     except:
#         messages.success(request, _('You had finished the exam.'))
#         score = testmanager.calculate_score(exam.id, answer_sheet)
#         return redirect('testee_exam_list')
#
#     if request.method == 'POST':
#
#         answering_ans = Answer.objects.get(id=answer_id)
#         selected_answer = request.POST.get('answer_{}'.format(answer_id))
#
#         answering_ans.selected = selected_answer
#         answering_ans.save()
#
#         if len(
#                         Answer.objects.filter(answer_sheet=answer_sheet).filter(
#                             selected=-1)) == 0:
#             messages.success(request, _('You had finished the exam.'))
#             score = testmanager.calculate_score(exam.id, answer_sheet)
#             return redirect('testee_score_list')
#         else:
#             the_next_question = list(
#                         Answer.objects.filter(answer_sheet=answer_sheet).filter(
#                             selected=-1)).pop(0)
#
#         answers = answer_sheet.answer_set.all()
#
#         return redirect('testee_answering',
#                                 exam_id=exam_id,
#                                 answer_id=the_next_question.id)
#     else:
#         answers = answer_sheet.answer_set.all()
#
#         return render(request, 'testee/answering.html', locals())


# @permission_check(UserType.Testee)
# @require_http_methods(["GET", "POST"])
# def submit_answersheet(request, exam_id):
#     exam = Exam.objects.get(id=exam_id)
#     answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user)
#     score = testmanager.calculate_score(exam.id, answer_sheet)
    
#     #更新user在某類型(exam_type)考試中合格次數             
#     score_record = ScoreRecord.objects.get(user=request.user.id, exam_type=exam.exam_type)
#     score_record.qualified_times = len(AnswerSheet.objects.all().filter(user=request.user, exam__exam_type=exam.exam_type, score__gte=60))   #score >= 60 data
#     score_record.unqualified_times = len(AnswerSheet.objects.all().filter(user=request.user, exam__exam_type=exam.exam_type, score__lt=60))   #score < 60 data
#     score_record.save()

#     #record Exam qualified_num
#     if exam.exam_type == 1:

#         # if ExamResult.objects.filter(exam=exam_id).exists() == False:
#         #     ExamResult.objects.create(exam=exam,testee_num=len(exam.testeeList.all()))
#             # print(ExamResult.objects.all())
#         exam_result =  ExamResult.objects.get(exam=exam_id)
#         print(exam_result)
#         testee_scores = exam_result.testee_score
#         testee_grades = exam_result.testee_grade
#         exam_result.tested += 1
#         exam_result.not_tested_num = len(exam.testeeList.all())-exam_result.tested
#         exam_result.range_times[score//10-1] += 1
        
#         def grade(score, breakpoints=[60,70,80,90], grades='FDCBA'):
#             i = bisect.bisect(breakpoints, score)
#             return grades[i]
        
#         testees = exam.testeeList.all()
#         for testee in testees:
#             try:
#                 answer_sheet = AnswerSheet.objects.get(exam=exam, user_id=testee.id)
#                 if answer_sheet.score >= 60:
#                     exam_result.qualified_num += 1
#                     testee_scores.append(answer_sheet.score)
#                     testee_grades.append(grade(score))
#                 elif answer_sheet.score < 60:
#                     exam_result.unqualified_num += 1
#                     testee_scores.append(answer_sheet.score)
#                     testee_grades.append(grade(score))
#             except ObjectDoesNotExist:
#                 testee_scores.append(None)
#                 testee_grades.append(grade(0))
#             except TypeError:
#                 messages.warning(request, 'The test is finished, but not all testee had submitted test paper.')
#                 return redirect('exam_score_list')
#         exam_result.save()
    
#     messages.success(request, _('You had finished the exam.'))
#     request_achievement_signal.send(sender='AnswerSheet', user = request.user.id, score = score, exam_type = exam.exam_type)
#     return redirect('testee_score_list', exam_type = exam.exam_type)
@method_decorator(permission_check(UserType.Testee),name='get')
@method_decorator(require_http_methods(["GET", "POST"]),name='get')
class SubmitAnswersheet(View,IntegrateTestResults):
    
    def get(self,request,exam_id):
        exam = Exam.objects.get(id=exam_id)
        answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user)
        score = testmanager.calculate_score(exam.id, answer_sheet)
        
    #更新user在某類型(exam_type)考試中合格次數             
        super().score_records(request.user,exam.exam_type)
        
    # #record Exam qualified_num
        if exam.exam_type == 1:
            super().exam_results(exam,score)
    #     # if ExamResult.objects.filter(exam=exam_id).exists() == False:
    #     #     ExamResult.objects.create(exam=exam,testee_num=len(exam.testeeList.all()))
    #         # print(ExamResult.objects.all())
    #     exam_result =  ExamResult.objects.get(exam=exam_id)
    #     print(exam_result)
    #     testee_scores = exam_result.testee_score
    #     testee_grades = exam_result.testee_grade
    #     exam_result.tested += 1
    #     exam_result.not_tested_num = len(exam.testeeList.all())-exam_result.tested
    #     exam_result.range_times[score//10-1] += 1
        
    #     def grade(score, breakpoints=[60,70,80,90], grades='FDCBA'):
    #         i = bisect.bisect(breakpoints, score)
    #         return grades[i]
        
    #     testees = exam.testeeList.all()
    #     for testee in testees:
    #         try:
    #             answer_sheet = AnswerSheet.objects.get(exam=exam, user_id=testee.id)
    #             if answer_sheet.score >= 60:
    #                 exam_result.qualified_num += 1
    #                 testee_scores.append(answer_sheet.score)
    #                 testee_grades.append(grade(score))
    #             elif answer_sheet.score < 60:
    #                 exam_result.unqualified_num += 1
    #                 testee_scores.append(answer_sheet.score)
    #                 testee_grades.append(grade(score))
    #         except ObjectDoesNotExist:
    #             testee_scores.append(None)
    #             testee_grades.append(grade(0))
    #         except TypeError:
    #             messages.warning(request, 'The test is finished, but not all testee had submitted test paper.')
    #             return redirect('exam_score_list')
    #     exam_result.save()
    
        messages.success(request, _('You had finished the exam.'))
        request_achievement_signal.send(sender='AnswerSheet', user = request.user.id, score = score, exam_type = exam.exam_type)
        return redirect('testee_score_list', exam_type = exam.exam_type)

# Settle exam score directly.
# @permission_check(UserType.Testee)
# def settle(request, exam_id):
#     try:
#         exam = Exam.objects.get(id=exam_id)
#         try:
#             answer_sheet = AnswerSheet.objects.get(exam=exam,
#                                                    user=request.user)
#             score = testmanager.calculate_score(exam.id, answer_sheet)
#             request_achievement_signal.send(sender='AnswerSheet', user = request.user.id, score = score, exam_type = exam.exam_type)
            
#             score_record = ScoreRecord.objects.get(user=request.user.id, exam_type=exam.exam_type)
#             score_record.qualified_times = len(AnswerSheet.objects.all().filter(user=request.user, exam__exam_type=exam.exam_type, score__gte=60))   #score >= 60 data
#             score_record.unqualified_times = len(AnswerSheet.objects.all().filter(user=request.user, exam__exam_type=exam.exam_type, score__lt=60))   #score < 60 data
#             score_record.save()
            
#             messages.success(
#                 request,
#                 "You have settled this exam score directly. You got {} point in this exam."
#                 .format(score))
            
#             return redirect('testee_score_list', exam_type=exam.exam_type)  
        
#         except ObjectDoesNotExist:
#             messages.error(request,
#                            "Query failed, you may not start this exam.")
#             return redirect('testee_exam_list')

#     except ObjectDoesNotExist:
#         messages.error(request, "Query failed, Exam doesn't exist.")
#         return redirect('testee_exam_list')
    
@method_decorator(permission_check(UserType.Testee),name='get')
class Settle(View,IntegrateTestResults):
    
    def get(self,request,exam_id):
        try:
            exam = Exam.objects.get(id=exam_id)
            
            try:
                answer_sheet = AnswerSheet.objects.get(exam=exam,
                                                       user=request.user)
                score = testmanager.calculate_score(exam.id, answer_sheet)
                request_achievement_signal.send(sender='AnswerSheet', user = request.user.id, score = score, exam_type = exam.exam_type)
            
                super().score_records(request.user,exam.exam_type)
            
                messages.success(request,
                                "You have settled this exam score directly. You got {} point in this exam.".format(score))
                return redirect('testee_score_list', exam_type=exam.exam_type)  
        
            except ObjectDoesNotExist:
                messages.error(request,
                               "Query failed, you may not start this exam.")
                return redirect('testee_exam_list',exam_type=exam.exam_type)

        except ObjectDoesNotExist:
            messages.error(request, "Query failed, Exam doesn't exist.")
            return redirect('testee_exam_list',exam_type=exam.exam_type)


@method_decorator(login_required,name='get')
class ReportQuestionView(View,OnlineUserStat):
    
    template_name='testee/report_question.html'
    
    def do_content_works(self,request,question_id):
        categories = ReportCategory.objects.all()
        reported_question = Question.objects.get(id=question_id)
        if reported_question.state == 4:
            messages.warning(request,
                             "This question had been reported, thank you.")
            return redirect(request.META.get('HTTP_REFERER'))
        return dict(categories=categories,reported_question=reported_question)
    def post(self,request,question_id):
        try:
            category = ReportCategory.objects.get(
                id=int(request.POST.get('category')))
            Question.objects.filter(id=question_id).update(state=4)
            reported_question = Question.objects.get(id=question_id)

            supplement_note = request.POST.get('supplement_note')

            question_report = Report.objects.create(
                staff_notification=True,
                category=category,
                question=reported_question,
                supplement_note=supplement_note,
                created_by=request.user,
                state=1)

            question_report.save()

            messages.success(request,'Thanks for your report, we will review this question as soon as possible.')

            return redirect('testee_score_list', exam_type=1)

        except ObjectDoesNotExist:
            messages.error(request, 'Category or Question does not exist.')
            categories = ReportCategory.objects.all()
            context={'categories':categories,'reported_question':reported_question}
            return render(request, 'testee/report_question.html', context)
        
class WorldLibrary(View,OnlineUserStat):
    
    template_name='testee/word_library.html'
    
    def do_content_works(self,request):
        word_list = Word_library.objects.all()
        return dict(word_list=word_list)

class WorldLibraryCreate(View,OnlineUserStat):
    
    template_name='testee/word_library_create.html'
    
    def do_content_works(self,request):
        return {}
    def post(self,request):
        if Word_library.objects.all().filter(words=request.POST.get('word_english')):
            messages.error(request,'exist word')
            return redirect('word_library')
        else:
            word_english = request.POST.get('word_english')
            word_chinese = request.POST.get('word_chinese')
            Word = Word_library.objects.create(words = word_english,translations = word_chinese)
            Word.save()
            messages.success(request,'Word Added successful.')
            return redirect('word_library')
        

def word_library_del(request,words):
    try:
        word = Word_library.objects.get(words=words)       
        word.delete()
        messages.success(request, ("Successfully deleted word"))
        return redirect('word_library')
    except ObjectDoesNotExist:
        messages.error(request,'error')
        return redirect('word_library')

class WorldLibraryEdit(View,OnlineUserStat):
    
    template_name='testee/word_library_edit.html'
    
    def do_content_works(self,request,words,translations):
        word = Word_library.objects.get(words=words)
        translate = Word_library.objects.get(translations=translations) 
        return dict(words=word,translations=translate)
    def post(self,request,words,translations):
        word = Word_library.objects.get(words=words)
        translate = Word_library.objects.get(translations=translations) 
        try:
            word_english=request.POST.get('word_english')
            word_chinese=request.POST.get('word_chinese')
            word.words = word_english
            word.translations = word_chinese
            word.save()
            return redirect('word_library')
        except ObjectDoesNotExist:
            messages.error(request,'error')
            return redirect('word_library')
                   
