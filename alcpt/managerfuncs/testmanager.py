from django.db.models import Q
from django.utils import timezone
import random

from alcpt.models import User, TestPaper, Question, Exam, AnswerSheet
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

    return questions


def quantity_confirmation(testpaper: TestPaper):
    confirmation_list = [False, False, False, False, False]
    question_types = list(QuestionType.__members__.values())
    question_type_counts = QuestionTypeCounts.Exam.value[0]

    questionData = zip(range(5), question_types, question_type_counts)

    for x, question_type, question_type_count in questionData:
        if len(testpaper.question_list.filter(q_type=question_type.value[0])) == question_type_count:
            confirmation_list[x] = True
        else:
            pass

    if False in confirmation_list:
        return False
    else:
        return True


def auto_pick(testpaper: TestPaper, question_type: int):
    Q_type_all_passed_questions = set(Question.objects.filter(state=1).filter(q_type=question_type))
    Q_type_selected_questions = set(testpaper.question_list.all().filter(q_type=question_type))
    Q_type_not_used_questions = list(Q_type_all_passed_questions.difference(Q_type_selected_questions))

    existed_num = len(testpaper.question_list.all().filter(q_type=question_type))
    necessary_num = QuestionTypeCounts.Exam.value[0][question_type-1]
    missing = necessary_num - existed_num

    random.shuffle(Q_type_not_used_questions)

    for question in Q_type_not_used_questions[:missing]:
        testpaper.question_list.add(question)

    testpaper.save()

    return missing


def manual_pick(question_type: int):
    passed_questions = Question.objects.filter(state=1)
    questions = []

    if question_type == 1:
        questions = list(passed_questions.filter(q_type=1))

    if question_type == 2:
        questions = list(passed_questions.filter(q_type=2))

    if question_type == 3:
        questions = list(passed_questions.filter(q_type=3))

    if question_type == 4:
        questions = list(passed_questions.filter(q_type=4))

    if question_type == 5:
        questions = list(passed_questions.filter(q_type=5))

    return questions


def calculate_score(exam_id: int, answer_sheet: AnswerSheet):
    answers = answer_sheet.answer_set.all()

    score = 0
    for answer in answers:
        if answer.selected == -1:
            pass
        else:
            tmp = []
            for choice in answer.question.choice_set.all():
                tmp.append(choice)

            if tmp[answer.selected-1].is_answer:
                score += 1
            else:
                pass

    # calculate average score of practice
    answer_sheet.score = int(score / len(answers) * 100)
    answer_sheet.is_finished = True
    answer_sheet.save()

    exam = Exam.objects.get(id=exam_id)
    if exam.is_public:
        public_exam_average_score(exam)
    else:
        exam.average_score = answer_sheet.score
        exam.save()

    return answer_sheet.score


def public_exam_average_score(exam: Exam):
    total_score = 0

    for answer_sheet in exam.answersheet_set.all():
        total_score += answer_sheet.score

    exam.average_score = total_score / exam.answersheet_set.all().count()
    exam.save()
