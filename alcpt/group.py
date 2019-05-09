import json

from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist, MultipleObjectsReturned
from django.views.decorators.http import require_http_methods

from .models import TestPaper, Group, Department, Squadron, Student
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType
from .managerfuncs import exammanager


@permission_check(UserType.ExamManager)
@require_http_methods(["GET"])
def group_index(request):
    try:
        page = int(request.GET.get('page', 0))

    except ValueError:
        page = 0

    keywords = {
        'name': request.GET.get('name', ''),
    }

    num_pages, groups = exammanager.query_groups(**keywords, page=page)

    data = {
        'groups': groups,
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'exam/group_list.html', data)


@permission_check(UserType.ExamManager)
@require_http_methods(["GET", "POST"])
def create_group(request):
    if request.method == 'POST':
        name = request.POST.get('name')

        try:
            members = request.POST.get('members')

        except ValueError:
            raise ArgumentError('No any members in group')

        try:
            if Group.objects.get(name=name):
                raise MultipleObjectsReturned('Group has existed.')

        except ObjectDoesNotExist:
            pass

        group = exammanager.create_group(name=name,
                                         members=members)

        return redirect('/exam/{}/group_edit'.format(group.id))

    else:
        data = {
            'students': Student.objects.all(),
            'departments': Department.objects.all(),
            'squadrons': Squadron.objects.all(),
        }
        return render(request, 'exam/group_create.html', data)


@permission_check(UserType.ExamManager)
@require_http_methods(["GET", "POST"])
def edit_group(request, group_id: int):
    try:
        group = Group.objects.get(id=group_id)

    except ObjectDoesNotExist:
        raise ObjectNotFoundError('Cannot find group id={}'.format(group_id))

    if request.method == 'POST':
        name = request.POST.get('name')

        try:
            members = request.POST.get('members')

        except ValueError:
            raise ArgumentError('Missing members')

        group = exammanager.edit_group(group=group,
                                       name=name,
                                       members=members)

        messages.success(request, "Successfully update group :{}.".format(group.name))

        return redirect('/exam')

    else:
        return render(request, 'exam/group_edit.html', locals())


@permission_check(UserType.ExamManager)
@require_http_methods(["GET"])
def delete_group(request, group_id):
    try:
        group = TestPaper.objects.get(id=group_id)

    except ObjectDoesNotExist:
        raise ResourceNotFoundError('Cannot find group id = {}.'.format(group_id))

    group.delete()

    messages.success(request, 'Delete group name={}.'.format(group.name))

    return redirect(request.META.get('HTTP_REFERER', '/group'))