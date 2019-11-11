from django.db.models import Q
from django.utils.timezone import localtime, timedelta
from math import ceil

from alcpt.definitions import QuestionType
from alcpt.models import AnswerSheet, Student
from alcpt.utility import save_file


def query_answer_sheet(name: str=None, start_time: str=None, end_time: str=None, page: int=0, user: Student=None):
    queries = Q()

    if name:
        queries &= Q(exam__name=name)

    if start_time or end_time:
        queries &= Q(exam__created_time__range=[start_time if start_time else localtime().date() + timedelta(days=-1),
                                               end_time if end_time else localtime().date() + timedelta(days=1)])

    if user:
        queries &= Q(user=user)

    else:
        answer_sheets = AnswerSheet.objects

    answer_sheets = answer_sheets.filter(queries)

    if page >= 0:
        num_pages = ceil(answer_sheets.count() / 10)
        answer_sheets = answer_sheets[page * 10: page * 10 + 10]

    else:  # page < 0 -> all
        num_pages = 1

    return num_pages, answer_sheets
