from django.db.models import Q
from math import ceil

from alcpt.definitions import QuestionType
from alcpt.models import Question, TestPaper, User, Choice
from alcpt.utility import save_file


# A Q objects(django.db.models.Q) is an object used to encapsulate a collection of keyword arguments.
def query_questions(*, question_type: int, difficulty: int, state: int, question_content: str):
    queries = Q()
    query_content = ""
    all_questions = Question.objects.exclude(state=6).exclude(state=2).exclude(state=3)       # tbmanager doesn't need state = 6 ("暫存")

    if state:
        queries &= Q(state=state)
        query_content += "&state=" + str(state)

    if difficulty:
        queries &= Q(difficulty=difficulty)
        query_content += "&difficulty=" + str(difficulty)

    if question_content:
        query_content += "&question_content=" + str(question_content)

        if question_type:
            if question_type == 1:
                questions = all_questions.filter(q_type=1).filter(choice__c_content__icontains=question_content).filter(queries)
            elif question_type == 2:
                questions = all_questions.filter(q_type=2).filter(choice__c_content__icontains=question_content).filter(queries)
            elif question_type == 3:
                query1 = all_questions.filter(q_type=3).filter(queries).filter(q_content__icontains=question_content)
                query2 = all_questions.filter(q_type=3).filter(queries).filter(choice__c_content__icontains=question_content)
                questions = (query1 | query2)
            elif question_type == 4:
                query1 = all_questions.filter(q_type=4).filter(queries).filter(q_content__icontains=question_content)
                query2 = all_questions.filter(q_type=4).filter(queries).filter(choice__c_content__icontains=question_content)
                questions = (query1 | query2)
            elif question_type == 5:
                query1 = all_questions.filter(q_type=5).filter(queries).filter(q_content__icontains=question_content)
                query2 = all_questions.filter(q_type=5).filter(queries).filter(choice__c_content__icontains=question_content)
                questions = (query1 | query2)

            questions = questions.distinct()
            query_content += "&question_type=" + str(question_type)

        else:
            query1 = all_questions.exclude(q_type=1).exclude(q_type=2).filter(queries).filter(q_content__icontains=question_content)
            query2 = all_questions.exclude(q_type=1).exclude(q_type=2).filter(queries).filter(choice__c_content__icontains=question_content)
            query3 = all_questions.exclude(q_type=3).exclude(q_type=4).exclude(q_type=5).filter(choice__c_content__icontains=question_content).filter(queries)

            questions = (query1 | query2 | query3).distinct().order_by('id')
    else:
        if question_type:
            queries &= Q(q_type=question_type)
            query_content += "&question_type=" + str(question_type)

        questions = all_questions.filter(queries).distinct().order_by('id')

    return query_content, questions
