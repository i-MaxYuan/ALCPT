import json
from datetime import datetime
from math import ceil
from random import sample

from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist, MultipleObjectsReturned
from django.views.decorators.http import require_http_methods
from django.utils import timezone

from .models import Exam, TestPaper, Question
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType, QuestionTypeCounts, QuestionType, ExamType
from .managerfuncs import exammanager, questionmanager


@permission_check(UserType.ExamManager)
@require_http_methods(["GET"])
def index(request):
    try:
        page = int(request.GET.get('page', 0))

    except ValueError:
        page = 0

    keywords = {
        'name': request.GET.get('name', ''),
    }

    num_pages, exams = exammanager.query_exams(**keywords, page=page)

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

        try:
            if Exam.objects.get(name=name):
                raise MultipleObjectsReturned('Question has existed.')

        except ObjectDoesNotExist:
            pass

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
            raise ArgumentError('Missing duration.')

        except ValueError:
            raise IllegalArgumentError('The "duration" must be an integer.')

        try:
            testpaper = TestPaper.objects.get(name=request.POST.get('testpaper'))

        except TypeError:
            raise ArgumentError('Missing testpaper.')

        exam.name = name
        exam.start_time = start_time
        exam.duration = duration
        exam.testpaper = testpaper
        exam.save()

        messages.success(request, "Successfully update exam :{}.".format(exam.name))

        return redirect('/exam')

    else:
        return render(request, 'exam/exam_edit.html', locals())


@permission_check(UserType.ExamManager)
@require_http_methods(["GET"])
def delete_exam(request, exam_id):
    try:
        exam = Exam.objects.get(id=exam_id)

    except ObjectDoesNotExist:
        raise ResourceNotFoundError('Cannot find question id = {}.'.format(exam_id))

    exam.public = False
    exam.last_updated_by = request.user
    exam.save()

    messages.success(request, 'Delete exam name={}.'.format(exam.name))

    return redirect(request.META.get('HTTP_REFERER', '/exam'))
