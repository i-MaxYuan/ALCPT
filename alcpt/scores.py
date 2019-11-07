import json

from django.shortcuts import render
from django.core.exceptions import ObjectDoesNotExist
from django.views.decorators.http import require_http_methods

from .models import Question, AnswerSheet, Student
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

    data = {
        'answer_sheets': answer_sheets,
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'score_list.html', data)


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

    num_pages, answer_sheets = viewer.query_answer_sheet(**keywords, page=page)

    data = {
        'answer_sheets': answer_sheets,
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'score_tester.html', data)


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

    return render(request, 'score_details.html', locals())