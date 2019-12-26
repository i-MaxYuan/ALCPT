from string import punctuation

from django.shortcuts import render, redirect

from django.views.decorators.http import require_http_methods
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist, MultipleObjectsReturned
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage

from alcpt.managerfuncs import testmanager
from alcpt.decorators import permission_check
from alcpt.definitions import UserType, QuestionType, QuestionTypeCounts
from alcpt.models import Exam, TestPaper, Group
from alcpt.exceptions import *


@permission_check(UserType.TestManager)
@require_http_methods(["GET"])
def exam_list(request):
    exam_name = request.GET.get('exam_name')

    if exam_name:
        exams = Exam.objects.filter(is_public=True).filter(name__contains=exam_name)
    else:
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

        return render(request, 'exam/testpaper_edit.html', locals())

    else:
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


# 人工選題（未完成）
@permission_check(UserType.TestManager)
def manual_pick(request, testpaper_id, question_type):
    messages.success(request, str(question_type))
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


