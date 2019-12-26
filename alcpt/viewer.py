import re

from string import punctuation

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

    for exam in exams:
        total = 0
        for answersheet in exam.answersheet_set.all():
            total += answersheet.score
        exam.average_score = float(total/exam.answersheet_set.count())

    return render(request, 'viewer/exam_score_list.html', locals())
