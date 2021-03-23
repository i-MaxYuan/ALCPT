import xlrd

from string import punctuation

from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.core.exceptions import ObjectDoesNotExist, MultipleObjectsReturned
from django.views.decorators.http import require_http_methods
from django.utils.translation import gettext as _
from .models import Question, Choice
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType, QuestionType
from .managerfuncs import tbmanager, tboperator


@permission_check(UserType.TBManager)
def manager_index(request):
    responsibility = "TBManager"
    question_types = [_ for _ in QuestionType]

    state_choices = [(1, _('Pass')),
                     (4, _('Faulty')),
                     (5, _('Handle'))]
    states = []
    for x in state_choices:
        states.append(x[0])

    difficulty_choices = [(1, _('Easy')),
                          (2, _('Medium')),
                          (3, _('Hard'))]

    keywords = {
        'question_content': request.GET.get('question_content'),
    }

    for keyword in ['question_type', 'difficulty', 'state']:
        try:
            keywords[keyword] = int(request.GET.get(keyword))
        except (KeyError, TypeError, ValueError):
            keywords[keyword] = None

    if keywords['question_content'] and any(char in punctuation for char in keywords['question_content']):
        keywords['question_content'] = None
        messages.warning(request, "Name cannot contains any special character.")
        questions = Question.objects.exclude(state=6)

    elif keywords['state'] and int(keywords['state']) not in states:
        hi = keywords['state']
        messages.warning(request, "Can not search by this state.")
        questions = Question.objects.exclude(state=6)

        # 使用搜尋功能，系統會至後端資料庫filter出符合條件的題目。所以，頁面會有重新載入的效果。
        # 若是使用Javascript，因是使用cache檔案，所以不會有進入後端抓資料一樣的問題。
    query_content, questions = tbmanager.query_questions(**keywords)

    page = request.GET.get('page', 1)
    paginator = Paginator(questions, 20)  # the second parameter is used to display how many items. Now is display 10

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
    # 過濾掉狀態為"暫存6"、"審核通過1"、"被回報錯誤4，已處理5"
    reviewed_questions = Question.objects.filter(state=3).order_by('id')
    page = request.GET.get('page', 1)
    paginator = Paginator(reviewed_questions, 10)  # the second parameter is used to display how many items. Now is 10

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
        question.state = 1
        question.faulted_reason = ""
        question.last_updated_by = request.user
        question.save()

        messages.success(request, "Successfully passed, question id - {}.".format(question.id))
    except ObjectDoesNotExist:
        messages.error(request, 'Question does not exist, question id - {}'.format(question_id))

    return redirect('question_review')


@permission_check(UserType.TBManager)
def question_reject(request, question_id):
    try:
        question = Question.objects.get(id=question_id)
        if request.method == "POST":
            question.faulted_reason = request.POST.get('reason')
            question.state = 2
            question.last_updated_by = request.user
            question.save()
            return redirect('question_review')
        else:
            return render(request, 'question/reject_reason.html', locals())
    except ObjectDoesNotExist:
        messages.error(request, 'Question does not exist, question id - {}'.format(question_id))
        return redirect('question_review')


@permission_check(UserType.TBManager)
def question_edit(request, question_id):
    try:
        question = Question.objects.get(id=question_id)
        if question.state == 1 or question.state == 5:  #pass handle
            messages.warning(request, 'Failed edited, the question had been passed or handled.')
            return redirect(request.META.get('HTTP_REFERER',))

        if request.method == 'POST':
            if question.state == 4: #faulty
                if question.q_file:
                    new_question = Question.objects.create(q_type=question.q_type,
                                                           q_file=question.q_file,
                                                           difficulty=question.difficulty,
                                                           issued_freq=question.issued_freq,
                                                           correct_freq=question.correct_freq,
                                                           created_by=request.user,
                                                           last_updated_by=request.user,
                                                           state=1)
                else:
                    new_question = Question.objects.create(q_type=question.q_type,
                                                           q_content=question.q_content,
                                                           difficulty=question.difficulty,
                                                           issued_freq=question.issued_freq,
                                                           correct_freq=question.correct_freq,
                                                           created_by=request.user,
                                                           last_updated_by=request.user,
                                                           state=1)
                new_question.save()

                original_answer_choice_id = 0
                for choice in question.choice_set.all():
                    if choice.is_answer:
                        original_answer_choice_id = choice.id
                        choice.is_answer = False
                    else:
                        choice.is_answer = False
                    choice.save()
                Choice.objects.filter(id=request.POST.get('answer_choice')).update(is_answer=True)

                for choice in question.choice_set.all():
                    Choice.objects.create(c_content=choice.c_content,
                                          question=new_question,
                                          is_answer=choice.is_answer)

                for choice in question.choice_set.all():
                    if choice.id == original_answer_choice_id:
                        choice.is_answer = True
                    else:
                        choice.is_answer = False
                    choice.save()

                question.state = 5
                question.save()

                messages.success(request, "Successfully processed the question")
                return redirect('tbmanager_question_list')
            else:  #2reject 3pending
                question.q_content = request.POST.get('q_content')

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

                    messages.success(request, 'Successfully updated.')

                    return redirect('question_review')
                except ObjectDoesNotExist:
                    messages.error(request,
                                   'Choice does not exist, choice id: {}'.format(request.POST.get('answer_choice')))
                    return render(request, 'question/question_edit.html', locals())
        else:
            return render(request, 'question/question_edit.html', locals())

    except ObjectDoesNotExist:
        messages.error(request, 'Question does not exist, question id - {}'.format(question_id))
        return redirect('question_review')


# 以下為「題目操作員」
@permission_check(UserType.TBOperator)
@require_http_methods(["GET"])
def operator_index(request):
    responsibility = "TBOperator"
    question_types = []
    for q in list(QuestionType):
        question_types.append(q)

    state_choices = [
        (6, _('Saved')),
        (2, _('Reject')),
        (4, _('Faulty'))]

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
    resultNum = len(questions)

    page = request.GET.get('page', 1)
    paginator = Paginator(questions, 20)  # the second parameter is used to display how many items. Now is display 10

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
        question.state = 3  # 將狀態從 0 轉 3 , 從"暫存"轉"等待審核"
        question.save()
    except ObjectDoesNotExist:
        messages.error(request, 'Question does not exist, question id - {}'.format(question_id))

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
                    q_file = request.FILES.get('question_file')
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
        if request.FILES.get('questions_file', ):
            wb = xlrd.open_workbook(filename=None, file_contents=request.FILES['questions_file'].read())
            table = wb.sheets()[0]
            all_questions = []
            numbers = [n for n in range(1,5)]

            for i in range(1, table.nrows):
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
                q_type = question[6]
                q_difficulty = question[7]

                reading_question = tboperator.create_reading_question(q_content=q_content,
                                                                      q_type=q_type,
                                                                      created_by=request.user,
                                                                      difficulty=q_difficulty)


                choices = [choice1, choice2, choice3, choice4]
                for number, choice in zip(numbers, choices):
                    if question[5] == number:
                        option = Choice.objects.create(c_content=choice, question=reading_question, is_answer=1)

                    else:
                        option = Choice.objects.create(c_content=choice, question=reading_question)
                        option.save()

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

        if request.method == 'POST':
            question.q_content = request.POST.get('q_content')
            question.q_type = request.POST.get('question_type')
            question.last_updated_by = request.user
            for choice in question.choice_set.all():
                choice.is_answer = 0
                choice.save()
            try:
                choice = Choice.objects.get(id=request.POST.get('answer_choice'))
                choice.is_answer = 1
                choice.save()
                question.state = 6
                question.save()

                messages.success(request, 'Successful Update.')

                return redirect('tboperator_question_list')
            except ObjectDoesNotExist:
                messages.error(request,
                               'Choice does not exist, choice id - {}'.format(request.POST.get('answer_choice')))
                return render(request, 'question/operator_edit.html', locals())
        else:
            return render(request, 'question/operator_edit.html', locals())
    except ObjectDoesNotExist:
        messages.error(request, 'Question does not exist, question id - {}'.format(question_id))
        return redirect('tboperator_question_list')


@permission_check(UserType.TBOperator)
def question_delete(request, question_id):
    try:
        question = Question.objects.get(id=question_id)
        if question.state == 6 or question.state == 2:
            tboperator.delete_question(question)
            messages.success(request, "Successfully deleted, question id - {}.".format(question_id))

        else:
            messages.warning(request, 'Failed deleted, question id - {}.'.format(question_id))
    except ObjectDoesNotExist:
        messages.error(request, 'Question does not exist, question id - {}'.format(question_id))

    return redirect('tboperator_question_list')
