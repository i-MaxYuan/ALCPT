from django.db.models import Q
from math import ceil

from alcpt.definitions import QuestionType
from alcpt.models import Question, TestPaper, User, Choice
from alcpt.utility import save_file


# A Q objects(django.db.models.Q) is an object used to encapsulate a collection of keyword arguments.
def query_questions(*, question_type: int, question_content: str, difficulty: int, state: int):
    queries = Q()
    query_content = ""

    if question_type:
        queries &= Q(q_type=question_type)
        query_content += "question_type="+str(question_type)

    if question_content:
        queries &= Q(q_content__icontains=question_content)
        query_content += "&question_content="+str(question_content)

    if difficulty:
        queries &= Q(difficulty=difficulty)
        query_content += "&difficulty="+str(difficulty)

    if state:
        queries &= Q(state=state)
        query_content += "&state="+str(state)

    # tbmanager doesn't need question.state == 0 ("暫存")
    # use Q to filter Question.objects and order by created time
    questions = list(Question.objects.exclude(state=0).filter(queries).order_by('created_time'))

    if question_content is not None:
        choices = Choice.objects.filter(c_content__icontains=question_content)
        choice_2_questions = []
        for choice in choices:
            if choice.question in choice_2_questions:
                pass
            else:
                choice_2_questions.append(choice.question)

        for question in choice_2_questions:
            if question in questions:
                pass
            else:
                questions.append(question)

    return query_content, questions
