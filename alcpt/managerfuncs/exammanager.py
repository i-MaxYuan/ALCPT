import json
from datetime import datetime
from random import sample, Random

from django.db.models import Q
from django.utils import timezone
from math import ceil

from alcpt.definitions import ExamType, QuestionType
from alcpt.models import Exam, Question, User, AnswerSheet, TestPaper


def random_select(types_counts: list, question_type:QuestionType, testpaper: TestPaper):
    reach_limit = types_counts[question_type.value[0] - 1]
    selected_questions = testpaper.question_set.filter(question_type=question_type.value[0])

    selected_num = reach_limit - selected_questions.count()

    if selected_num:
        questions = Question.objects.filter(type=question_type.value[0], enable=True).exclude(id__in=selected_questions)

        if questions:
            questions = sample(list(questions), min(len(questions), selected_num))
            for question in questions:
                testpaper.question_set.add(question)

            selected_num = len(questions)

    return selected_num