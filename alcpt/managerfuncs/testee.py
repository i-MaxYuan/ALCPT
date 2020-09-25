from django.db.models import Q
from math import ceil

from alcpt.definitions import QuestionType
from alcpt.models import Question, TestPaper, User, Choice, AnswerSheet

def query_questions(question_type: int, difficulty: int, testee: int, question_content: str):
    queries = Q()
    query_content = ""

    favorite_questions = Question.objects.all().filter(favorite=testee)

    if difficulty:
        queries &= Q(difficulty=difficulty)
        query_content += "&difficulty=" + str(difficulty)

    if question_content:
        query_content += "&question_content=" + str(question_content)

        if question_type:
            if question_type == 1:
                favorite_questions_search = favorite_questions.filter(q_type=1).filter(choice__c_content__icontains=question_content).filter(queries)
            elif question_type == 2:
                favorite_questions_search = favorite_questions.filter(q_type=2).filter(choice__c_content__icontains=question_content).filter(queries)
            elif question_type == 3:
                query1 = favorite_questions.filter(q_type=3).filter(queries).filter(q_content__icontains=question_content)
                query2 = favorite_questions.filter(q_type=3).filter(queries).filter(choice__c_content__icontains=question_content)
                favorite_questions_search = (query1 | query2)
            elif question_type == 4:
                query1 = favorite_questions.filter(q_type=4).filter(queries).filter(q_content__icontains=question_content)
                query2 = favorite_questions.filter(q_type=4).filter(queries).filter(choice__c_content__icontains=question_content)
                favorite_questions_search = (query1 | query2)
            elif question_type == 5:
                query1 = favorite_questions.filter(q_type=5).filter(queries).filter(q_content__icontains=question_content)
                query2 = favorite_questions.filter(q_type=5).filter(queries).filter(choice__c_content__icontains=question_content)
                favorite_questions_search = (query1 | query2)

            favorite_questions_search = favorite_questions_search.distinct()
            query_content += "&question_type=" + str(question_type)

        else:
            query1 = favorite_questions.exclude(q_type=1).exclude(q_type=2).filter(queries).filter(q_content__icontains=question_content)
            query2 = favorite_questions.exclude(q_type=1).exclude(q_type=2).filter(queries).filter(choice__c_content__icontains=question_content)
            query3 = favorite_questions.exclude(q_type=3).exclude(q_type=4).exclude(q_type=5).filter(choice__c_content__icontains=question_content).filter(queries)

            favorite_questions_search = (query1 | query2 | query3).distinct().order_by('id')
    else:
        if question_type:
            queries &= Q(q_type=question_type)
            query_content += "&question_type=" + str(question_type)

        favorite_questions_search = favorite_questions.filter(queries).distinct().order_by('id')

    return query_content, favorite_questions_search



def question_correction(answer_sheet: AnswerSheet):
    answers = answer_sheet.answer_set.all()
    correction_list = []
    for answer in answers:
        if answer.selected == -1:
            pass
        else:
            tmp = []
            for choice in answer.question.choice_set.all():
                tmp.append(choice)


            if tmp[answer.selected-1].is_answer:
                correction_list.append(1)
            else:
                correction_list.append(0)
    return correction_list
