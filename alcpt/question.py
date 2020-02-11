import xlrd

from string import punctuation

from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.core.exceptions import ObjectDoesNotExist, MultipleObjectsReturned
from django.views.decorators.http import require_http_methods

from .models import Question, Choice
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType, QuestionType
from .managerfuncs import tbmanager, tboperator


@permission_check(UserType.TBManager)
@require_http_methods(["GET"])
def manager_index(request):
    question_types = []
    for q in list(QuestionType):
        question_types.append(q)

    state_choices = [(1, '審核通過'),
                     (2, '審核未通過'),
                     (3, '等待審核'),
                     (4, '被回報錯誤'),
                     (5, '被回報錯誤，已處理')]
    difficulty_choices = [(1, '1'),
                          (2, '2'),
                          (3, '3'),
                          (4, '4')]

    keywords = {
        'question_content': request.GET.get('question_content',)
    }
    if keywords['question_content'] and any(char in punctuation for char in keywords['question_content']):
        keywords['question_content'] = None
        messages.warning(request, "Name cannot contains any special character.")
    for keyword in ['question_type', 'difficulty', 'state']:
        try:
            keywords[keyword] = int(request.GET.get(keyword))
        except (KeyError, TypeError, ValueError):
            keywords[keyword] = None

    q_type = request.GET.get('question_type',)
    difficulty = request.GET.get('difficulty',)
    state = request.GET.get('state',)

    query_content, questions = tbmanager.query_questions(**keywords)
    page = request.GET.get('page', 1)
    paginator = Paginator(questions, 10)  # the second parameter is used to display how many items. Now is display 10

    try:
        questionList = paginator.page(page)
    except PageNotAnInteger:
        questionList = paginator.page(1)
    except EmptyPage:
        questionList = paginator.page(paginator.num_pages)

    return render(request, 'question/question_list.html', locals())


@permission_check(UserType.TBManager)
@require_http_methods(["GET"])
def review(request):
    # 過濾掉狀態為"暫存"、"審核通過"、"被回報錯誤，已處理"
    reviewed_questions = Question.objects.exclude(state=0).exclude(state=1).exclude(state=2).exclude(state=5)
    page = request.GET.get('page', 1)
    paginator = Paginator(reviewed_questions, 8)  # the second parameter is used to display how many items. Now is 10

    try:
        questionList = paginator.page(page)
    except PageNotAnInteger:
        questionList = paginator.page(1)
    except EmptyPage:
        questionList = paginator.page(paginator.num_pages)

    return render(request, 'question/review.html', locals())


@permission_check(UserType.TBManager)
def question_pass(request, question_id):
    try:
        question = Question.objects.get(id=question_id)
    except ObjectDoesNotExist:
        messages.error(request, 'Question does not exist, question id: {}'.format(question_id))

    question.state = 1
    question.faulted_reason = ""
    question.last_updated_by = request.user
    question.save()

    return redirect('question_review')


@permission_check(UserType.TBManager)
def question_reject(request, question_id):
    try:
        question = Question.objects.get(id=question_id)
    except ObjectDoesNotExist:
        messages.error(request, 'Question does not exist, question id: {}'.format(question_id))

    if request.method == "POST":
        question.faulted_reason = request.POST.get('reason')
        question.state = 2
        question.last_updated_by = request.user
        question.save()
        return redirect('question_review')
    else:
        return render(request, 'question/reject_reason.html', locals())


@permission_check(UserType.TBManager)
def question_edit(request, question_id):
    try:
        question = Question.objects.get(id=question_id)
        if question.state == 1:
            messages.warning(request, 'The question had been passed, can\'t be edited.')
            return redirect('tbmanager_question_list')

    except ObjectDoesNotExist:
        messages.error(request, 'Question does not exist, question id: {}'.format(question_id))

    if request.method == 'POST':
        question.q_content = request.POST.get('q_content',)

        for choice in question.choice_set.all():
            choice.is_answer = 0
            choice.save()

        try:
            choice = Choice.objects.get(id=request.POST.get('answer_choice'))
            choice.is_answer = 1
            choice.save()
            question.state = 1
            question.last_updated_by = request.user
            question.save()

            messages.success(request, 'Successful Update.')

            return redirect('question_review')
        except ObjectDoesNotExist:
            messages.error(request, 'Choice does not exist, choice id: {}'.format(request.POST.get('answer_choice')))
            return render(request, 'question/question_edit.html', locals())
    else:
        return render(request, 'question/question_edit.html', locals())


# 以下為「題目操作員」
@permission_check(UserType.TBOperator)
@require_http_methods(["GET"])
def operator_index(request):
    question_types = []
    for q in list(QuestionType):
        question_types.append(q)

    state_choices = [(0, '暫存'),
                     (2, '審核未通過'),
                     (4, '被回報錯誤')]

    difficulty_choices = [(1, '1'),
                          (2, '2'),
                          (3, '3'),
                          (4, '4')]

    keywords = {
        'question_content': request.GET.get('question_content', )
    }
    if keywords['question_content'] and any(char in punctuation for char in keywords['question_content']):
        keywords['question_content'] = None
        messages.warning(request, "Name cannot contains any special character.")
    for keyword in ['question_type', 'difficulty', 'state']:
        try:
            keywords[keyword] = int(request.GET.get(keyword))
        except (KeyError, TypeError, ValueError):
            keywords[keyword] = None

    q_type = request.GET.get('question_type', )
    state = request.GET.get('state', )

    query_content, questions = tboperator.query_questions(**keywords)
    page = request.GET.get('page', 1)
    paginator = Paginator(questions, 10)  # the second parameter is used to display how many items. Now is display 10

    try:
        questionList = paginator.page(page)
    except PageNotAnInteger:
        questionList = paginator.page(1)
    except EmptyPage:
        questionList = paginator.page(paginator.num_pages)

    return render(request, 'question/question_list.html', locals())


# 將題目狀態從"暫存"轉換成"等待審核", 目前只能一次送出一題
@permission_check(UserType.TBOperator)
@require_http_methods(["GET"])
def question_submit(request, question_id):
    try:
        question = Question.objects.get(id=question_id)
    except ObjectDoesNotExist:
        messages.error(request, 'Question doesn\'t exist, question id: {}'.format(question_id))

    question.state = 3      # 將狀態從 0 轉 3 , 從"暫存"轉"等待審核"
    question.save()

    return redirect('tboperator_question_list')


@permission_check(UserType.TBOperator)
def question_create(request, kind):
    if request.method == 'POST':
        if kind == 'listening':
            if request.POST.get('is_answer',):
                choice = Choice.objects.get(id=int(request.POST.get('is_answer',)))
                choice.is_answer = 1
                choice.save()
                return redirect('tboperator_question_list')
            else:
                try:
                    q_file = request.FILES.get('question_file',)
                except:
                    messages.error(request, 'Missing file field "question_file"')

                q_type = request.POST.get('question_type',)
                q_difficulty = request.POST.get('question_difficulty',)
                choice1 = request.POST.get('choice1',)
                choice2 = request.POST.get('choice2',)
                choice3 = request.POST.get('choice3',)
                choice4 = request.POST.get('choice4',)

                listening_question = tboperator.create_listening_question(q_file,
                                                                          q_type=q_type,
                                                                          created_by=request.user,
                                                                          difficulty=q_difficulty)

                option1 = Choice.objects.create(c_content=choice1, question=listening_question)
                option2 = Choice.objects.create(c_content=choice2, question=listening_question)
                option3 = Choice.objects.create(c_content=choice3, question=listening_question)
                option4 = Choice.objects.create(c_content=choice4, question=listening_question)
                option1.save()
                option2.save()
                option3.save()
                option4.save()

                return render(request, 'question/set_answer.html', locals())

        elif kind == 'reading':
            if request.POST.get('is_answer',):
                choice = Choice.objects.get(id=int(request.POST.get('is_answer',)))
                choice.is_answer = 1
                choice.save()
                return redirect('tboperator_question_list')
            else:
                try:
                    q_content = request.POST.get('question_content',)
                except:
                    messages.error(request, 'The question content had been the same with other one.')

                q_type = request.POST.get('question_type',)
                q_difficulty = request.POST.get('question_difficulty',)
                choice1 = request.POST.get('choice1',)
                choice2 = request.POST.get('choice2',)
                choice3 = request.POST.get('choice3',)
                choice4 = request.POST.get('choice4',)
                reading_question = tboperator.create_reading_question(q_content=q_content,
                                                                      q_type=q_type,
                                                                      created_by=request.user,
                                                                      difficulty=q_difficulty)

                option1 = Choice.objects.create(c_content=choice1, question=reading_question)
                option2 = Choice.objects.create(c_content=choice2, question=reading_question)
                option3 = Choice.objects.create(c_content=choice3, question=reading_question)
                option4 = Choice.objects.create(c_content=choice4, question=reading_question)
                option1.save()
                option2.save()
                option3.save()
                option4.save()

                return render(request, 'question/set_answer.html', locals())
        else:
            messages.error(request, 'The kind can not be found.')
            return redirect('Homepage')
    else:
        return render(request, 'question/create.html', locals())


@permission_check(UserType.TBOperator)
def question_multiCreate(request):
    if request.method == "POST":
        if request.FILES.get('users_file', ):
            wb = xlrd.open_workbook(filename=None, file_contents=request.FILES['users_file'].read())
            table = wb.sheets()[0]
            all_questions = []

            q_type = request.POST.get('question_type', )
            q_difficulty = request.POST.get('question_difficulty', )

            for i in range(table.nrows):
                question = []
                for j in range(table.ncols):
                    item = table.cell_value(i, j)
                    if isinstance(item, float):
                        item = int(item)
                    question.append(item)
                all_questions.append(question)

            for question in all_questions:
                q_content = question[0]
                choice1 = question[1]
                choice2 = question[2]
                choice3 = question[3]
                choice4 = question[4]

                reading_question = tboperator.create_reading_question(q_content=q_content,
                                                                      q_type=q_type,
                                                                      created_by=request.user,
                                                                      difficulty=q_difficulty)

                option1 = Choice.objects.create(c_content=choice1, question=reading_question)
                option2 = Choice.objects.create(c_content=choice2, question=reading_question)
                option3 = Choice.objects.create(c_content=choice3, question=reading_question)
                option4 = Choice.objects.create(c_content=choice4, question=reading_question)
                option1.save()
                option2.save()
                option3.save()
                option4.save()

                choice = Choice.objects.get(id=question[5])
                choice.is_answer = 1
                choice.save()

            return redirect('tboperator_question_list')
        else:
            messages.warning(request, 'Must load a file.')
            return redirect('question_multiCreate')
    else:
        return render(request, 'question/multi_create.html', locals())


@permission_check(UserType.TBOperator)
def operator_edit(request, question_id):
    try:
        question = Question.objects.get(id=question_id)
    except ObjectDoesNotExist:
        messages.error(request, 'Question does not exist, question id: {}'.format(question_id))

    if request.method == 'POST':
        question.q_content = request.POST.get('q_content', )
        question.q_type = request.POST.get('question_type',)
        for choice in question.choice_set.all():
            choice.is_answer = 0
            choice.save()
        try:
            choice = Choice.objects.get(id=request.POST.get('answer_choice'))
            choice.is_answer = 1
            choice.save()
            question.state = 0
            question.save()

            messages.success(request, 'Successful Update.')

            return redirect('tboperator_question_list')
        except ObjectDoesNotExist:
            messages.error(request, 'Choice does not exist, choice id: {}'.format(request.POST.get('answer_choice')))
            return render(request, 'question/operator_edit.html', locals())
    else:
        return render(request, 'question/operator_edit.html', locals())


@permission_check(UserType.TBOperator)
def question_delete(request, question_id):
    try:
        question = Question.objects.get(id=question_id)
        if question.state == 0 or question.state == 2:
            choices = question.choice_set.all()
            for choice in choices:
                choice.delete()

            question.delete()
            messages.success(request, 'Delete question successfully, question id: {}'.format(question.id))
        else:
            messages.warning(request, 'Question can not be deleted, question id: {}'.format(question_id))
    except ObjectDoesNotExist:
        messages.error(request, 'Question does not exist, question id: {}'.format(question_id))

    return redirect('tboperator_question_list')