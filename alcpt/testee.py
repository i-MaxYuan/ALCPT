import json

from django.shortcuts import render, redirect
from django.http.response import HttpResponse
from django.core.exceptions import ObjectDoesNotExist
from django.contrib import messages
from django.views.decorators.http import require_http_methods
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage

from .models import Question, AnswerSheet, Student, User, Exam, TestPaper, Answer
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType, QuestionType, ExamType
from .managerfuncs import viewer, practicemanager


@permission_check(UserType.Testee)
def exam_list(request):
    exams = Exam.objects.all().filter(created_by=request.user)

    return render(request, 'testee/exam_list.html', locals())


@permission_check(UserType.Testee)
@require_http_methods(["GET"])
def score_list(request):
    qualified = 0
    unqualified = 0
    answer_sheets = AnswerSheet.objects.all().filter(user=request.user.student)
    page = request.GET.get('page', 1)
    paginator = Paginator(answer_sheets, 10)

    for answer_sheet in answer_sheets:
        if answer_sheet.score >= 60:
            qualified += 1
        else:
            unqualified += 1

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

    except ObjectDoesNotExist:
        messages.error(request, 'Answer sheet does not exist, answersheet_id: {}'.format(answersheet_id))
        return redirect('testee_score_list')

    if answersheet.is_finished:
        return render(request, 'testee/answersheet_content.html', locals())
    else:
        messages.warning(request, 'Does not finished this practice. Reject your request.')
        return redirect('testee_score_list')


@permission_check(UserType.Testee)
@require_http_methods(["GET", "POST"])
def start_practice(request, exam_id):
    try:
        exam = Exam.objects.get(id=exam_id)
    except ObjectDoesNotExist:
        messages.error(request, 'Exam does not exist, Exam id: {}'.format(exam_id))
        return redirect('testee_exam_list')

    try:
        answer_sheet = AnswerSheet.objects.get(exam=exam)
        if answer_sheet.is_finished:
            messages.warning(request, 'You had done this exam.')
            return redirect('testee_exam_list')
    except:
        answer_sheet = AnswerSheet.objects.create(exam=exam, user=request.user.student)
        all_questions = exam.testpaper.question_set.all()

        for question in all_questions:
            Answer.objects.create(answer_sheet=answer_sheet, question=question)

    if request.method == 'POST':
        for answer in answer_sheet.answer_set.all():
            answer.selected = int(request.POST.get('answer_{}'.format(answer.id),))
            answer.save()

        answer_sheet.is_finished = True
        answer_sheet.save()

        tmp = practicemanager.calculate_score(exam_id, answer_sheet)

        messages.success(request, 'Finished the practice. You got {} point.'.format(tmp))

        return redirect('testee_exam_list')

    answers = Answer.objects.filter(answer_sheet=answer_sheet)
    page = request.GET.get('page', 0)
    paginator = Paginator(answers, 10)

    try:
        answerList = paginator.page(page)
    except PageNotAnInteger:
        answerList = paginator.page(1)
    except EmptyPage:
        answerList = paginator.page(paginator.num_pages)

    return render(request, 'practice/start.html', locals())
