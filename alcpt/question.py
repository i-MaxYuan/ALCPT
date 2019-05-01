import json

from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist, MultipleObjectsReturned
from django.views.decorators.http import require_http_methods

from .models import Question
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType, QuestionType
from .managerfuncs import questionmanager


@permission_check(UserType.QuestionManager)
@require_http_methods(["GET"])
def manager_index(request):
    try:
        page = int(request.GET.get('page', 0))

    except ValueError:
        page = 0

    keywords = {
        'description': request.GET.get('description', ''),
        'question_type': int(request.GET.get('question_type', 0)),
    }

    num_pages, questions = questionmanager.query_question(**keywords, enable=True, page=page)

    for question in questions:
        question.option = json.loads(question.option)

    data = {
        'questions': questions,
        'num_types': range(1, len(QuestionType.__members__) + 1),
        'keywords': keywords,
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'question/list.html', data)


@permission_check(UserType.QuestionManager)
@require_http_methods(["GET"])
def review_question_index(request):
    try:
        page = int(request.GET.get('page', 0))

    except ValueError:
        page = 0

    keywords = {
        'created_by': request.GET.get('created_by', ''),
        'question_type': int(request.GET.get('question_type', 0)),
    }

    num_pages, questions = questionmanager.query_question(**keywords, page=page)

    for question in questions:
        question.option = json.loads(question.option)

    data = {
        'questions': questions,
        'num_types': range(1, len(QuestionType.__members__) + 1),
        'keywords': keywords,
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'question/review.html', data)


@permission_check(UserType.QuestionManager)
@require_http_methods(["GET", "POST"])
def create_question(request):
    if request.method == 'POST':
        try:
            question_type = int(request.POST.get('type'))

        except TypeError:
            raise ArgumentError(message='Not found question type.')

        except ValueError:
            raise IllegalArgumentError(message='Question type must be int.')
        print(question_type)
        difficult = request.POST.get('difficult')
        question = None
        file = None

        if question_type is QuestionType.QA.value[0]:
            question_type = QuestionType.QA
            template = 'question/qa/display.html'
            if 'audio' not in request.FILES:
                raise ArgumentError(message='Missing file field "audio".')

            else:
                file = request.FILES.get('audio')

        elif question_type is QuestionType.ShortConversation.value[0]:
            question_type = QuestionType.ShortConversation
            template = 'question/short_conversation/display.html'
            question = request.POST.get('description')
            if 'audio' not in request.FILES:
                raise ArgumentError(message='Missing file field "audio".')

            else:
                file = request.FILES.get('audio')

        elif question_type is QuestionType.Grammar.value[0]:
            question_type = QuestionType.Grammar
            template = 'question/grammar/display.html'
            question = request.POST.get('description')

        elif question_type is QuestionType.Phrase.value[0]:
            question_type = QuestionType.Phrase
            template = 'question/phrase/display.html'
            question = request.POST.get('description')

        elif question_type is QuestionType.ParagraphUnderstanding.value[0]:
            question_type = QuestionType.ParagraphUnderstanding
            template = 'question/paragraph_understanding/display.html'
            question = request.POST.get('description')

        else:
            raise IllegalArgumentError(message='The question type not in "definitions.py".')

        try:
            answer_index = int(request.POST.get('answer'))

        except TypeError:
            raise ArgumentError(message='Missing answer argument.')

        except ValueError:
            raise IllegalArgumentError(message='Choosing an answer from options.')

        options = []

        for cnt in range(0, 4):
            option = request.POST.get('option-{}'.format(cnt))

            if option:
                options.append(option)

                if cnt is answer_index:
                    answer_index = len(options) - 1

        if len(options) < 4:
            raise ArgumentError(message='Options must have 4.')

        try:
            if Question.objects.get(question=question):
                raise MultipleObjectsReturned('Question has existed.')

        except ObjectDoesNotExist:
            pass

        new_question = questionmanager.create_question(question_type=question_type,
                                                       question=question,
                                                       options=options,
                                                       answer_index=answer_index,
                                                       file=file,
                                                       created_by=request.user,
                                                       difficult=difficult)

        messages.success(request, "Create question successfully.")

        new_question.option = json.loads(new_question.option)

        return render(request, template, {'question': new_question})

    else:
        if 'type' not in request.GET:
            return render(request, 'question/select_type.html')

        try:
            question_type = int(request.GET.get('type'))

        except ValueError:
            raise IllegalArgumentError(message='Question type must be an integer.')

        if question_type is QuestionType.QA.value[0]:
            template = 'question/qa/create.html'

        elif question_type is QuestionType.ShortConversation.value[0]:
            template = 'question/short_conversation/create.html'

        elif question_type is QuestionType.Grammar.value[0]:
            template = 'question/grammar/create.html'

        elif question_type is QuestionType.Phrase.value[0]:
            template = 'question/phrase/create.html'

        elif question_type is QuestionType.ParagraphUnderstanding.value[0]:
            template = 'question/paragraph_understanding/create.html'

        else:
            raise IllegalArgumentError(message='The question type not in "definitions.py".')

        return render(request, template, {'question_type': question_type})


@permission_check(UserType.QuestionManager)
@require_http_methods(["GET", "POST"])
def edit_question(request, question_id):
    try:
        question = Question.objects.get(id=question_id)
        question.option = json.loads(question.option)

    except ObjectDoesNotExist:
        raise ResourceNotFoundError('Can\'t find question id={}'.format(question_id))

    if request.method == 'POST':
        difficult = request.POST.get('difficult')
        description = None
        file = None

        if question.question_type is QuestionType.QA.value[0]:
            question.question_type = QuestionType.QA
            try:
                if 'audio' not in request.FILES:
                    raise ArgumentError(message='Missing file field "audio".')

                else:
                    file = request.FILES.get('audio')

            except ArgumentError:
                pass

        elif question.question_type is QuestionType.ShortConversation.value[0]:
            question.question_type = QuestionType.ShortConversation
            description = request.POST.get('description')
            try:
                if 'audio' not in request.FILES:
                    raise ArgumentError(message='Missing file field "audio".')

                else:
                    file = request.FILES.get('audio')

            except ArgumentError:
                pass

        elif question.question_type is QuestionType.Grammar.value[0]:
            question.question_type = QuestionType.Grammar
            description = request.POST.get('description')

        elif question.question_type is QuestionType.Phrase.value[0]:
            question.question_type = QuestionType.Phrase
            description = request.POST.get('description')

        elif question.question_type is QuestionType.ParagraphUnderstanding.value[0]:
            question.question_type = QuestionType.ParagraphUnderstanding
            description = request.POST.get('description')

        else:
            raise IllegalArgumentError('The question type not in "definitions.py".')

        try:
            answer_index = int(request.POST.get('answer'))

        except TypeError:
            raise ArgumentError(message='Missing answer argument.')

        except ValueError:
            raise IllegalArgumentError(message='Choosing an answer from options.')

        options = []

        for cnt in range(0, 4):
            option = request.POST.get('option-{}'.format(cnt))

            if option:
                options.append(option)

                if cnt is answer_index:
                    answer_index = len(options) - 1

        if len(options) < 4:
            raise ArgumentError(message='Options must have 4.')

        question = questionmanager.update_question(question=question,
                                                   description=description,
                                                   options=options,
                                                   answer_index=answer_index,
                                                   file=file,
                                                   difficult=difficult,
                                                   last_updated=request.user)

        messages.success(request, 'Update question id={}'.format(question.id))

        return redirect(request.POST.get('next', '/question'))

    else:
        if question.question_type is QuestionType.QA.value[0]:
            template = 'question/qa/create.html'

        elif question.question_type is QuestionType.ShortConversation.value[0]:
            template = 'question/short_conversation/create.html'

        elif question.question_type is QuestionType.Grammar.value[0]:
            template = 'question/grammar/create.html'

        elif question.question_type is QuestionType.Phrase.value[0]:
            template = 'question/phrase/create.html'

        elif question.question_type is QuestionType.ParagraphUnderstanding.value[0]:
            template = 'question/paragraph_understanding/create.html'

        else:
            raise IllegalArgumentError('The question type not in "definitions.py".')

        data = {
            'question': question,
            'next': request.META.get('HTTP_REFERER', '/question'),
        }

        return render(request, template, data)


@permission_check(UserType.QuestionManager)
@require_http_methods(["GET"])
def delete_question(request, question_id):
    try:
        question = Question.objects.get(id=question_id)

    except ObjectDoesNotExist:
        raise ResourceNotFoundError('Cannot find question id = {}.'.format(question_id))

    question.enable = False
    question.last_updated_by = request.user
    question.save()

    messages.success(request, 'Delete question id={}.'.format(question_id))

    return redirect(request.META.get('HTTP_REFERER', '/question'))


@permission_check(UserType.QuestionManager)
@require_http_methods(["GET"])
def enable_question(request, question_id):
    try:
        question = Question.objects.get(id=question_id)

    except ObjectDoesNotExist:
        raise ResourceNotFoundError('Cannot find question id = {}.'.format(question_id))

    question.enable = True
    question.last_updated_by = request.user
    question.save()

    messages.success(request, 'Enable question id={}.'.format(question_id))

    return redirect(request.META.get('HTTP_REFERER', '/question/review'))


@permission_check(UserType.QuestionOperator)
@require_http_methods(["GET"])
def manager_index(request):
    try:
        page = int(request.GET.get('page', 0))

    except ValueError:
        page = 0

    keywords = {
        'description': request.GET.get('description', ''),
        'question_type': int(request.GET.get('question_type', 0)),
    }

    num_pages, questions = questionmanager.query_question(**keywords, enable=True, created_by=request.user, page=page)

    for question in questions:
        question.option = json.loads(question.option)

    data = {
        'questions': questions,
        'num_types': range(1, len(QuestionType.__members__) + 1),
        'keywords': keywords,
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'question/list.html', data)