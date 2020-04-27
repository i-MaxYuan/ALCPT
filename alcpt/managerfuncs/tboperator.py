from django.db.models import Q
from math import ceil

from alcpt.definitions import QuestionType
from alcpt.models import Question, TestPaper, User
from alcpt.managerfuncs.system import question_file_storage


# A Q objects(django.db.models.Q) is an object used to encapsulate a collection of keyword arguments.
def query_questions(*, question_type: int, difficulty: int, state: int, question_content: str):
    queries = Q()
    query_content = ""
    # tboperator doesn't need state = 1,("審核通過") 3("等待審核"), 5("被回報錯誤，已處理")
    all_questions = Question.objects.exclude(state=1).exclude(state=3).exclude(state=5)

    if state:
        queries &= Q(state=state)
        query_content += "&state=" + str(state)

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

        questions = all_questions.filter(queries).order_by('-created_time')

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
    question_file_storage(listening_question, q_file)

    listening_question.save()

    return listening_question


def delete_question(question: Question):
    for choice in question.choice_set.all():
        choice.delete()

    question.q_file.delete(save=True)

    question.delete()
