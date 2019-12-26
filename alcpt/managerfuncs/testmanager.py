from django.db.models import Q
from django.utils import timezone
import random

from alcpt.models import User, TestPaper, Question, Exam
from alcpt.definitions import QuestionType, ExamType, QuestionTypeCounts


# testmanager create a testpaper in db
def create_testpaper(name: str, created_by: User, is_testpaper: int):
    testpaper = TestPaper.objects.create(name=name,
                                         created_by_id=created_by.id,
                                         is_testpaper=is_testpaper)
    testpaper.valid = False
    testpaper.save()

    return testpaper


def edit_testpaper(testpaper: TestPaper, name: str):
    testpaper.name = name
    testpaper.save()

    return testpaper


# use random.shuffle to change order of list
def random_select(types_counts: list):
    passed_questions = Question.objects.filter(state=1)

    qaList = list(passed_questions.filter(q_type=1))
    shortConversationList = list(passed_questions.filter(q_type=2))
    grammarList = list(passed_questions.filter(q_type=3))
    phraseList = list(passed_questions.filter(q_type=4))
    paragraphUnderstandingList = list(passed_questions.filter(q_type=5))

    random.shuffle(qaList)
    random.shuffle(shortConversationList)
    random.shuffle(grammarList)
    random.shuffle(phraseList)
    random.shuffle(paragraphUnderstandingList)

    questions = []
    questions.extend(qaList[:types_counts[0]])
    questions.extend(shortConversationList[:types_counts[1]])
    questions.extend(grammarList[:types_counts[2]])
    questions.extend(phraseList[:types_counts[3]])
    questions.extend(paragraphUnderstandingList[:types_counts[4]])

    for question in questions:
        question.used_freq += 1
        question.save()

    return questions


def limit_check(testpaper: TestPaper, q_type: QuestionType):
    testpaper = testpaper

    if len(testpaper.question_set.filter(q_type=q_type.value[0])) >= QuestionTypeCounts.Exam.value[0][q_type.value[0]-1]:
        return True
    else:
        return False


def auto_pick(testpaper: TestPaper, type_counts: list, question_type: int):
    passed_questions = Question.objects.filter(state=1)
    questions = []

    if question_type == 1:
        qaList = list(passed_questions.filter(q_type=1))
        random.shuffle(qaList)
        questions.extend(qaList[:type_counts[question_type-1]])

    if question_type == 2:
        shortConversationList = list(passed_questions.filter(q_type=2))
        random.shuffle(shortConversationList)
        questions.extend(shortConversationList[:type_counts[question_type-1]])

    if question_type == 3:
        grammarList = list(passed_questions.filter(q_type=3))
        random.shuffle(grammarList)
        questions.extend(grammarList[:type_counts[question_type-1]])

    if question_type == 4:
        phraseList = list(passed_questions.filter(q_type=4))
        random.shuffle(phraseList)
        questions.extend(phraseList[:type_counts[question_type-1]])

    if question_type == 5:
        paragraphUnderstandingList = list(passed_questions.filter(q_type=5))
        random.shuffle(paragraphUnderstandingList)
        questions.extend(paragraphUnderstandingList[:type_counts[question_type-1]])

    for question in questions:
        testpaper.question_set.add(question)

    return len(questions)


# def manual_pick():
