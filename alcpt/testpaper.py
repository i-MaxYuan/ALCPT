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
            if TestPaper.objects.get(name=name):
                raise MultipleObjectsReturned('Question has existed.')

        except ObjectDoesNotExist:
            pass

        testpaper = exammanager.create_testpaper(name=name,
                                                 created_by=request.user)

        return redirect('/exam/testpaper/{}/edit'.format(testpaper.name))

    else:
        return render(request, 'exam/testpaper_create.html')


@permission_check(UserType.ExamManager)
@require_http_methods(["GET", "POST"])
def edit_testpaper(request, testpaper_name: str):
    try:
        testpaper = TestPaper.objects.get(name=testpaper_name)

    except ObjectDoesNotExist:
        raise ObjectNotFoundError('Cannot find testpaper name={}'.format(testpaper_name))

    if request.method == 'POST':
        name = request.POST.get('name')

        testpaper = exammanager.edit_testpaper(testpaper=testpaper,
                                               name=name,)

        messages.success(request, "Successfully update testpaper :{}.".format(testpaper.name))

        return redirect('/exam')

    else:
        question_types = [0] + QuestionTypeCounts.Exam.value[0]
        selected_num = [0 for _ in question_types]
        reach_limit = [False for _ in question_types]

        for question_type in QuestionType.__members__.values():
            type_val = question_type.value[0]
            selected_num[type_val] = testpaper.question_set.filter(question_type=type_val).count()
            reach_limit[type_val] = selected_num[type_val] <= question_types[type_val]

        if not all(reach_limit):
            messages.warning(request, "This testpaper won't start until all questions have been selected.")

        data = {
            'testpaper': testpaper,
            'num_types': range(1, len(QuestionType.__members__) + 1),
            'question_types': question_types,
            'selected_num': selected_num,
            'reach_limit': reach_limit,
        }
        return render(request, 'exam/testpaper_edit.html', data)


@permission_check(UserType.ExamManager)
@require_http_methods(["GET"])
def delete_testpaper(request, testpaper_name):
    try:
        testpaper = TestPaper.objects.get(name=testpaper_name)

    except ObjectDoesNotExist:
        raise ResourceNotFoundError('Cannot find testpaper name = {}.'.format(testpaper_name))

    testpaper.delete()

    messages.success(request, 'Delete testpaper name={}.'.format(testpaper.name))

    return redirect(request.META.get('HTTP_REFERER', '/testpaper'))


@permission_check(UserType.ExamManager)
@require_http_methods(["GET", "POST"])
def pick_question(request, testpaper_name: str, question_type: int):
    try:
        testpaper = TestPaper.objects.get(name=testpaper_name)

    except ObjectDoesNotExist:
        raise ObjectNotFoundError('Cannot find testpaper {}'.format(testpaper_name))

    selected_questions = testpaper.question_set.filter(question_type=int(question_type))
    reach_limit = selected_questions.count() >= QuestionTypeCounts.Exam.value[0][int(question_type) - 1]

    if request.method == 'POST':
        try:
            question = Question.objects.get(id=request.POST.get('question_id'), enable=True)

        except TypeError:
            raise ArgumentError('Missing question_name')

        except ValueError:
            raise IllegalArgumentError('question_name is not int')

        except ObjectDoesNotExist:
            raise ObjectNotFoundError('Cannot find question')

        if question.question_type != int(question_type):
            raise IllegalArgumentError('question_type does match category.')

        try:
            testpaper.question_set.get(id=question.id)
            testpaper.question_set.remove(question)
            messages.success(request, 'Remove question id={} successfully.'.format(question.id))

        except ObjectDoesNotExist:
            if reach_limit:
                raise IllegalArgumentError('Reach the limit num of this type:{} in this exam.'.format(question.question_type))

            testpaper.question_set.add(question)
            messages.success(request, 'Select question id={} successfully.'.format(question.id))

    selected_questions = testpaper.question_set.filter(question_type=int(question_type))
    reach_limit = selected_questions.count() >= QuestionTypeCounts.Exam.value[0][int(question_type) - 1]

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
        'question_type': int(question_type),
        'testpaper': testpaper if status is 1 else None,
    }

    num_pages, questions = questionmanager.query_question(**keywords, enable=True, page=page)

    for question in questions:
        question.is_selected = question in selected_questions
        question.option = json.loads(question.option)

    keywords['status'] = status

    data = {
        'testpaper': testpaper,
        'question_type': int(question_type),
        'questions': questions,
        'keywords': keywords,
        'reach_limit': reach_limit,
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'exam/pick_question.html', data)


@permission_check(UserType.ExamManager)
@require_http_methods(["GET"])
def auto_pick_question(request, testpaper_name: str, question_type: int):
    try:
        testpaper = TestPaper.objects.get(name=testpaper_name)

    except ObjectDoesNotExist:
        raise ObjectNotFoundError('Cannot find testpaper {}'.format(testpaper_name))

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

    return redirect('exam/{}/edit'.format(testpaper_name))
