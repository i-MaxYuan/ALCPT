import json
from datetime import datetime
from math import ceil
from random import sample

from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from django.views.decorators.http import require_http_methods
from django.utils import timezone

from .models import Exam, TestPaper, Question
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType, QuestionTypeCounts, QuestionType, ExamType
from .managerfuncs import exammanager


@permission_check(UserType.ExamManager)
@require_http_methods(["GET"])
def index(request):
    try:
        page = int(request.GET.get('page', 0))

    except ValueError:
        page = 0

    exams = Exam.objects.filter(type=ExamType.Exam.value[0]).order_by('-create_time')

    for exam in exams:
        exam.start_time = timezone.localtime(exam.start_time)

    num_pages = ceil(len(exams) / 10)

    if page and page >= 0:
        exams = exams[page * 10: page * 10 + 10]

    data = {
        'exam': exams,
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'exam/exam_list.html', data)


@permission_check(UserType.ExamManager)
@require_http_methods(["GET", "POST"])
def create_exam(request):
    if request.method == 'POST':
        name = request.POST.get('name')

        try:
            start_time = datetime.strptime(request.POST.get('start_time'), '%Y/%m/%d %H:%M')

        except TypeError:
            raise ArgumentError('Missing create time.')

        except ValueError:
            raise IllegalArgumentError('Illegal time format.')

        try:
            duration = request.POST.get('duration')

        except TypeError:
            raise ArgumentError('Missing duration')

        except ValueError:
            raise IllegalArgumentError('The "duration" must be an integer.')

        try:
            testpaper = request.POST.get('testpaper')

        except TypeError:
            raise ArgumentError('Missing duration')

        existence = Exam.objects.get(name=name)

        if existence:
            messages.error('The Exam\'s name has been used.Please change the name.')
            return render(request, 'exam/exam_create.html')

        else:
            exam = Exam.objects.create(name=name,
                                       type=ExamType.Exam.value[0],
                                       testpaper=testpaper,
                                       start_time=start_time,
                                       duration=duration)

        return redirect('/exam/{}/edit'.format(exam.id))

    else:
        return render(request, 'exam/exam_create.html')


@permission_check(UserType.ExamManager)
@require_http_methods(["GET", "POST"])
def edit_exam(request, exam_id: int):
    try:
        exam = Exam.objects.get(id=exam_id)

    except ObjectDoesNotExist:
        raise ObjectNotFoundError('Cannot find exam {}'.format(exam_id))

    if request.method == 'POST':
        name = request.POST.get('name')

        try:
            start_time = datetime.strptime(request.POST.get('start_time'), '%Y/%m/%d %H:%M')

        except TypeError:
            raise ArgumentError('Missing create time.')

        except ValueError:
            raise IllegalArgumentError('Illegal time format.')

        try:
            duration = request.POST.get('duration')

        except TypeError:
            raise ArgumentError('Missing duration')

        except ValueError:
            raise IllegalArgumentError('The "duration" must be an integer.')

        try:
            testpaper = TestPaper.objects.get(name=request.POST.get('testpaper'))

        except TypeError:
            raise ArgumentError('Missing duration')

        exam.name = name
        exam.start_time = start_time
        exam.duration = duration
        exam.testpaper = testpaper
        exam.save()

        messages.success(request, "Successfully update exam :{}.".format(exam.name))

        return redirect('/exam')

    else:
        return render(request, 'manager/exam/edit_exam.html', locals())


@permission_check(UserType.ExamManager)
@require_http_methods(["GET"])
def testerpaper_index(request):
    return render(request, 'exam/test')


@permission_check(UserType.ExamManager)
@require_http_methods(["GET", "POST"])
def create_paper(request):
    if request.method == 'POST':
        name = request.POST.get('name')

        try:
            questions = request.POST.get('questions')

        except TypeError:
            raise ArgumentError('No any question in testpaper')

        existence = TestPaper.objects.get(name=name)

        if existence:
            messages.error('The Exam\'s name has been used.Please change the name.')
            return render(request, 'paper_create.html')

        else:
            testpaper = TestPaper.objects.create(name=name,
                                                 questions=questions)

        return redirect('/exam/{}/paper_edit'.format(testpaper.id))

    else:
        return render(request, 'manager/exam/create_paper.html')


@permission_check(UserType.ExamManager)
@require_http_methods(["GET", "POST"])
def pick_question(request, testpaper_id: int, question_type: int):
    try:
        testpaper = TestPaper.objects.get(id=testpaper_id)
        testpaper.questions = json.loads(testpaper.questions)

    except ObjectDoesNotExist:
        raise ObjectNotFoundError('Cannot find testpaper {}'.format(testpaper_id))

    selected_questions = testpaper.question_set.filter(question_type=question_type)
    reach_limit = selected_questions.count() >= QuestionTypeCounts.Exam.value[0][question_type - 1]

    if request.method == 'POST':
        try:
            question = Question.objects.get(id=request.POST.get('question_id'), enable=True)

        except TypeError:
            raise ArgumentError('Missing question_id')

        except ValueError:
            raise IllegalArgumentError('question_id is not int')

        except ObjectDoesNotExist:
            raise ObjectNotFoundError('Cannot find question')

        if question.question_type != question_type:
            raise IllegalArgumentError('question_type does match category.')

        try:
            testpaper.question_set.get(id=question.id)
            testpaper.question_set.remove(question)
            messages.success('Remove question id={} sucessfully.'.format(question.id))

        except ObjectDoesNotExist:
            if reach_limit:
                raise IllegalArgumentError('Reach the limit num of this type:{} in this exam.'.format(question.question_type))

            testpaper.qusetion_set.add(question)
            messages.success(request, 'Select question id={} sucessfully.'.format(question.id))

    selected_questions = testpaper.question_set.filter(question_type=question_type)
    reach_limit = selected_questions.count() >= QuestionTypeCounts.Exam.value[0][question_type - 1]

    testpaper.enable = testpaper.question_set.count() >= sum(QuestionTypeCounts.Exam.value[0])
    testpaper.save()

    request.DATA = (request.GET if request.method == 'GET' else request.POST)

    try:
        page = int(request.DATA.get('page', 0))

    except ValueError:
        page = 0

    try:
        status = int(request.DATA.get('status', 0))

    except ValueError:
        status = 0

    exam = testpaper if status is 1 else None

    if exam:
        questions = exam.question_set

    else:
        questions = Question.objects.filter(question_type=question_type)

    if page >= 0:
        num_pages = ceil(questions.count() / 10)
        questions = questions[page * 10: page * 10 + 10]

    else:
        num_pages = 1

    for question in questions:
        question.selected = question in selected_questions
        question.option = json.loads(question.option)

    data = {
        'testpaper': testpaper,
        'question_type': question_type,
        'reach_limit': reach_limit,
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'manager/exam/pick_question.html', data)


@permission_check(UserType.ExamManager)
@require_http_methods(["GET"])
def auto_pick_question(request, testpaper_id: int, question_type: int):
    try:
        testpaper = TestPaper.objects.get(id=testpaper_id)

    except ObjectDoesNotExist:
        raise ObjectNotFoundError('Cannot find testpaper {}'.format(testpaper_id))

    for q_type in QuestionType.__members__.values():
        if q_type.value[0] == question_type:
            question_type = q_type

    if type(question_type) is int:
        raise IllegalArgumentError('question_type does match category.')

    selected_num = exammanager.random_select(types_counts=QuestionTypeCounts.Exam.value[0],
                                             question_type=question_type,
                                             testpaper=testpaper)

    if selected_num:
        messages.success(request, 'Auto picked questions successfully.')

    else:
        messages.warning(request, 'Auto pick failed.')

    return redirect('manager/exam/{}/edit'.format(testpaper_id))