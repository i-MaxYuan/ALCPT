from django.db.models import Q
from math import ceil

from alcpt.definitions import QuestionType
from alcpt.models import Question, TestPaper, User
from alcpt.utility import save_file


# A Q objects(django.db.models.Q) is an object used to encapsulate a collection of keyword arguments.
def query_questions(*, question_type: int, question_content: str, difficulty: int, state: int):
    queries = Q()
    query_content = ""

    if question_type:
        queries &= Q(q_type=question_type)
        query_content += "question_type=" + str(question_type)

    if question_content:
        queries &= Q(q_content__icontains=question_content)
        query_content += "&question_content=" + str(question_content)

    if difficulty:
        queries &= Q(difficulty=difficulty)
        query_content += "&difficulty=" + str(difficulty)

    if state:
        queries &= Q(state=state)
        query_content += "&state=" + str(state)

    # tbmanager doesn't need question.state == 1(審核通過) | 3(等待審核) | 5(被回報錯誤，已處理)
    # use Q to filter Question.objects and order by created time
    questions = Question.objects.exclude(state=1).exclude(state=3).exclude(state=5).filter(queries).order_by('-created_time')

    return query_content, questions


# tboperator create a reading question in db
def create_reading_question(q_content: str, q_type: str, created_by: User, difficulty: int):
    reading_question = Question.objects.create(q_content=q_content,
                                               q_type=q_type,
                                               created_by=created_by,
                                               difficulty=difficulty)
    reading_question.save()

    return reading_question


# tboperator create a listening question in db
def create_listening_question(q_file, q_type: str, created_by: User, difficulty: int):
    listening_question = Question.objects.create(q_type=q_type,
                                                 created_by=created_by,
                                                 difficulty=difficulty)
    listening_question.q_file = save_file(file=q_file, path='question_{}'.format(listening_question.id))

    listening_question.save()

    return listening_question


