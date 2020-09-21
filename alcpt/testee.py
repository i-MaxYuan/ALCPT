import json
import random
from datetime import datetime

from django.shortcuts import render, redirect
from django.http.response import HttpResponse
from django.core.exceptions import ObjectDoesNotExist
from django.contrib import messages
from django.views.decorators.http import require_http_methods
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage

from .models import Question, AnswerSheet, Student, User, Exam, TestPaper, Answer, ReportCategory, Report
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType, QuestionType, ExamType
from .managerfuncs import viewer, practicemanager, testmanager

import plotly.offline as pyo
import plotly.graph_objs as go
import pandas as pd


@permission_check(UserType.Testee)
def exam_list(request):
    examList = []
    exams = Exam.objects.filter(is_public=True).filter(testeeList=request.user)
    for exam in exams:
        examList.append(exam)

    practiceList = []
    practices = Exam.objects.filter(is_public=False).filter(created_by=request.user)
    for practice in practices:
            practiceList.append(practice)

    return render(request, 'testee/exam_list.html', locals())


@permission_check(UserType.Testee)
@require_http_methods(["GET"])
def score_list(request):
    answer_sheets = AnswerSheet.objects.all().filter(user=request.user)
    answer_sheets_all = answer_sheets.order_by('-exam__created_time')
    answer_sheets_reading = answer_sheets.filter(exam__name__contains="閱讀練習")
    answer_sheets_listening = answer_sheets.filter(exam__name__contains="聽力練習")
    answer_sheets_exam = answer_sheets.exclude(exam__name__contains="閱讀練習").exclude(exam__name__contains="聽力練習")


    page = request.GET.get('page', 1)
    paginator = Paginator(answer_sheets, 10)

    EXAM_QUALIFICATION = {'qualified': 0,'unqualified': 0}
    READING_QUALIFICATION = {'qualified': 0,'unqualified': 0}
    LISTENING_QUALIFICATION = {'qualified': 0,'unqualified': 0}

    EXAM_SCORE_RANGE = {'one': 0,'two': 0,'three': 0,'four': 0,'five': 0,'six': 0,'seven': 0,'eight': 0,'nine': 0,'ten': 0}
    READING_SCORE_RANGE = {'one': 0,'two': 0,'three': 0,'four': 0,'five': 0,'six': 0,'seven': 0,'eight': 0,'nine': 0,'ten': 0}
    LISTENING_SCORE_RANGE = {'one': 0,'two': 0,'three': 0,'four': 0,'five': 0,'six': 0,'seven': 0,'eight': 0,'nine': 0,'ten': 0}

    #EXAM
    #計算是否及格
    for answer_sheet in answer_sheets_exam:
        if answer_sheet.score is None:
            pass
        elif answer_sheet.score >= 60:
            EXAM_QUALIFICATION['qualified'] += 1
        else:
            EXAM_QUALIFICATION['unqualified'] += 1

    #計算成績分布
    for answer_sheet in answer_sheets_exam:
        count = 0
        if answer_sheet.score is None:
            pass
        else:
            if count <= answer_sheet.score <= count + 10:
                EXAM_SCORE_RANGE['one'] += 1
            else:
                count += 10
                for name in list(EXAM_SCORE_RANGE.keys())[1:]:
                    if count < answer_sheet.score <= count + 10:
                        EXAM_SCORE_RANGE[name] += 1
                        break
                    else:
                        count += 10

    #READING
    #計算是否及格
    for answer_sheet in answer_sheets_reading:
        if answer_sheet.score is None:
            pass
        elif answer_sheet.score >= 60:
            READING_QUALIFICATION['qualified'] += 1
        else:
            READING_QUALIFICATION['unqualified'] += 1

    #計算成績分布
    for answer_sheet in answer_sheets_reading:
        count = 0
        if answer_sheet.score is None:
            pass
        else:
            if count <= answer_sheet.score <= count + 10:
                READING_SCORE_RANGE['one'] += 1
            else:
                count += 10
                for name in list(READING_SCORE_RANGE.keys())[1:]:
                    if count < answer_sheet.score <= count + 10:
                        READING_SCORE_RANGE[name] += 1
                        break
                    else:
                        count += 10
    #LISTENING
    #計算是否及格
    for answer_sheet in answer_sheets_listening:
        if answer_sheet.score is None:
            pass
        elif answer_sheet.score >= 60:
            LISTENING_QUALIFICATION['qualified'] += 1
        else:
            LISTENING_QUALIFICATION['unqualified'] += 1

    #計算成績分布
    for answer_sheet in answer_sheets_listening:
        count = 0
        if answer_sheet.score is None:
            pass
        else:
            if count <= answer_sheet.score <= count + 10:
                LISTENING_SCORE_RANGE['one'] += 1
            else:
                count += 10
                for name in list(LISTENING_SCORE_RANGE.keys())[1:]:
                    if count < answer_sheet.score <= count + 10:
                        LISTENING_SCORE_RANGE[name] += 1
                        break
                    else:
                        count += 10
    # xaxis : Score
    # yaxis : Times
    # Line chart
    x_data = [ str(num) for num in range(10, 101, 10)]
    y_exam_data = list(EXAM_SCORE_RANGE.values())
    y_reading_data = list(READING_SCORE_RANGE.values())
    y_listening_data = list(LISTENING_SCORE_RANGE.values())
    color = ['#FF0000','#FF5B00','#FF7900','#FFB600','#FFE700','#E1FF00','#B6FF00','#86FF00','#55FF00','#18FF00']

    #Exam
    df = pd.DataFrame(list(zip(x_data,y_exam_data)))

    df['color'] = color
    df = df.rename(columns={0: 'score', 1: 'time'})


    trace = go.Bar(x=df['score'], y=df['time'],
                opacity=0.8,
                marker_color=df['color'])
    data=[trace]
    layout = go.Layout(
        title='Exam考試總成績分佈',
        xaxis = dict(title = '成績'),
        yaxis = dict(title = '考試成績範圍次數')
    )
    fig = go.Figure(data=data, layout=layout)
    exam_bar_chart = pyo.plot(fig, output_type='div')

    #Reading
    df = pd.DataFrame(list(zip(x_data,y_reading_data)))

    df['color'] = color
    df = df.rename(columns={0: 'score', 1: 'time'})


    trace = go.Bar(x=df['score'], y=df['time'],
                opacity=0.8,
                marker_color=df['color'])
    data=[trace]
    layout = go.Layout(
        title='Reading練習總成績分佈',
        xaxis = dict(title = '成績'),
        yaxis = dict(title = '考試成績範圍次數')
    )
    fig = go.Figure(data=data, layout=layout)
    reading_bar_chart = pyo.plot(fig, output_type='div')

    #Listening
    df = pd.DataFrame(list(zip(x_data,y_listening_data)))

    df['color'] = color
    df = df.rename(columns={0: 'score', 1: 'time'})


    trace = go.Bar(x=df['score'], y=df['time'],
                opacity=0.8,
                marker_color=df['color'])
    data=[trace]
    layout = go.Layout(
        title='Listeing練習總成績分佈',
        xaxis = dict(title = '成績'),
        yaxis = dict(title = '考試成績範圍次數')
    )
    fig = go.Figure(data=data, layout=layout)
    listening_bar_chart = pyo.plot(fig, output_type='div')

    # Pie chart
    qualify = ['合格', '不合格']
    colors = ['green', 'red']
    #Exam
    trace = go.Pie(labels = qualify,
                   values = list(EXAM_QUALIFICATION.values()),
                   hole = .4,
                   type= 'pie')

    data = [trace]
    layout = go.Layout({
        'title': 'Exam考試合格率分析',
        'annotations': [
             {
                'font': {
                   'size': 20
                },
                'showarrow': False,
                'text': '合格率',
             },
          ]
        }
    )
    fig = go.Figure(data=data, layout=layout)
    fig.update_traces(marker=dict(colors=colors))
    exam_pie_chart = pyo.plot(fig, output_type='div')
    #Reading
    trace = go.Pie(labels = qualify,
                   values = list(READING_QUALIFICATION.values()),
                   hole = .4,
                   type= 'pie')

    data = [trace]
    layout = go.Layout({
        'title': 'Reading練習合格率分析',
        'annotations': [
             {
                'font': {
                   'size': 20
                },
                'showarrow': False,
                'text': '合格率',
             },
          ]
        }
    )
    fig = go.Figure(data=data, layout=layout)
    fig.update_traces(marker=dict(colors=colors))
    reading_pie_chart = pyo.plot(fig, output_type='div')

    #Listening
    trace = go.Pie(labels = qualify,
                   values = list(LISTENING_QUALIFICATION.values()),
                   hole = .4,
                   type= 'pie')

    data = [trace]
    layout = go.Layout({
        'title': 'Listening練習合格率分析',
        'annotations': [
             {
                'font': {
                   'size': 20
                },
                'showarrow': False,
                'text': '合格率',
             },
          ]
        }
    )
    fig = go.Figure(data=data, layout=layout)
    fig.update_traces(marker=dict(colors=colors))
    listening_pie_chart = pyo.plot(fig, output_type='div')


    try:
        answersheetList = paginator.page(page)
    except PageNotAnInteger:
        answersheetList = paginator.page(1)
    except EmptyPage:
        answersheetList = paginator.page(paginator.num_pages)

    return render(request, 'testee/score_list.html', locals())


@permission_check(UserType.Testee)
@require_http_methods(["GET", "POST"])
def practice_create(request, kind):
    if request.method == 'POST':
        user = User.objects.get(id=request.user.id)

        question_num = int(request.POST.get('question_num', ))

        practice_type = ExamType.Listening if kind == 'listening' else ExamType.Reading

        selected_types = request.POST.getlist('question_type',)     # getlist's element type is str.
        question_types = []
        for item in selected_types:                                 # Here, it turn all elements to int
            question_types.append(int(item))

        q_types = []    # element's type is QuestionType
        for valid_type in QuestionType:
            if valid_type.value[0] in question_types:
                q_types.append(valid_type)

        practice_exam = practicemanager.create_practice(user=user, practice_type=practice_type,
                                                        question_types=selected_types, question_num=question_num)

        messages.success(request, 'Create successfully, {}'.format(practice_exam))
        return redirect('testee_exam_list')
    else:
        return render(request, 'practice/select.html', locals())


@permission_check(UserType.Testee)
def view_answersheet_content(request, answersheet_id):
    try:
        answersheet = AnswerSheet.objects.get(id=answersheet_id)
        if answersheet.exam.is_public:
            if datetime.now() < answersheet.exam.finish_time:
                messages.warning(request, 'This exam does not finish.')
                return redirect('testee_score_list')

    except ObjectDoesNotExist:
        messages.error(request, 'Answer sheet does not exist, answersheet_id: {}'.format(answersheet_id))
        return redirect('testee_score_list')

    if answersheet.is_finished:
        #return 那題題目 is True or False 的 list
        answer = answersheet.answer_set.all()
        result_list = viewer.question_correction(answersheet)
        answers_results = zip(answer, result_list)

        return render(request, 'testee/answersheet_content.html', locals())
    else:
        messages.warning(request, 'Does not finished this practice. Reject your request.')
        return redirect('testee_score_list')

@permission_check(UserType.Testee)
def favorite_question(request, question_id, answersheet_id):
    try:
        favorite_question = Question.objects.get(id=question_id)
        if favorite_question.is_favorite == False:
            favorite_question.is_favorite = True
            favorite_question.save()
            messages.success(request, 'Question has added to your favorite!')
            return redirect('view_answersheet_content', answersheet_id)
        else:
            favorite_question.is_favorite = False
            favorite_question.save()
            messages.warning(request, 'Question has removed from your favorite...')
            return redirect('view_answersheet_content', answersheet_id)
    except ObjectDoesNotExist:
        messages.warning(request, 'Question has not found!')
        return redirect('view_answersheet_content', answersheet_id)
    return redirect('view_answersheet_content', answersheet_id)


@permission_check(UserType.Testee)
@require_http_methods(["GET"])
def start_exam(request, exam_id):
    try:
        exam = Exam.objects.get(id=exam_id)

        now_time = datetime.now()
        if not exam.is_public:
            pass
        elif exam.start_time < now_time < exam.finish_time:
            pass
        elif now_time < exam.start_time:
            messages.warning(request, 'Exam does not start.')
            return redirect('testee_exam_list')
        elif now_time > exam.finish_time:
            messages.warning(request, 'Exam had finished.')
            return redirect('testee_exam_list')

    except ObjectDoesNotExist:
        messages.error(request, 'Exam does not exist, Exam id: {}'.format(exam_id))
        return redirect('testee_exam_list')

    try:
        answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user)
        if answer_sheet.is_finished:
            messages.warning(request, 'You had done this exam.')
            return redirect('testee_exam_list')
    except ObjectDoesNotExist:
        answer_sheet = AnswerSheet.objects.create(exam=exam, user=request.user)

        all_questions = list(exam.testpaper.question_list.all())
        random.shuffle(all_questions)

        for question in all_questions:
            Answer.objects.create(answer_sheet=answer_sheet, question=question)

    return redirect('testee_answering',
                    exam_id=exam.id,
                    answer_id=Answer.objects.filter(answer_sheet=answer_sheet)[0].id)   # transfer the first question

@permission_check(UserType.Testee)
@require_http_methods(["GET", "POST"])
def answering(request, exam_id, answer_id):
    exam = Exam.objects.get(id=exam_id)
    if exam.exam_type == 1:
        hour = exam.finish_time.hour
        minute = exam.finish_time.minute
    try:
        exam = Exam.objects.get(id=exam_id)
        answer = Answer.objects.get(id=answer_id)
        answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user)
        if answer_sheet.is_finished:
            messages.warning(request, "You had completed this exam.")
            return redirect('testee_score_list')
        if answer not in answer_sheet.answer_set.all():
            messages.warning(request, 'Not your answer: {}'.format(answer_id))
            return redirect('testee_answering', exam_id=exam.id, answer_id=list(answer_sheet.answer_set.all())[0].id)

    except ObjectDoesNotExist:
        messages.error(request, 'Answer id error, answer id: {}'.format(answer_id))
        return redirect('testee_exam_list')

    try:
        the_next_question = Answer.objects.filter(answer_sheet=answer_sheet).filter(selected=-1)[0]

        if answer.selected != -1:
            messages.warning(request, 'This question had answered, please answer from answer id: {}'.format(the_next_question.id))
            return redirect('testee_answering', exam_id=exam_id, answer_id=the_next_question.id)

    except:
        messages.success(request, 'You had finished the exam.')
        score = testmanager.calculate_score(exam.id, answer_sheet)
        return redirect('testee_exam_list')

    if request.method == 'POST':

        answering_ans = Answer.objects.get(id=answer_id)
        selected_answer = request.POST.get('answer_{}'.format(answer_id))

        answering_ans.selected = selected_answer
        answering_ans.save()

        if len(Answer.objects.filter(answer_sheet=answer_sheet).filter(selected=-1)) == 0:
            messages.success(request, 'You had finished the exam.')
            score = testmanager.calculate_score(exam.id, answer_sheet)
            return redirect('testee_score_list')
        else:
            the_next_question = list(Answer.objects.filter(answer_sheet=answer_sheet).filter(selected=-1)).pop(0)

        answers = answer_sheet.answer_set.all()

        return redirect('testee_answering', exam_id=exam_id, answer_id=the_next_question.id)
    else:
        answers = answer_sheet.answer_set.all()

        return render(request, 'testee/answering.html', locals())


# Settle exam score directly.
@permission_check(UserType.Testee)
def settle(request, exam_id):
    try:
        exam = Exam.objects.get(id=exam_id)
        try:
            answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user)
            score = testmanager.calculate_score(exam.id, answer_sheet)
            messages.success(request, "You have settled this exam score directly. You got {} point in this exam.".format(score))
            return redirect('testee_score_list')
        except ObjectDoesNotExist:
            messages.error(request, "Query failed, you may not start this exam.")
            return redirect('testee_exam_list')

    except ObjectDoesNotExist:
        messages.error(request, "Query failed, Exam doesn't exist.")
        return redirect('testee_exam_list')


@login_required
def report_question(request, question_id):
    if request.method == 'POST':
        try:
            category = ReportCategory.objects.get(id=int(request.POST.get('category')))
            Question.objects.filter(id=question_id).update(state=4)
            reported_question = Question.objects.get(id=question_id)

            supplement_note = request.POST.get('supplement_note')

            question_report = Report.objects.create(staff_notification=True,
                                                    category=category,
                                                    question=reported_question,
                                                    supplement_note=supplement_note,
                                                    created_by=request.user,
                                                    state=1)

            question_report.save()

            messages.success(request, 'Thanks for your report, we will review this question as soon as possible.')

            return redirect('testee_score_list')

        except ObjectDoesNotExist:
            messages.error(request, 'Category or Question does not exist.')
            categories = ReportCategory.objects.all()
            return render(request, 'testee/report_question.html', locals())

    else:
        categories = ReportCategory.objects.all()
        reported_question = Question.objects.get(id=question_id)
        if reported_question.state == 4:
            messages.warning(request, "This question had been reported, thank you.")
            return redirect(request.META.get('HTTP_REFERER'))
        return render(request, 'testee/report_question.html', locals())
