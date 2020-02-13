from string import punctuation
from datetime import datetime, timedelta

from django.shortcuts import render, redirect

from django.views.decorators.http import require_http_methods
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist, MultipleObjectsReturned
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.db import IntegrityError

from alcpt.managerfuncs import testmanager
from alcpt.decorators import permission_check
from alcpt.definitions import UserType, QuestionType, QuestionTypeCounts, ExamType
from alcpt.models import Exam, TestPaper, Group, Question, TesteeList
from alcpt.exceptions import *


@permission_check(UserType.TestManager)
@require_http_methods(["GET"])
def exam_list(request):
    exams = Exam.objects.filter(is_public=True)

    page = request.GET.get('page', 0)
    paginator = Paginator(exams, 10)  # the second parameter is used to display how many items. Now is display 10

    try:
        examList = paginator.page(page)
    except PageNotAnInteger:
        examList = paginator.page(1)
    except EmptyPage:
        examList = paginator.page(paginator.num_pages)

    return render(request, 'exam/exam_list.html', locals())


@permission_check(UserType.TestManager)
def exam_create(request):
    if request.method == 'POST':
        start_time = request.POST.get('start_time',)
        duration = request.POST.get('duration',)
        started_time = datetime.strptime(str(start_time)+".000Z", '%Y-%m-%dT%H:%M:%S.%fZ')
        finish_time = datetime.strptime(str(start_time)+".000Z", '%Y-%m-%dT%H:%M:%S.%fZ') + timedelta(minutes=int(duration))
        testpaper = TestPaper.objects.get(id=int(request.POST.get('selected_testpaper',)))
        selected_group = Group.objects.get(id=int(request.POST.get('selected_group')))

        exam_name = request.POST.get('exam_name',)
        try:
            exam = Exam.objects.create(name=exam_name,
                                       exam_type=ExamType.Exam.value[0],
                                       start_time=start_time,
                                       created_time=datetime.now(),
                                       duration=duration,
                                       finish_time=finish_time,
                                       testpaper=testpaper,
                                       is_public=True,
                                       created_by=request.user)
            testpaper.is_used = True
            testpaper.save()

            testee_list = TesteeList.objects.create()
            testee_list.created_by = exam
            for testee in selected_group.user_set.all():
                testee_list.testees.add(testee)
            testee_list.save()

            messages.success(request, "exam: {} create successfully.".format(exam_name))
        except IntegrityError:
            raise IntegrityError("Duplicate entry '%s' for key 'name'".format(exam_name))

        return redirect('exam_list')
    else:
        testpapers = TestPaper.objects.filter(is_testpaper=True, valid=True)
        groups = Group.objects.all()
        return render(request, 'exam/exam_create.html', locals())


@permission_check(UserType.TestManager)
@require_http_methods(["GET"])
def testpaper_list(request):
    testpaper_name = request.GET.get('testpaper_name')

    if testpaper_name:
        testpapers = TestPaper.objects.filter(is_testpaper=True).filter(name__contains=testpaper_name)
    else:
        testpapers = TestPaper.objects.filter(is_testpaper=True)

    page = request.GET.get('page', 0)
    paginator = Paginator(testpapers, 10)  # the second parameter is used to display how many items. Now is display 10

    try:
        testpaperList = paginator.page(page)
    except PageNotAnInteger:
        testpaperList = paginator.page(1)
    except EmptyPage:
        testpaperList = paginator.page(paginator.num_pages)

    return render(request, 'exam/testpaper_list.html', locals())


@permission_check(UserType.TestManager)
def testpaper_content(request, testpaper_id):
    try:
        testpaper = TestPaper.objects.get(id=testpaper_id)
    except ObjectDoesNotExist:
        messages.error(request, 'Testpaper does not exist, testpaper id: {}'.format(testpaper_id))
        return redirect('testpaper_list')

    questions = testpaper.question_set.all().order_by('q_type')

    return render(request, 'exam/testpaper_content.html', locals())


@permission_check(UserType.TestManager)
def testpaper_create(request):
    if request.method == 'POST':
        testpaper_name = request.POST.get('testpaper_name',)

        try:
            if TestPaper.objects.filter(name__icontains=testpaper_name):
                raise MultipleObjectsReturned('Question has existed.')
        except ObjectDoesNotExist:
            pass

        testpaper = testmanager.create_testpaper(name=testpaper_name, created_by=request.user, is_testpaper=1)

        messages.success(request, 'Add a testpaper successfully, please edit the new testpaper: {}'.format(testpaper.name))
        return redirect('testpaper_list')

    else:
        testpaper_names = [_.name for _ in TestPaper.objects.all()]
        return render(request, 'exam/testpaper_create.html', locals())


# 編輯考卷（未完成）
@permission_check(UserType.TestManager)
def testpaper_edit(request, testpaper_id):
    try:
        testpaper = TestPaper.objects.get(id=testpaper_id)
    except ObjectDoesNotExist:
        messages.error(request, 'Testpaper does not exist, testpaper id: {}'.format(testpaper_id))
        return redirect('testpaper_list')

    if testpaper.valid == 1:
        messages.warning(request, "This testpaper is valid, it can't not edit again.")
        return redirect('testpaper_list')

    if request.method == "POST":
        testpaper_name = request.POST.get('testpaper_name',)

        testpaper = testmanager.edit_testpaper(testpaper, testpaper_name)

        testpaper.valid = testpaper.question_set.count() == sum(QuestionTypeCounts.Exam.value[0])

        if testpaper.valid:
            for question in testpaper.question_set.all():
                question.used_freq += 1
                question.save()

        testpaper.save()

        messages.success(request, 'Successfully update testpaper: testpaper id: {}'.format(testpaper.id))

        return redirect('testpaper_list')

    else:
        question_types = [0] + QuestionTypeCounts.Exam.value[0]
        selected_num = [0 for _ in question_types]
        reach_limit = [False for _ in question_types]

        for question_type in QuestionType.__members__.values():
            type_value = question_type.value[0]
            selected_num[type_value] = testpaper.question_set.filter(q_type=type_value).count()
            reach_limit[type_value] = selected_num[type_value] <= question_types[type_value]

        if not all(reach_limit):
            messages.warning(request, "This testpaper won't start until all questions have been selected.")

        types_num = range(1, len(QuestionType.__members__)+1)

        return render(request, 'exam/testpaper_edit.html', locals())


# 刪除考卷
@permission_check(UserType.TestManager)
def testpaper_delete(request, testpaper_id):
    try:
        testpaper = TestPaper.objects.get(id=testpaper_id)
        if testpaper.is_testpaper and testpaper.valid:
            messages.warning(request, 'This testpaper is valid, can not delete.')
        else:
            messages.success(request, 'Testpaper has been deleted successfully, testpaper id: {}'.format(testpaper.id))
            testpaper.delete()
        return redirect('testpaper_list')

    except ObjectDoesNotExist:
        messages.error(request, 'Testpaper does not exist, testpaper id: {}'.format(testpaper_id))
        return redirect('testpaper_list')


# 人工選題（已完成）
@permission_check(UserType.TestManager)
def manual_pick(request, testpaper_id, question_type):
    try:
        testpaper = TestPaper.objects.get(id=testpaper_id)
    except ObjectDoesNotExist:
        messages.error(request, 'Testpaper does not exist, testpaper id: {}'.format(testpaper_id))

    if request.method == "POST":
        selected_questions = request.POST.getlist('question',)

        selected_question_list = []
        for question in selected_questions:
            selected_question_list.append(Question.objects.get(id=question))

        for question in selected_question_list:
            testpaper.question_set.add(question)
        for question in testpaper.question_set.all():
            if question not in selected_question_list:
                testpaper.question_set.remove(question)
        testpaper.save()
        messages.success(request, "testpaper: {} is successfully selected manually.".format(testpaper.name))
        return redirect('testpaper_edit', testpaper_id=testpaper_id)

    else:
        for q_type in QuestionType.__members__.values():
            if q_type.value[0] == int(question_type):
                question_type = q_type
                break

        questionList = testmanager.manual_pick(question_type=question_type.value[0])
        selected_questions = testpaper.question_set.all()

        return render(request, 'exam/testpaper_manual_pick.html', locals())


# 自動選題（已完成）
@permission_check(UserType.TestManager)
def auto_pick(request, testpaper_id, question_type):
    try:
        testpaper = TestPaper.objects.get(id=testpaper_id)
    except ObjectDoesNotExist:
        messages.error(request, 'Testpaper does not exist, testpaper id: {}'.format(testpaper_id))

    if type(question_type) is int:
        raise IllegalArgumentError('question_type does match category.')

    for q_type in QuestionType.__members__.values():
        if q_type.value[0] == int(question_type):
            question_type = q_type
            break

    if testmanager.limit_check(testpaper=testpaper, q_type=question_type):
        messages.warning(request, 'This type had reached limit amount.')
        return redirect('/exam/testpaper/{}/edit'.format(testpaper_id))

    selected_num = testmanager.auto_pick(testpaper=testpaper, type_counts=QuestionTypeCounts.Exam.value[0],
                                         question_type=int(question_type.value[0]))

    messages.success(request, selected_num)

    return redirect('/exam/testpaper/{}/edit'.format(testpaper_id))


