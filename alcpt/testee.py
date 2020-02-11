import json
import random
from datetime import datetime

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
from .managerfuncs import viewer, practicemanager, testmanager


@permission_check(UserType.Testee)
def exam_list(request):
    examList = []
    exams = Exam.objects.exclude(is_public=False)
    for exam in exams:
        try:
            if request.user.student in exam.group.member.all():
                examList.append(exam)
            else:
                pass
        except:
            pass
    practices = Exam.objects.filter(created_by=request.user)
    for practice in practices:
        if practice in examList:
            pass
        else:
            examList.append(practice)

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
        if answer_sheet.score is None:
            pass
        elif answer_sheet.score >= 60:
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
        if answersheet.exam.is_public:
            if datetime.now() < answersheet.exam.finish_time:
                messages.warning(request, 'This exam does not finish.')
                return redirect('testee_score_list')

    except ObjectDoesNotExist:
        messages.error(request, 'Answer sheet does not exist, answersheet_id: {}'.format(answersheet_id))
        return redirect('testee_score_list')

    if answersheet.is_finished:
        return render(request, 'testee/answersheet_content.html', locals())
    else:
        messages.warning(request, 'Does not finished this practice. Reject your request.')
        return redirect('testee_score_list')


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
        answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user.student)
        if answer_sheet.is_finished:
            messages.warning(request, 'You had done this exam.')
            return redirect('testee_exam_list')
    except ObjectDoesNotExist:
        answer_sheet = AnswerSheet.objects.create(exam=exam, user=request.user.student)
        all_questions = exam.testpaper.question_set.all()

        all_questions = list(all_questions)
        random.shuffle(all_questions)

        for question in all_questions:
            Answer.objects.create(answer_sheet=answer_sheet, question=question)

    return redirect('testee_answering',
                    exam_id=exam.id,
                    answer_id=Answer.objects.filter(answer_sheet=answer_sheet)[0].id)   # transfer the first question


@permission_check(UserType.Testee)
@require_http_methods(["GET", "POST"])
def answering(request, exam_id, answer_id):
    try:
        exam = Exam.objects.get(id=exam_id)
        answer = Answer.objects.get(id=answer_id)
        answer_sheet = AnswerSheet.objects.get(exam=exam, user=request.user.student)
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

        if len(Answer.objects.filter(answer_sheet=answer_sheet).filter(selected=-1)) is 0:
            messages.success(request, 'You had finished the exam.')
            score = testmanager.calculate_score(exam.id, answer_sheet)
            return redirect('testee_exam_list')
        else:
            the_next_question = list(Answer.objects.filter(answer_sheet=answer_sheet).filter(selected=-1)).pop(0)

        answers = answer_sheet.answer_set.all()

        return redirect('testee_answering', exam_id=exam_id, answer_id=the_next_question.id)
    else:
        answers = answer_sheet.answer_set.all()

        return render(request, 'testee/answering.html', locals())
