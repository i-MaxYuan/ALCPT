import json
from math import ceil

from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from django.views.decorators.http import require_http_methods

from .models import Question
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType, QuestionType
from .managerfuncs import questionmanager


@permission_check(UserType.QuestionManager)
@require_http_methods(["GET"])
def index(request):
    try:
        page = int(request.GET.get('page', 0))

    except ValueError:
        page = 0

    questions = Question.objects

    if page >= 0:
        num_pages = ceil(questions.count() / 10)
        questions = questions[page * 10: page * 10 + 10]

    else:
        num_pages = 1

    for question in questions:
        question.option = json.loads(question.option)

    data = {
        'questions': questions,
        'num_types': range(1, len(QuestionType.__members__) + 1),
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'management/question/list.html', data)


@permission_check(UserType.QuestionManager)
@require_http_methods(["GET", "POST"])
def create_questioon(request):
    if request.method == 'POST':
        try:
            question_type = int(request.POST.get('type'))

        except TypeError:
            raise ArgumentError(message='Not found question type.')

        except ValueError:
            raise IllegalArgumentError(message='Question type must be int.')

        question = None
        file = None

        if question_type is QuestionType.QA.value[0]:
            question_type = QuestionType.QA
            template = 'management/question/qa/display.html'
            if 'audio' not in request.FILES:
                raise ArgumentError(message='Missing file field "audio".')

            else:
                file = request.FILES.get('audio')

        elif question_type is QuestionType.ShortConversation.value[0]:
            question_type = QuestionType.ShortConversation
            template = 'management/question/short_conversation/display.html'
            question = request.POST.get('question')
            if 'audio' not in request.FILES:
                raise ArgumentError(message='Missing file field "audio".')

            else:
                file = request.FILES.get('audio')

        elif question_type is QuestionType.Grammar.value[0]:
            question_type = QuestionType.Grammar
            template = 'management/question/grammar/display.html'
            question = request.POST.get('question')

        elif question_type is QuestionType.Phrase.value[0]:
            question_type = QuestionType.Grammar
            template = 'management/question/phrase/display.html'
            question = request.POST.get('question')

        elif question_type is QuestionType.ParagraphUnderstanding.value[0]:
            question_type = QuestionType.Grammar
            template = 'management/question/paragraph_understanding/display.html'
            question = request.POST.get('question')

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

        new_question = questionmanager.create_question(question_type=question_type,
                                                       question=question,
                                                       options=options,
                                                       answer_index=answer_index,
                                                       file=file)

        messages.success(request, "Create question successfully.")

        new_question.option = json.loads(new_question.option)

        return render(request, template, {'question': new_question})

    else:
        if 'type' not in request.GET:
            return render(request, 'management/question/select_type.html')

        try:
            question_type = int(request.GET.get('type'))

        except ValueError:
            raise IllegalArgumentError(message='Question type must be an integer.')

        if question_type is QuestionType.QA.value[0]:
            template = 'management/question/qa/display.html'

        elif question_type is QuestionType.ShortConversation.value[0]:
            template = 'management/question/short_conversation/display.html'

        elif question_type is QuestionType.Grammar.value[0]:
            template = 'management/question/grammar/display.html'

        elif question_type is QuestionType.Phrase.value[0]:
            template = 'management/question/phrase/display.html'

        elif question_type is QuestionType.ParagraphUnderstanding.value[0]:
            template = 'management/question/paragraph_understanding/display.html'

        else:
            raise IllegalArgumentError(message='The question type not in "definitions.py".')

        return render(request, template, {'question_type': question_type})


@permission_check(UserType.QuestionManager)
@require_http_methods(["GET"])
def delete_question(request, question_id):
    try:
        question = Question.objects.get(id=question_id)

    except ObjectDoesNotExist:
        raise ResourceNotFoundError('Cannot find question id = {}.'.format(question_id))

    question.enable = False
    question.save()

    messages.success(request, 'Delete question id={}.'.format(question_id))

    return redirect(request.META.get('HTTP_REFERER', '/question'))