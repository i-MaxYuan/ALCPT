from math import ceil

from django.db.models import Q
from django.utils import timezone
from django.contrib.auth.hashers import make_password

from alcpt.models import User, Department, Squadron, Student
from alcpt.definitions import UserType
from alcpt.exceptions import IllegalArgumentError


def query_users(*, department: Department, grade: int, squadron: Squadron, name: str, page: int=None, filter_func=None):
    queries = Q()

    if department:
        queries &= Q(student__department=department)

    if grade is not None:
        queries &= Q(student__grade=grade)

    if squadron:
        queries &= Q(student__squadron=squadron)

    if name is not None:
        queries &= Q(reg_id__icontains=name) | Q(name__icontains=name)

    users = User.objects.filter(queries)
    users = users.order_by('-created_time')

    for user in users:
        user.update_time = timezone.localtime(user.update_time)
        user.created_time = timezone.localtime(user.created_time)

    if filter_func:
        users = list(filter(filter_func, users))

    num_pages = ceil(len(users) / 10)

    if page and page >= 0:
        users = users[page * 10: page * 10 + 10]

    elif page == 0:
        users = users[0: 10]

    return num_pages, users


def updata_user(user: User, name: str, department: Department, grade: int, squadron: Squadron, priviledge: int, gender: int):
    user.name = name
    user.gender = gender
    if user.priviledge & UserType.Testee.value[0]:
        student = Student.objects.get(user=user.id)
        student.department = department
        student.grade = grade
        student.squadron = squadron
        student.save()

    if priviledge:
        user.priviledge = priviledge

    user.save()


def update_password(user: User, password: str=None):
    if password:
        user.set_password(password)

    else:
        user.set_password(user.reg_id)

    user.save()


def create_users(reg_ids: list, priviledge: int):
    queries = Q()

    for reg_id in reg_ids:
        queries |= Q(reg_id=reg_id)

    existed_users = User.objects.filter(queries)

    if existed_users:
        raise IllegalArgumentError("Existed user: {}".format(', '.join([user.reg_id for user in existed_users])))

    User.objects.bulk_create([User(reg_id=reg_id,
                                   priviledge=priviledge,
                                   password=make_password(reg_id)) for reg_id in reg_ids])

    return User.objects.filter(queries)
