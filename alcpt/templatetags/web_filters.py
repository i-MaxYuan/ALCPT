from django import template

from alcpt.definitions import UserType, QuestionType
from alcpt.models import User, Student, Question
from alcpt.utility import set_query_parameter
from alcpt.exceptions import IllegalArgumentError, ObjectNotFoundError

register = template.Library()


@register.filter(name='has_perm')
def has_perm(user: User, required_priviledge: UserType):
    return user.has_perm(UserType[required_priviledge])


@register.filter(name='has_perms')
def has_perms(user: User, required_priviledge: UserType):
    return user.has_perm(required_priviledge)


@register.filter(name='readable_question_type')
def readable_question_type(question_type: int):
    for q in QuestionType.__members__.values():
        if question_type is q.value[0]:
            return q.value[1]
    else:
        raise IllegalArgumentError(message='Unknown question type {}.'.format(question_type))


@register.filter(name='readable_priviledge')
def readable_user_type(priviledge):
    if type(priviledge) is str:
        for u_type in UserType.__members__.values():
            if u_type.name == priviledge:
                return u_type.value[1]
    elif type(priviledge) is int:
        for u_type in UserType.__members__.values():
            if u_type is UserType.Admin:
                if priviledge is UserType.SystemManager.value[0]:
                    return UserType.SystemManager.value[1]
            elif (priviledge & u_type.value[0]) > 0:
                return u_type.value[1]
        else:
            raise IllegalArgumentError(message='Unknown user type {}.'.format(priviledge))
    else:
        raise IllegalArgumentError(message='Unknown user type argument which type is {}'.format(type(priviledge)))


@register.filter(name='replace_page')
def replace_page(full_path: str, page: int):
    return set_query_parameter(full_path, 'page', page)


@register.filter(name='range_to')
def range_to(from_val: int, to_val: int):
    return range(from_val, to_val + 1)


@register.filter(name='lookup')
def range_to(arr: list, i: int):
    return arr[i]


@register.filter(name='is_student')
def is_student(user: User):
    try:
        student = Student.objects.get(user=user)
        return student

    except Exception:
        return False


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