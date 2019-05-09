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
from .models import Exam, AnswerSheet, Question, Student
from .managerfuncs import practice


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
        practice =

        return redirect('/practice/{}/take'.format(practice.id))

    else:
        question_types = []

        if practice_type == 'listening':
            question_types.extend([[QuestionType.QA.value[0], 'quora'],
                                   [QuestionType.ShortConversation.value[0], 'comments']])

        elif practice_type == 'reading':
            question_types.extend([[QuestionType.Grammar.value[0], 'pencil-square-o'],
                                   [QuestionType.Phrase.value[0], 'language'],
                                   [QuestionType.ParagraphUnderstanding.value[0], 'book']])

        else:
            raise IllegalArgumentError('Unknow practice type "{}"'.format(practice_type))

        data = {
            'practice_type': practice_type,
            'question_types': question_types,
        }

        return render(request, 'practice/create.html', data)


@permission_check(UserType.Tester)
@require_http_methods(["GET", "POST"])
def take_practice(request, practice_id, question_index):
    try:
        question_index = int(question_index)

    except ValueError:
        question_index = 0

    try:
        answer_sheet = AnswerSheet.objects.get(exam_id=practice_id,user=Student.objects.get(user=request.user))
        answers = json.loads(answer_sheet.answers)
        questions = json.loads(answer_sheet.questions)

        if answer_sheet.finish:
            raise IllegalArgumentError('This answer_sheet is finished.')

    except ObjectDoesNotExist:
        raise ObjectNotFoundError('Can\'t find answer_sheet {}'.format(practice_id))

    answer_num = 0
    for question_type in answers:
        for q_id in answers[question_type]:
            answer_num += 1
            if answers[question_type][q_id] < 0:
                all_answered = False

            else:
                all_answered = True

    if question_index >= answer_num:
        raise IllegalArgumentError('Question index out of range.')

    else:
        question_id, options = list(questions[str(question_index)].items())[0]
        question = Question.objects.get(id=int(question_id))
        question.option = json.loads(question.option)

    if request.method == 'POST':
        try:
            answer = int(request.POST.get('answer-{}'.format(question.id)))

            if answer not in range(len(question.options)):
                raise IllegalArgumentError(message='Invalid answer.')

        except TypeError:
            raise IllegalArgumentError(message='At least one option needs to be selected.')

        answers[str(question.question_type)][str(question_id)] = answer
        answer_sheet.answers = json.dumps(answers)
        answer_sheet.save()

        if question_index + 1 < answer_num and not all_answered:
            return redirect('/practice/{}/take/{}'.format(practice_id, question_index + 1))

        else:
            answers = json.loads(answer_sheet.answers)
            not_answered = []
            for question_type in answers:
                if answers[question_type][question_index] < 0:
                        not_answered.append(question_index)

            if not_answered:
                raise IllegalArgumentError('The following questions have not been answered: {}.'.format(
                    ', '.join(not_answered)))

            practice.evaluate_score(student=request.user, answer_sheet=answer_sheet)

            answer_sheet.finish = True
            answer_sheet.save()

            messages.success(request, "Complete the practice.")

            return redirect('/')

    else:
        data = {
            'answer_sheet': answer_sheet,
            'question': question,
            'index': question_index,
            'has_next': question_index + 1 < answer_num,
            'selected_answer': answers[str(question.question_type)][str(question.id)],
            'answers': answers,
            'num_questions': range(answer_num),
            'all_answered': all_answered,
        }

        return render(request, 'practice/answer.html', data)
