import json
from random import sample

from django.db.models import Q
from django.utils import timezone
from math import ceil

from alcpt.definitions import ExamType, QuestionType
from alcpt.models import Exam, Question, Student, TestPaper, Group, User, Department, Squadron


def query_exams(*, exam_type: ExamType, is_public: bool, student: User=None, name: str=None, page: int=None, filter_func=None):
    queries = Q()
    queries &= Q(exam_type=exam_type.value[0])

    if name:
        queries &= Q(name=name)

    if student:
        queries &= Q(group__member__user=student)

    if is_public:
        queries &= Q(is_public=is_public)

    exams = Exam.objects.filter(queries).order_by('-created_time')

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

    testpapers = TestPaper.objects.filter(queries).order_by('-created_time')

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


def query_students(*, department: Department, grade: int, squadron: Squadron, name: str, page: int=None):
    queries = Q()

    if department:
        queries &= Q(department=department)

    if grade is not None:
        queries &= Q(grade=grade)

    if squadron:
        queries &= Q(squadron=squadron)

    if name is not None:
        queries &= Q(user__serial_number__icontains=name) | Q(user__name__icontains=name)

    users = Student.objects.filter(queries)
    users = users.order_by('-grade')

    num_pages = ceil(len(users) / 10)

    if page and page >= 0:
        users = users[page * 10: page * 10 + 10]

    elif page == 0:
        users = users[0: 10]

    return num_pages, users


def create_testpaper(name: str, created_by: User):
    testpaper = TestPaper.objects.create(name=name,
                                         created_by=created_by)
    testpaper.valid = False
    testpaper.save()

    return testpaper


def edit_testpaper(testpaper: TestPaper, name: str):
    testpaper.name = name
    testpaper.save()

    return testpaper


def create_group(name: str, members: list, created_by: User):
    group = Group.objects.create(name=name,
                                 created_by=created_by)

    for member in members:
        student = Student.objects.get(id=member)
        group.member.add(student)

    group.save()

    return group


def edit_group(group: Group, name: str, members: list):
    group.member.clear()
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
            questions = Question.objects.filter(question_type=question_type.value[0], is_valid=True).exclude(id__in=selected_questions)

            if questions:
                questions = sample(list(questions), min(len(questions), selected_num))
                for question in questions:
                    testpaper.question_set.add(question)

                selected_num = len(questions)

        return selected_num

    else:
        selected_questions = Question.objects.filter(question_type=question_type.value[0], is_valid=True)

        if selected_questions:
            selected_questions = sample(list(selected_questions), reach_limit)

        return selected_questions
