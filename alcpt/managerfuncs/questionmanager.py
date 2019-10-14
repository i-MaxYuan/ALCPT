import json

from django.db.models import Q
from math import ceil

from alcpt.definitions import QuestionType
from alcpt.models import Question, TestPaper, User
from alcpt.utility import save_file


def query_question(*, description: str=None, question_type: int=None, question_id: int, page: int=0, enable: bool,
                   testpaper: TestPaper=None, created_by: User=None):
    queries = Q(enable=enable)

    if description:
        queries &= Q(question__icontains=description)

    if question_id:
        queries &= Q(id=question_id)


    if question_type:
        queries &= Q(question_type=question_type)

    if created_by:
        queries &= Q(created_by=created_by)

    if testpaper:
        questions = testpaper.question_set

    else:
        questions = Question.objects

    questions = questions.filter(queries)

    if page >= 0:
        num_pages = ceil(questions.count() / 10)
        questions = questions[page * 10: page * 10 + 10]

    else:  # page < 0 -> all
        num_pages = 1

    return num_pages, questions,


def review_question(question: Question, last_updated_by: User):
    question.enable = True
    question.last_updated_by = last_updated_by

    return question


def create_question(question_type: QuestionType, question: str, options: list, answer_index: int, created_by: User,
                    difficult: int, file):
    question = Question.objects.create(question_type=question_type.value[0],
                                       question=question,
                                       option=json.dumps(options),
                                       answer=answer_index,
                                       created_by=created_by,
                                       difficult=difficult)

    if question_type is QuestionType.QA:
        if file:
            question.question_file = save_file(file=file, path='question_{}.mp3'.format(question.id))

    elif question_type is QuestionType.ShortConversation:
        if file:
            question.question_file = save_file(file=file, path='question_{}.mp3'.format(question.id))

    elif question_type is QuestionType.ParagraphUnderstanding:
        pass

    elif question_type is QuestionType.Phrase:
        pass

    elif question_type is QuestionType.Grammar:
        pass

    else:
        raise RuntimeError('Question type "{}"'.format(question_type.name))

    question.save()

    return question


def update_question(question: Question, description: str, options: list, answer_index: int, difficult: int,
                    last_updated: User, file):
    question.question = description
    question.option = json.dumps(options)
    question.answer = answer_index
    question.difficult = difficult
    question.last_updated_by = last_updated

    if question.question_type is QuestionType.QA:
        if file:
            question.question_file = save_file(file=file, path='question_{}.mp3'.format(question.id))

    elif question.question_type is QuestionType.ShortConversation:
        if file:
            question.question_file = save_file(file=file, path='question_{}.mp3'.format(question.id))

    elif question.question_type is QuestionType.ParagraphUnderstanding:
        pass

    elif question.question_type is QuestionType.Phrase:
        pass

    elif question.question_type is QuestionType.Grammar:
        pass

    else:
        raise RuntimeError('Question type "{}"'.format(question.question_type.name))

    question.question_type = question.question_type.value[0]
    question.save()

    return question
