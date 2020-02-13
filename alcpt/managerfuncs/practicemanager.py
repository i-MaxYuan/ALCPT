from django.utils import timezone

from datetime import datetime

from ..managerfuncs import testmanager
from .testmanager import random_select
from alcpt.models import User, Exam, Question, TestPaper, AnswerSheet
from alcpt.definitions import QuestionType, ExamType, QuestionTypeCounts
from alcpt.exceptions import IllegalArgumentError


# practicemanager create a practice
def create_practice(*, user: User, practice_type: ExamType, question_types: list, question_num: int, integration: bool = False):
    now = datetime.now()

    practice_name = "{}-{}".format(practice_type.value[1], now.strftime('%Y/%m/%d %H:%M:%d'))

    question_type_counts = QuestionTypeCounts.Exam.value[0] if integration else []

    if not integration:
        # how many questions will be selected in any question_type
        for question_type in QuestionType.__members__.values():
            if str(question_type.value[0]) in question_types:
                question_type_counts.append(int(question_num / len(question_types)))
            else:
                question_type_counts.append(0)

        if sum(question_type_counts) != question_num:
            q_ts = []
            for q_t in QuestionType:
                q_ts.append(q_t.value[0])
            i = q_ts.index(int(question_types[len(question_types) - 1]))
            question_type_counts[i] += question_num - sum(question_type_counts)

    # use testmanager.random_select to shuffle question
    selected_questions = testmanager.random_select(question_type_counts)

    practice_testpaper = testmanager.create_testpaper(name=practice_name, created_by=user, is_testpaper=0)

    # add the questions into practice_testpaper
    for question in selected_questions:
        practice_testpaper.question_set.add(question)

    practice_exam = Exam.objects.create(name=practice_name, exam_type=practice_type.value[0], testpaper=practice_testpaper,
                                        duration=0, created_by=user)

    return practice_exam

