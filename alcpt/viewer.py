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

import plotly.offline as pyo
import plotly.graph_objs as go
import pandas as pd
import numpy as np

@permission_check(UserType.Viewer)
def index(request):
    exams = Exam.objects.filter(is_public=True)
    now_time = datetime.now()

    return render(request, 'viewer/exam_score_list.html', locals())


@permission_check(UserType.Viewer)
def exam_score_detail(request, exam_id):
    try:
        exam = Exam.objects.get(id=exam_id)
        testees = exam.testeeList.all()

        qualified = 0
        unqualified = 0
        not_tested = 0
        testee_scores = []
        answer_sheets = []
        for testee in testees:
            try:
                answer_sheet = AnswerSheet.objects.get(exam=exam, user_id=testee.id)
                if answer_sheet.is_tested is False:
                    not_tested += 1
                elif answer_sheet.score >= 60:
                    testee_scores.append(answer_sheet.score)
                    qualified += 1
                elif answer_sheet.score < 60:
                    testee_scores.append(answer_sheet.score)
                    unqualified += 1

                answer_sheets.append(answer_sheet)
            except ObjectDoesNotExist:
                not_tested += 1
                answer_sheets.append(None)

        #平均分數
        if testee_scores:
            testee_score_means = np.mean(testee_scores)
        else:
            testee_score_means = '無考試成績'

        testeeData = zip(testees, answer_sheets)

        #Pie chart
        status = ['未進行測驗', '合格', '不合格']
        status_count = [not_tested, qualified, unqualified]
        colors = ['grey','green', 'red']
        trace = go.Pie(labels = status,
                       values = status_count,
                       hole = .4,
                       type = 'pie')
        data = [trace]
        layout = go.Layout({
            'title': '考試狀態',
            'annotations': [
                 {
                    'font': {
                       'size': 20
                    },
                    'showarrow': False,
                    'text': '考試狀態',
                 },
              ]
        })
        fig = go.Figure(data=data, layout=layout)
        fig.update_traces(marker = dict(colors=colors))
        pie_chart = pyo.plot(fig, output_type='div')

        return render(request, 'viewer/exam_score_detail.html', locals())
    except ObjectDoesNotExist:
        messages.error(request, 'Exam does not exist, exam id - {}'.format(exam_id))
        return redirect('exam_score_list')


@permission_check(UserType.Viewer)
def view_testee_info(request, exam_id, reg_id):
    try:
        exam = Exam.objects.get(id=exam_id)
        try:
            viewed_testee = User.objects.get(reg_id=reg_id)

            answer_sheets = AnswerSheet.objects.filter(user=viewed_testee)

            return render(request, 'viewer/view_testee_info.html', locals())

        except ObjectDoesNotExist:
            messages.error(request, "User does not exist, user register id - {}".format(reg_id))
            return redirect('exam_score_detail', exam_id=exam.id)

    except ObjectDoesNotExist:
        messages.error(request, "Exam does not exist, exam id - {}".format(exam_id))
        return redirect('exam_score_list')
