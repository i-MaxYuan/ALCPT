import re

from string import punctuation
from datetime import datetime

from django.shortcuts import render, redirect
from django.views.decorators.http import require_http_methods

from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.core.exceptions import ObjectDoesNotExist
from django.db import IntegrityError
from django.contrib import messages

from alcpt.managerfuncs import systemmanager
from alcpt.models import User, Student, Department, Squadron, Proclamation, AnswerSheet, Exam
from alcpt.definitions import UserType
from alcpt.decorators import permission_check
from alcpt.exceptions import IllegalArgumentError


@permission_check(UserType.Viewer)
def index(request):
    exams = Exam.objects.filter(is_public=True)
    now_time = datetime.now()

    return render(request, 'viewer/exam_score_list.html', locals())


@permission_check(UserType.Viewer)
def exam_score_detail(request, exam_id):
    try:
        exam = Exam.objects.get(id=exam_id)
        testees = exam.group.member.all().order_by('stu_id')

        qualified = 0
        unqualified = 0
        not_tested = 0
        answer_sheets = []
        for testee in testees:
            try:
                answer_sheet = AnswerSheet.objects.get(exam=exam, user_id=testee.id)
                if answer_sheet.score >= 60:
                    qualified += 1
                elif answer_sheet.score < 60:
                    unqualified += 1
                elif answer_sheet.score is None:
                    not_tested += 1

                answer_sheets.append(answer_sheet)
            except ObjectDoesNotExist:
                not_tested += 1
                answer_sheets.append(None)

        testeeData = zip(testees, answer_sheets)

        return render(request, 'viewer/exam_score_detail.html', locals())
    except ObjectDoesNotExist:
        messages.error(request, 'Exam does not exist, exam id: {}'.format(exam_id))
        return redirect('exam_score_list')
