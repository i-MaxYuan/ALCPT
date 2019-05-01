import json
from datetime import datetime
from random import sample, Random

from django.db.models import Q
from django.utils import timezone
from math import ceil

from alcpt.definitions import ExamType, QuestionType
from alcpt.models import Exam, Question, User, AnswerSheet, TestPaper


def query_exams(*, exam_type: ExamType, name: str=None, page: int=None, filter_func=None):
    queries = Q()

    if exam_type:
        queries &= Q(type=exam_type.value[0])

    if name:
        queries &= Q(name__=name)

    exams = Exam.objects.filter(queries).order_by('-created_at')

    for exam in exams:
        exam.start_time = timezone.localtime(exam.start_time)

    if filter_func:
        exams = list(filter(filter_func, exams))

    num_pages = ceil(len(exams) / 10)

    if page and page >= 0:
        exams = exams[page * 10: page * 10 + 10]

    return num_pages, exams


def query_testpapers(*, name: str=None, page: int=None, filter_func=None):
    queries = Q()

    if name:
        queries &= Q(name__=name)

    testpapers = TestPaper.objects.filter(queries).order_by('-created_at')

    if filter_func:
        testpapers = list(filter(filter_func, testpapers))

    num_pages = ceil(len(testpapers) / 10)

    if page and page >= 0:
        testpapers = testpapers[page * 10: page * 10 + 10]

    return num_pages, testpapers


def create_testpaper(name: str, questions: list, created_by: User):
    testpaper = TestPaper.objects.create(name=name,
                                         questions=json.dumps(questions),
                                         created_by=created_by)
    testpaper.enable = True
    testpaper.save()

    return testpaper


def edit_testpaper(testpaper: TestPaper, name: str, questions: list):
    testpaper.name = name
    testpaper.questions = json.dumps(questions)
    testpaper.save()

    return testpaper


def random_select(types_counts: list, question_type:QuestionType, testpaper: TestPaper):
    reach_limit = types_counts[question_type.value[0] - 1]
    selected_questions = testpaper.question_set.filter(question_type=question_type.value[0])

    selected_num = reach_limit - selected_questions.count()

    if selected_num:
        questions = Question.objects.filter(type=question_type.value[0], enable=True).exclude(id__in=selected_questions)

        if questions:
            questions = sample(list(questions), min(len(questions), selected_num))
            for question in questions:
                testpaper.question_set.add(question)

            selected_num = len(questions)

    return selected_num