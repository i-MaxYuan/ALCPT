import json
from datetime import datetime

from alcpt.definitions import ExamType, QuestionType, QuestionTypeCounts
from alcpt.exceptions import IllegalArgumentError
from alcpt.models import User, Exam, Student, AnswerSheet, Question
from .testmanager import random_select


def create_practice(*, user: User, practice_type: ExamType, question_types: list, num_questions: int, integration: bool=False):

    now = datetime.now()
    name = "{}-practice-{}-{}".format(practice_type.value[1], user.serial_number, now)
    question_type_counts = QuestionTypeCounts.Exam.value[0] if integration else []

    if not integration:
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
                                   type=practice_type.value[0],
                                   start_time=now,
                                   created_by=user)

    return practice, selected_questions


def evaluate_score(*, answer_sheet: AnswerSheet):
    questions = json.loads(answer_sheet.questions)

    answers = answer_sheet.answers
    if type(answers) is str:
        answers = json.loads(answer_sheet.answers)

    num_correct = 0
    for index in questions:
        question_id = questions[index][0]
        user_ans = answers[question_id]
        question = Question.objects.get(id=question_id)
        correct_ans = question.answer
        question.use_time += 1
        if user_ans == correct_ans:
            num_correct += 1
            question.correct_time += 1

        if question.use_time >= 30:
            if question.correct_rate > 66:
                question.difficult = 3

            elif question.correct_rate < 33:
                question.difficult = 1

            else:
                question.difficult = 2

        question.save()

    answer_sheet.score = num_correct
    answer_sheet.save()

    return num_correct


