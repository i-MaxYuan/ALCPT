import json
from math import ceil

from django.shortcuts import render
from django.core.exceptions import ObjectDoesNotExist
from django.views.decorators.http import require_http_methods

from .models import Question, AnswerSheet
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType


@permission_check(UserType.Tester)
@require_http_methods(["GET"])
def index(request):
    try:
        page = int(request.GET.get('page', 0))

    except ValueError:
        page = 0

    answer_sheets = AnswerSheet.objects.filter(user=request.user).order_by('-create_time')

    pages = ceil(len(answer_sheets / 10))

    if page and page >= 0:
        answer_sheets = answer_sheets[page * 10: page * 10 + 10]  # page * 10: (page + 1) * 10

    for sheet in answer_sheets:
        sheet.answer = json.loads(sheet.answer)
        sheet.questions = json.loads(sheet.questions)

    data = {
        'answer_sheets': answer_sheets,
        'page': page,
        'page_range': range(pages)
    }

    return render(request, 'score_list.html', data)


@permission_check(UserType.Tester)
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