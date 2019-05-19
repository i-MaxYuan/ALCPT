import json
from random import sample

from django.db.models import Q
from django.utils import timezone
from math import ceil

from alcpt.definitions import ExamType, QuestionType
from alcpt.models import Exam, Question, Student, TestPaper, Group, User


def query_exams(*, exam_type: ExamType, student: Student=None, name: str=None, page: int=None, filter_func=None):
    queries = Q()
    queries &= Q(type=exam_type.value[0])

    if name:
        queries &= Q(name=name)

    if student:
        queries &= Q(group__member__user=student)

    exams = Exam.objects.filter(queries).order_by('-create_time')

    for exam in exams:
        exam.start_time = timezone.localtime(exam.start_time)

    if filter_func:
        exams = list(filter(filter_func, exams))

    num_pages = ceil(len(exams) / 10)

    if page and page >= 0:
        exams = exams[page * 10: page * 10 + 10]

    return num_pages, exams


def query_testpapers(*, name: str=None, page: int=None):
    queries = Q()

    if name:
        queries &= Q(name=name)

    testpapers = TestPaper.objects.filter(queries).order_by('-create_time')

    num_pages = ceil(len(testpapers) / 10)

    if page and page >= 0:
        testpapers = testpapers[page * 10: page * 10 + 10]

    return num_pages, testpapers


def query_groups(*, name: str=None, page: int=None):
    queries = Q()

    if name:
        queries &= Q(name=name)

    groups = Group.objects.filter(queries).order_by('-name')

    num_pages = ceil(len(groups) / 10)

    if page and page >= 0:
        groups = groups[page * 10: page * 10 + 10]

    return num_pages, groups


def create_testpaper(name: str, created_by: User):
    testpaper = TestPaper.objects.create(name=name,
                                         created_by=created_by)
    testpaper.enable = False
    testpaper.save()

    return testpaper


def edit_testpaper(testpaper: TestPaper, name: str, questions: list):
    testpaper.name = name
    testpaper.questions = json.dumps(questions)
    testpaper.save()

    return testpaper


def create_group(name: str, members: list):
    group = Group.objects.create(name=name)

    for member in members:
        student = Student.objects.get(id=member)
        group.member.add(student)

    group.save()

    return group


def edit_group(group: Group, name: str, members: list):
    for member in members:
        student = Student.objects.get(id=member)
        group.member.add(student)

    group.name = name
    group.save()

    return group


def random_select(types_counts: list, question_type: QuestionType, testpaper: TestPaper=None):
    reach_limit = types_counts[question_type.value[0] - 1]
    if testpaper:
        selected_questions = testpaper.question_set.filter(question_type=question_type.value[0])

        selected_num = reach_limit - selected_questions.count()

        if selected_num:
            questions = Question.objects.filter(question_type=question_type.value[0], enable=True).exclude(id__in=selected_questions)

            if questions:
                questions = sample(list(questions), min(len(questions), selected_num))
                for question in questions:
                    testpaper.question_set.add(question)

                selected_num = len(questions)

        return selected_num

    else:
        selected_questions = Question.objects.filter(question_type=question_type.value[0], enable=True)

        if selected_questions:
            selected_questions = sample(list(selected_questions), reach_limit)

        return selected_questions
