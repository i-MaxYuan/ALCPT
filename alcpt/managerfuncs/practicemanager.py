from datetime import datetime

from alcpt.definitions import ExamType, QuestionType
from alcpt.exceptions import IllegalArgumentError
from alcpt.models import User, Exam, Student, AnswerSheet, Question
from .exammanager import random_select


def create_practice(*, user: User, practice_type: ExamType, question_types: list, num_questions: int):
    now = datetime.now()
    name = "{}-practice-{}-{}".format(practice_type.value[1], user.serial_number, now)
    question_type_counts = []
    for question_type in QuestionType.__members__.values():
        if question_type in question_types:
            question_type_counts.append(int(num_questions / len(question_types)))
        else:
            question_type_counts.append(0)

    if sum(question_type_counts) != num_questions:
        i = list(QuestionType.__members__.values()).index(question_types[len(question_types) - 1])
        question_type_counts[i] += num_questions - sum(question_type_counts)

    num_questions_selected = 0
    selected_questions = []
    for question_type in question_types:
        selected_questions += random_select(question_type_counts, question_type)
        num_questions_selected += len(selected_questions)
    if num_questions_selected < num_questions:
        raise IllegalArgumentError(message="There is too few questions in the database.")

    practice = Exam.objects.create(name=name,
                                   type=practice_type,
                                   start_time=now,
                                   created_by=user)

    return practice, selected_questions


def evaluate_score(*, student: Student, answer_sheet: AnswerSheet):
    questions

