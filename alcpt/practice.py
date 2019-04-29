import json
from datetime import timedelta

from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from django.shortcuts import render, redirect
from django.utils import timezone
from django.views.decorators.http import require_http_methods

from .exceptions import IllegalArgumentError, ArgumentError, ObjectNotFoundError
from .decorators import permission_check
from .definitions import UserType, QuestionType, ExamType
from .models import Exam, AnswerSheet


@permission_check(UserType.Tester)
@require_http_methods(["GET", "POST"])
def create(request, practice_type):
    if request.method == 'POST':
        raw_question_types = []
        for question_type in request.POST.get('question_type').split(','):
            if question_type is None or len(question_type) is 0:
                raise IllegalArgumentError('Question type is null.')

            try:
                raw_question_types.append(int(question_type))

            except ValueError:
                raise IllegalArgumentError('Question type must be integer.')

        question_types = []
        for valid_type in [QuestionType.QA, QuestionType.ShortConversation] if practice_type == 'listening' \
                else [QuestionType.Grammar, QuestionType.Phrase, QuestionType.ParagraphUnderstanding]:
            if valid_type.value[0] in raw_question_types:
                question_types.append(valid_type)

        try:
            num_questions = int(request.POST.get('num_questions', 0))

        except TypeError:
            raise ArgumentError('Question amount is null.')

        except ValueError:
            raise IllegalArgumentError('Question amount must be integer.')

        practice_type = ExamType.Listening if practice_type == 'listening' else ExamType.Reading

