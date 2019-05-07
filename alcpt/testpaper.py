import json

from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist, MultipleObjectsReturned
from django.views.decorators.http import require_http_methods

from .models import TestPaper, Question
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType, QuestionTypeCounts, QuestionType
from .managerfuncs import exammanager, questionmanager


@permission_check(UserType.ExamManager)
@require_http_methods(["GET"])
def testpaper_index(request):
    try:
        page = int(request.GET.get('page', 0))

    except ValueError:
        page = 0

    keywords = {
        'name': request.GET.get('name', ''),
    }

    num_pages, testpapers = exammanager.query_testpapers(**keywords, page=page)

    data = {
        'testpapers': testpapers,
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'exam/testpaper_list.html', data)


@permission_check(UserType.ExamManager)
@require_http_methods(["GET", "POST"])
def create_testpaper(request):
    if request.method == 'POST':
        name = request.POST.get('name')

        try:
            questions = request.POST.get('questions')

        except TypeError:
            raise ArgumentError('No any question in testpaper')

        try:
            if TestPaper.objects.get(name=name):
                raise MultipleObjectsReturned('Question has existed.')

        except ObjectDoesNotExist:
            pass

        testpaper = TestPaper.objects.create(name=name, questions=json.dumps(questions))

        return redirect('/exam/testpaper/{}/edit'.format(testpaper.id))

    else:
        return render(request, 'exam/testpaper_create.html')


@permission_check(UserType.ExamManager)
@require_http_methods(["GET", "POST"])
def edit_testpaper(request, testpaper_id: int):
    try:
        testpaper = TestPaper.objects.get(id=testpaper_id)
        testpaper.questions = json.loads(testpaper.questions)

    except ObjectDoesNotExist:
        raise ObjectNotFoundError('Cannot find testpaper id={}'.format(testpaper_id))

    if request.method == 'POST':
        name = request.POST.get('name')
        try:
            questions = request.POST.get('questions')

        except TypeError:
            raise ArgumentError('Missing question')

        testpaper.name = name
        testpaper.questions = json.dumps(questions)
        testpaper.save()

        messages.success(request, "Successfully update testpaper :{}.".format(testpaper.name))

        return redirect('/exam')

    else:
        return render(request, 'exam/testpaper_edit.html', locals())


@permission_check(UserType.ExamManager)
@require_http_methods(["GET"])
def delete_testpaper(request, testpaper_id):
    try:
        testpaper = TestPaper.objects.get(id=testpaper_id)

    except ObjectDoesNotExist:
        raise ResourceNotFoundError('Cannot find testpaper id = {}.'.format(testpaper_id))

    testpaper.delete()

    messages.success(request, 'Delete testpaper name={}.'.format(testpaper.name))

    return redirect(request.META.get('HTTP_REFERER', '/testpaper'))


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
            messages.success('Remove question id={} successfully.'.format(question.id))

        except ObjectDoesNotExist:
            if reach_limit:
                raise IllegalArgumentError('Reach the limit num of this type:{} in this exam.'.format(question.question_type))

            testpaper.qusetion_set.add(question)
            messages.success(request, 'Select question id={} successfully.'.format(question.id))

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

    keywords = {
        'description': request.DATA.get('description', ''),
        'question_type': question_type,
        'testpaper': testpaper if status is 1 else None,
    }

    num_pages, questions = questionmanager.query_question(**keywords, page=page)

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

    return render(request, '/exam/pick_question.html', data)


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