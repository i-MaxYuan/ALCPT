from django import template

from django.core.exceptions import ObjectDoesNotExist

from alcpt.definitions import UserType, QuestionType, ExamType
from alcpt.models import User, Student, Question, ReportCategory, Exam, Report
from alcpt.utility import set_query_parameter
from alcpt.exceptions import IllegalArgumentError, ObjectNotFoundError

register = template.Library()


# Returns True if the user has the specified permission, where perm is in the format "<app label>.<permission codename>"
@register.filter(name='has_perm')
def has_perm(user: User, required_privilege: UserType):
    return user.has_perm(UserType[required_privilege])


# Returns True if the user has the specified permission, where perm is in the format "<app label>.<permission codename>"
@register.filter(name='has_perms')
def has_perms(user: User, required_privilege: UserType):
    return user.has_perm(required_privilege)


@register.filter(name='has_permission')
def has_permission(user: User, privilege: UserType):
    return user.privilege & privilege.value[0] > 0


# check whether question_type is readable question_type
@register.filter(name='readable_question_type')
def readable_question_type(question_type: int):
    for q in QuestionType.__members__.values():
        if question_type is q.value[0]:
            return q.value[1]
    else:
        raise IllegalArgumentError(message='Unknown question type {}.'.format(question_type))


@register.filter(name='readable_question_difficulty')
def readable_question_difficulty(difficulty: int):
    DIFFICULTY = (
        (0, ''),
        (1, 'Easy'),
        (2, 'Medium'),
        (3, 'Hard'),
    )

    return DIFFICULTY[difficulty][1]


# check whether user_type is readable user_type(int or str)
@register.filter(name='readable_privilege')
def readable_user_type(privilege):
    if type(privilege) is str:
        for u_type in UserType.__members__.values():
            if u_type.name == privilege:
                return u_type.value[1]
    elif type(privilege) is int:
        for u_type in UserType.__members__.values():
            if u_type is UserType.Admin:
                if privilege is UserType.SystemManager.value[0]:
                    return UserType.SystemManager.value[1]
            elif (privilege & u_type.value[0]) > 0:
                return u_type.value[1]
        else:
            raise IllegalArgumentError(message='Unknown user type {}.'.format(privilege))
    else:
        raise IllegalArgumentError(message='Unknown user type argument which type is {}'.format(type(privilege)))


# check whether exam_type is readable type
@register.filter(name='readable_exam_type')
def readable_state(exam_type: int):
    for et in ExamType.__members__.values():
        if exam_type is et.value[0]:
            return et.value[1]
    else:
        raise IllegalArgumentError(message='Unknown question type {}.'.format(exam_type))


@register.filter(name='replace_page')
def replace_page(full_path: str, page: int):
    return set_query_parameter(full_path, 'page', page)


@register.filter(name='range_to')
def range_to(from_val: int, to_val: int):
    return range(from_val, to_val + 1)


@register.filter(name='lookup')
def range_to(arr: list, i: int):
    return arr[i]


# check whether user is student
@register.filter(name='is_student')
def is_student(user: User):
    try:
        student = Student.objects.get(user=user)
        return student

    except Exception:
        return False


@register.filter(name='readableIdentity')
def readableIdentity(identity: int):
    IDENTITY = (
        (0, ''),
        (1, 'Visitor'),
        (2, 'Student'),
        (3, 'Teacher'),
    )
    return IDENTITY[identity][1]


@register.filter(name='student_data')
def student_data(user: User):
    student = Student.objects.get(user=user)
    try:
        data = [student.department.name, student.grade, student.squadron.name]
        return data

    except Exception:
        data = ['None', student.grade, 'None']
        return data


@register.filter(name='check_correct')
def check_correct(option: str, question: Question):
    if question.option.index(option) == question.answer:
        return True

    else:
        return False


@register.filter(name='readable_state')
def readable_state(state: int):
    STATE = (
        (0, ''),
        (1, 'pass'),
        (2, 'reject'),
        (3, 'pending'),
        (4, 'faulty'),
        (5, 'handle'),
        (6, 'saved'),
    )
    return STATE[state][1]


@register.filter(name='readable_report_state')
def readable_report_state(state: int):
    STATE = (
        (0, 'saved'),
        (1, 'pending'),
        (2, 'processing'),
        (3, 'solved'),
    )
    return STATE[state][1]


@register.filter(name='trans_int')
def trans_int(score: float):
    return int(score)


@register.filter(name='responsible_unit')
def responsible_unit(category: ReportCategory, required_privilege: UserType):
    return (category.responsibility & required_privilege.value[0]) > 0


@register.filter(name='question_kind')
def question_kind(question_type: int):
    if question_type == QuestionType.QA.value[0]:
        return 'listening'
    elif question_type == QuestionType.ShortConversation.value[0]:
        return 'listening'
    elif question_type == QuestionType.Grammar.value[0]:
        return 'reading'
    elif question_type == QuestionType.Phrase.value[0]:
        return 'reading'
    elif question_type == QuestionType.ParagraphUnderstanding.value[0]:
        return 'reading'
    else:
        return 'unknown'


@register.filter(name='is_finished')
def is_finished(exam: Exam, user: User):
    try:
        answer_sheet = exam.answersheet_set.get(user_id=user.id)
        if answer_sheet.score is None:
            return False
        else:
            return True
    except ObjectDoesNotExist:
        return False


@register.filter(name='belongs_to')
def belongs_to(category: ReportCategory, privilege: UserType):
    return category.responsibility & privilege.value[0] > 0


@register.filter(name='summary')
def summary(completed_string: str, wanted: int):
    if len(completed_string) > wanted:
        return completed_string[:wanted] + '...'
    else:
        return completed_string


@register.filter(name='readable_question_query_content')
def readable_question_query_content(question_query_content: str):
    question_query = [_.split('=') for _ in question_query_content.split('&')]
    readable_query_content = ''

    for item in question_query:
        if 'state' in item:
            STATE = (
                (0, ''),
                (1, 'Pass'),
                (2, 'Reject'),
                (3, 'Pending'),
                (4, 'Reported'),
                (5, 'Handle'),
                (6, 'saved'),
            )
            readable_query_content += '"state="' + STATE[int(item[1])][1] + '"'

        elif 'difficulty' in item:
            readable_query_content += '+"difficulty="' + item[1] + '"'

        elif 'question_content' in item:
            readable_query_content += '+"question_content="' + item[1] + '"'

        elif 'question_type' in item:
            TYPE = (
                (0, ''),
                (1, 'Listening/QA'),
                (2, 'Listening/Conversation'),
                (3, 'Reading/Grammar'),
                (4, 'Reading/Phrase'),
                (5, 'Reading/Paragraph')
            )
            readable_query_content += '+"type="' + TYPE[int(item[1])][1] + '"'

    return readable_query_content


@register.filter(name='readable_user_query_content')
def readable_user_query_content(user_query_content: str):
    user_query = [_.split('=') for _ in user_query_content.split('&')]
    readable_user_query_content = ''

    for item in user_query:
        if 'department' in item:
            readable_user_query_content += 'department="' + item[1]

        elif 'grade' in item:
            readable_user_query_content += '+grade="' + item[1]

        elif 'squadron' in item:
            readable_user_query_content += '+squadron="' + item[1]

        elif 'name' in item:
            readable_user_query_content += '+stuID/Name="' + item[1]

    return readable_user_query_content


@register.filter(name='question_type_transfer_to_original_data')
def question_type_transfer_to_original_data(q_type: int):
    QUESTION_TYPE = (
        (0, ''),
        (1, 'QA'),
        (2, 'ShortConversation'),
        (3, 'Grammar'),
        (4, 'Phrase'),
        (5, 'ParagraphUnderstanding'),
    )
    return QUESTION_TYPE[q_type][1]


@register.filter(name='get_report_notification')
def get_report_notification(user: User):
    report_quantity = Report.objects.filter(created_by=user)
    unread = 0

    for report in report_quantity:
        if report.user_notification:
            unread += 1
        else:
            pass

    return unread


@register.filter(name='get_SystemManager_report_notification')
def get_SystemManager_report_notification(user: User):
    categories = []

    for category in ReportCategory.objects.all():
        if (category.responsibility & 32) > 0:
            categories.append(category)

    unread = 0
    for category in categories:
        for report in category.report_set.all():
            if report.staff_notification:
                unread += 1
            else:
                pass

    return unread


@register.filter(name='get_TestManager_report_notification')
def get_TestManager_report_notification(user: User):
    categories = []

    for category in ReportCategory.objects.all():
        if (category.responsibility & 16) > 0:
            categories.append(category)

    unread = 0
    for category in categories:
        for report in category.report_set.all():
            if report.staff_notification:
                unread += 1
            else:
                pass

    return unread


@register.filter(name='get_TBManager_report_notification')
def get_TBManager_report_notification(user: User):
    categories = []

    for category in ReportCategory.objects.all():
        if (category.responsibility & 8) > 0:
            categories.append(category)

    unread = 0
    for category in categories:
        for report in category.report_set.all():
            if report.staff_notification:
                unread += 1
            else:
                pass

    return unread


@register.filter(name='isAlpha')
def isAlpha(text: str):
    return all(ord(c) < 128 for c in text)


@register.filter(name='unread_count')
def unread_count(proclamations):
    return proclamations.filter(is_read=False).count()
