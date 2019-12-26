import json

from django.shortcuts import render
from django.core.exceptions import ObjectDoesNotExist
from django.views.decorators.http import require_http_methods
from .managerfuncs import systemmanager
from string import punctuation

from .models import *

from .exceptions import *
from .decorators import permission_check
from .definitions import UserType, ExamType
from .managerfuncs import viewer
from django.contrib import messages


@permission_check(UserType.Viewer)
@require_http_methods(["GET"])
def index(request):
    try:
        page = int(request.GET.get('page', 0))

    except ValueError:
        page = 0

    keywords = {
        'name': request.GET.get('name', ''),
        'start_time': request.GET.get('start_time'),
        'end_time': request.GET.get('end_time'),
    }

    num_pages, answer_sheets_all = viewer.query_answer_sheet(**keywords, page=page)
    answer_sheets = []
    for sheet in answer_sheets_all:
        if sheet.exam.testpaper.is_testpaper == 1:
            answer_sheets.append(sheet)
    exam_ids = []
    exams = []
    for sheet in answer_sheets:
        if exam_ids:
            is_exist = 0
            for exam_id in exam_ids:
                if exam_id == sheet.exam.id:
                    is_exist = 1
            if not is_exist:
                exam_ids.append(sheet.exam.id)
        else:
            exam_ids.append(sheet.exam.id)

    for exam_id in exam_ids:
        exams.append({'exam_id': exam_id, 'name': 'one_exam', 'average_score': 0, 'finish_time': '2019-05-19 22:21:43.643000',
                      'total': 0, 'frequency': 0,})

    for sheet in answer_sheets:
        for exam in exams:
            if exam['exam_id'] == sheet.exam.id:
                exam['name'] = sheet.exam.name
                exam['finish_time'] = sheet.finish_time
                exam['total'] += sheet.score
                exam['frequency'] += 1

    for exam in exams:
        exam['average_score'] = exam['total']/exam['frequency']

    data = {
        'exams': exams,
        'page': page,
        'page_range': range(num_pages),
        'departments': Department.objects.all(),
        'squadrons': Squadron.objects.all(),
        'num_types': range(1, len(UserType.__members__) + 1),
    }

    return render(request, 'score/score_list.html', data)


@permission_check(UserType.Testee)
@require_http_methods(["GET"])
def tester_index(request):
    try:
        page = int(request.GET.get('page', 0))

    except ValueError:
        page = 0

    keywords = {
        'name': request.GET.get('name', ''),
        'start_time': request.GET.get('start_time'),
        'end_time': request.GET.get('end_time'),
    }

    num_pages, answer_sheets_all = viewer.query_answer_sheet(**keywords, page=page)
    answer_sheets = []
    for sheet in answer_sheets_all:
        if sheet.user_id == request.user.id:
            answer_sheets.append(sheet)

    data = {
        'answer_sheets': answer_sheets,
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'testee/score_testee.html', data)


@permission_check(UserType.Testee)
@require_http_methods(["GET"])
def sheet_detail(request, exam_id):
    try:
        sheet = AnswerSheet.objects.get(user=request.user, exam_id=exam_id)

    except ObjectDoesNotExist:
        raise ObjectNotFoundError('The answer sheet not found.')

    question_dir = json.loads(sheet.questions)
    answer_dir = json.loads(sheet.answers)
    for que_id in question_dir:
        if que_id in answer_dir:
            question_dir[que_id]['user_answer'] = answer_dir[que_id]

        question_dir[que_id]['correct'] = Question.objects.get(id=que_id).correct

    return render(request, 'score/score_details.html', locals())


@permission_check(UserType.Viewer)
@require_http_methods(["GET"])
def show_given_exam(request, exam_id):
    from .models import AnswerSheet
    answer_sheets_all = AnswerSheet.objects.all()
    answer_sheets = []
    for sheet in answer_sheets_all:
        if sheet.exam.testpaper.is_testpaper == 1:
            answer_sheets.append(sheet)
    exams = []
    for exam in answer_sheets:
        if exam.exam_id == int(exam_id):
            exams.append({'exam_id': exam_id, 'name': exam.exam.name, 'score': exam.score, 'finish_time': exam.finish_time,
                          'testee': exam.user.user.name, 'testee_id': exam.user_id,})
    data = {'exams': exams,
            'exam_id': exam_id,}
    return render(request, 'score/show_given_exam.html', data)

@permission_check(UserType.Viewer)
@require_http_methods(["GET"])
def show_given_tester(request, user_id):
    from .models import AnswerSheet
    answer_sheets_all = AnswerSheet.objects.all()
    answer_sheets = []
    for sheet in answer_sheets_all:
        if sheet.exam.testpaper.is_testpaper == 1:
            answer_sheets.append(sheet)
    exams = []
    for exam in answer_sheets:
        if exam.user_id == int(user_id):
            exams.append({'exam_id': exam.id, 'name': exam.exam.name, 'score': exam.score, 'finish_time': exam.finish_time,
                          'testee': exam.user.user.name,})
    data = {'exams': exams,
            'user_id': user_id,
            'another_exam_type': '練習',
            'redirect': 'show_given_practice',}
    return render(request, 'score/show_given_testee.html', data)

@permission_check(UserType.Viewer)
@require_http_methods(["GET"])
def show_given_practice(request, user_id):
    from .models import AnswerSheet
    answer_sheets_all = AnswerSheet.objects.all()
    answer_sheets = []
    for sheet in answer_sheets_all:
        if sheet.exam.testpaper.is_testpaper == 0:
            answer_sheets.append(sheet)
    exams = []
    for exam in answer_sheets:
        if exam.user_id == int(user_id):
            exams.append({'exam_id': exam.id, 'name': exam.exam.name, 'score': exam.score, 'finish_time': exam.finish_time,
                          'testee': exam.user.user.name,})
    data = {'exams': exams,
            'user_id': user_id,
            'another_exam_type': '考試',
            'redirect': 'show_given_tester',}
    return render(request, 'score/show_given_testee.html', data)

@permission_check(UserType.Viewer)
@require_http_methods(["GET"])
def search(request):
    try:
        page = int(request.GET.get('page', 0))
    except ValueError:
        page = 0


    keywords = {
        'name': request.GET.get('name')
    }

    if keywords['name'] and any(char in punctuation for char in keywords['name']):
        keywords['name'] = None
        messages.warning(request, "Name cannot contains any special character.")

    for keyword in ['department', 'grade', 'squadron']:
        try:
            keywords[keyword] = int(request.GET.get(keyword))
        except (KeyError, TypeError, ValueError):
            keywords[keyword] = None

    if keywords['department']:
        try:
            keywords['department'] = Department.objects.get(id=keywords['department'])
        except ObjectDoesNotExist:
            keywords['department'] = None

    if keywords['squadron']:
        try:
            keywords['squadron'] = Squadron.objects.get(id=keywords['squadron'])
        except ObjectDoesNotExist:
            keywords['squadron'] = None

    users = systemmanager.score_query_users(**keywords, page=page)

    data = {
        'users': users,
        'departments': Department.objects.all(),
        'squadrons': Squadron.objects.all(),
        'priviledges': UserType.__members__,
        'num_types': range(1, len(UserType.__members__) + 1),
        'keywords': keywords,
    }

    return render(request, 'score/score_list_search.html', data)
