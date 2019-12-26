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
        query_content += "question_type="+str(question_type)
    else:
        query_content += "question_type="

    if question_content:
        queries &= Q(q_content__icontains=question_content)
        query_content += "&question_content="+str(question_content)
    else:
        query_content += "&question_content="

    if difficulty:
        queries &= Q(difficulty=difficulty)
        query_content += "&difficulty="+str(difficulty)
    else:
        query_content += "&difficulty="

    if state:
        queries &= Q(state=state)
        query_content += "&state="+str(state)
    else:
        query_content += "&state="

    # tbmanager doesn't need question.state == 0 ("暫存")
    # use Q to filter Question.objects and order by created time
    questions = Question.objects.exclude(state=0).filter(queries).order_by('created_time')

    return query_content, questions
