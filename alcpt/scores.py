import json

from django.shortcuts import render
from django.core.exceptions import ObjectDoesNotExist
from django.views.decorators.http import require_http_methods

from .models import Question, AnswerSheet
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType
from .managerfuncs import viewer


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

    num_pages, answer_sheets = viewer.query_answer_sheet(**keywords, page=page)
    exams = []
    frequency = 1
    for sheet in answer_sheets:
        if frequency == 1:
            exams.append({'exam_id': int(sheet.exam.id), 'exam_name': sheet.exam.name, 'average_score': 0,
                          'finish_time': sheet.finish_time, 'total': int(sheet.score), 'frequency': 1, })
        else:
            flag = 1
            for exam in exams:
                if int(exam.exam_id) == int(sheet.exam.id):
                    exam['total'] += int(sheet.score)
                    exam['frequency'] += 1
                    flag = 0
            if flag:
                exams.append({'exam_id': int(sheet.exam.id), 'exam_name': sheet.exam.name, 'average_score': 0,
                              'finish_time': sheet.finish_time, 'total': int(sheet.score), 'frequency': 1, })


    for exam in exams:
        exam['average_score'] = exam['total']/exam['frequency']

    data = {
        'exams': exams,
        'page': page,
        'page_range': range(num_pages),
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

    return render(request, 'testee/score_tester.html', data)


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
def show_exam(request, exam_id):
    from .models import User
    users = User.objects.all()
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
        if sheet.exam.id == int(exam_id):
            for user in users:
                if user.id == sheet.user_id:
                    answer_sheets.append({'exam_id': exam_id, 'exam_name': sheet.exam.name, 'score': sheet.score,
                                          'testee_name': user.name, 'finish_time': sheet.finish_time, })




    data = {
        'answer_sheets': answer_sheets,
        'page': page,
        'page_range': range(num_pages),
    }

    if answer_sheets:
        return render(request, 'score/view_one_exam.html', data)
    else:
        raise ObjectNotFoundError('The exam not found.')