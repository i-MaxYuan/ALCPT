import json
from datetime import timedelta
from random import Random
from collections import OrderedDict

from django.core.exceptions import ObjectDoesNotExist
from django.shortcuts import render, redirect
from django.views.decorators.http import require_http_methods
from django.utils import timezone

from .managerfuncs import exammanager
from .decorators import permission_check
from .definitions import UserType, ExamType, QuestionType
from .models import AnswerSheet, Exam, TestPaper, Student
from .exceptions import ResourceNotFoundError, ArgumentError, IllegalArgumentError


@permission_check(UserType.Tester)
@require_http_methods(["GET"])
def index(request):
    try:
        page = int(request.GET.get('page', 0))
    except ValueError:
        page = 0

    now = timezone.localtime(timezone.now())
    num_pages, exams = exammanager.query_exams(exam_type=ExamType.Exam,
                                               student=request.user,
                                               filter_func=lambda e: now <= e.start_time + timedelta(minutes=e.duration),
                                               public=True)

    for exam in exams:
        if now < exam.start_time:
            exam.status = 0
            continue

        try:
            answer_sheet = AnswerSheet.objects.get(user=Student.objects.get(user=request.user), exam=exam)
            answer_sheet.answers = json.loads(answer_sheet.answers)

            for q_id in answer_sheet.answers:
                if answer_sheet.answers[q_id] < 0:
                    exam.status = 2  # the student does not complete this exam yet
                    break
            else:
                exam.status = 3  # all question had been answered
        except ObjectDoesNotExist:
            exam.status = 1

    data = {
        'exams': exams,
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'simulation_exam/simulation_list.html', data)


@permission_check(UserType.Tester)
@require_http_methods(["GET", "POST"])
def take_exam(request, exam_id, question_index):
    try:
        question_index = int(question_index)

    except ValueError:
        question_index = 0

    try:
        exam = Exam.objects.get(id=exam_id)

        now = timezone.localtime(timezone.now())
        if now < exam.start_time or not exam.public:
            raise IllegalArgumentError(message='The exam not start yet.')
        elif now > exam.start_time + timedelta(minutes=exam.duration):
            raise IllegalArgumentError(message='The exam time is up.')
    except ObjectDoesNotExist:
        raise ResourceNotFoundError(message='Cannot find exam {}'.format(exam_id))

    try:
        testpaper = TestPaper.objects.get(id=exam.testpaper.id)

    except ObjectDoesNotExist:
        raise ResourceNotFoundError(message='Cannot find exam\'s testpaper {}'.format(exam.testpaper))

    shuffled_questions = []
    random = Random(request.user.id)

    for question_type in QuestionType.__members__.values():
        questions = list(testpaper.question_set.filter(question_type=question_type.value[0]).order_by('?'))

        random.shuffle(questions)
        shuffled_questions.extend(questions)

    try:
        answer_sheet = AnswerSheet.objects.get(user=Student.objects.get(user=request.user), exam=exam)
        answers = json.loads(answer_sheet.answers)
    except ObjectDoesNotExist:
        # answers = {str(question_type.value[0]): {} for question_type in QuestionType.__members__.values()}
        # questions = {str(shuffled_questions.index(question)): {str(question.id): random.sample(range(4), 4)} for
        #              question in shuffled_questions}
        answers = OrderedDict((question.id, -1) for question in shuffled_questions)
        questions = OrderedDict(
            (shuffled_questions.index(question), (question.id, random.sample(range(4), 4))) for question in
            shuffled_questions)
        # for question in shuffled_questions:
        #     answers[str(question.question_type)][str(question.id)] = -1

        answer_sheet = AnswerSheet.objects.create(user=Student.objects.get(user=request.user),
                                                  exam_id=exam_id,
                                                  questions=json.dumps(questions),
                                                  answers=json.dumps(answers),
                                                  score=0)

    for question in shuffled_questions:
        if answers[str(question.id)] < 0:
            question.option = json.loads(question.option)
            question_index = shuffled_questions.index(question)
            break
    else:
        raise IllegalArgumentError(message='All questions had been answered.')

    if request.method == "GET":
        data = {
            'exam': exam,
            'answers': answers,
            'question': question,
            'index': question_index,
            'has_next': question_index + 1 < len(shuffled_questions),
        }

        return render(request, 'simulation_exam/simulation_answer.html', data)
    else:
        try:
            answer = int(request.POST.get('answer-{}'.format(question.id)))
            print(type(answer))

            if answer not in range(len(question.option)):
                raise IllegalArgumentError(message='Invalid answer.')
        except TypeError:
            raise ArgumentError(message='At least one option needs to be selected.')

        answers[question.id] = answer
        answer_sheet.answers = json.dumps(answers)
        answer_sheet.save()

        if question_index + 1 < len(shuffled_questions):
            return redirect('/tester/simulation-exam/{}/take/{}'.format(exam_id, question_index + 1))
        else:
            return redirect('/simulation-exam')