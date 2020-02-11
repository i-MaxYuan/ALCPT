from math import ceil

from django.db.models import Q
from django.utils import timezone
from datetime import datetime
from django.contrib.auth.hashers import make_password

from alcpt.models import User, Department, Squadron, Student
from alcpt.definitions import UserType
from alcpt.exceptions import IllegalArgumentError


# A Q objects(django.db.models.Q) is an object used to encapsulate a collection of keyword arguments.
def query_users(*, department: Department, grade: int, squadron: Squadron, name: str):
    queries = Q()
    query_content = ""

    if department:
        queries &= Q(student__department=department)
        query_content += "department="+str(department)

    if grade:
        queries &= Q(student__grade=grade)
        query_content += "&grade="+str(grade)

    if squadron:
        queries &= Q(student__squadron=squadron)
        query_content += "&squadron="+str(squadron)

    if name:
        queries &= Q(reg_id__icontains=name) | Q(name__icontains=name)
        query_content += "&name="+str(name)

    users = User.objects.filter(queries).order_by('reg_id')

    return query_content, users


# systemmanager create many users
# A Q objects(django.db.models.Q) is an object used to encapsulate a collection of keyword arguments.
def create_users(reg_ids: list, privilege: int):
    queries = Q()

    for reg_id in reg_ids:
        queries |= Q(reg_id=reg_id)

    existed_users = User.objects.filter(queries)

    if existed_users:
        raise IllegalArgumentError("Existed user: {}".format(', '.join([user.reg_id for user in existed_users])))

    # bulk_create an object manager method which takes as input an array of objects created using the class constructor
    User.objects.bulk_create([User(reg_id=reg_id,
                                   privilege=privilege,
                                   password=make_password(reg_id)) for reg_id in reg_ids])

    return User.objects.filter(queries)
