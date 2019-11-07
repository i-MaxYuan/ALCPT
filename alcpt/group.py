import json
from string import punctuation

from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist, MultipleObjectsReturned
from django.views.decorators.http import require_http_methods

from .models import TestPaper, Group, Department, Squadron, Student
from .exceptions import *
from .decorators import permission_check
from .definitions import UserType
from .managerfuncs import exammanager


@permission_check(UserType.TestManager)
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


@permission_check(UserType.TestManager)
@require_http_methods(["GET", "POST"])
def create_group(request):
    try:
        page = int(request.GET.get('page', 0))
    except ValueError:
        page = 0

    if request.method == 'POST':
        print(request.POST.get('name'))
        name = request.POST.get('name')

        try:
            members = request.POST.getlist('student_id')

        except ValueError:
            raise ArgumentError('No any members in group')

        try:
            if Group.objects.get(name=name):
                raise MultipleObjectsReturned('Group has existed.')

        except ObjectDoesNotExist:
            pass

        group = exammanager.create_group(name=name,
                                         members=members,
                                         created_by=request.user)

        return redirect('/exam/group'.format(group.name))

    else:
        keywords = {
            'name': request.GET.get('name')
        }

        if keywords['name'] and any(char in punctuation for char in keywords['name']):
            keywords['name'] = None
            messages.warning(request, "Name cannot contains any special character.")

        for keyword in ['department', 'grade', 'squadron']:
            try:
                keywords[keyword] = int(request.GET.get(keyword))
            except (KeyError, TypeError, ValueError):
                keywords[keyword] = None

        if keywords['department']:
            try:
                keywords['department'] = Department.objects.get(id=keywords['department'])
            except ObjectDoesNotExist:
                keywords['department'] = None

        if keywords['squadron']:
            try:
                keywords['squadron'] = Squadron.objects.get(id=keywords['squadron'])
            except ObjectDoesNotExist:
                keywords['squadron'] = None

        num_pages, students = exammanager.query_students(**keywords, page=page)

        data = {
            'students': students,
            'keywords': keywords,
            'page_range': range(num_pages),
            'page': page,
            'departments': Department.objects.all(),
            'squadrons': Squadron.objects.all(),
        }
        return render(request, 'exam/group_create.html', data)


@permission_check(UserType.TestManager)
@require_http_methods(["GET", "POST"])
def edit_group(request, group_name: str):
    try:
        group = Group.objects.get(name=group_name)

    except ObjectDoesNotExist:
        raise ObjectNotFoundError('Cannot find group id={}'.format(group_name))

    try:
        page = int(request.GET.get('page', 0))
    except ValueError:
        page = 0

    if request.method == 'POST':
        name = request.POST.get('name')

        try:
            members = request.POST.getlist('student_id')

        except ValueError:
            raise ArgumentError('Missing members')

        print(members)

        group = exammanager.edit_group(group=group,
                                       name=name,
                                       members=members)

        messages.success(request, "Successfully update group :{}.".format(group.name))

        return redirect('/exam/group')

    else:
        keywords = {
            'name': request.GET.get('name')
        }

        if keywords['name'] and any(char in punctuation for char in keywords['name']):
            keywords['name'] = None
            messages.warning(request, "Name cannot contains any special character.")

        for keyword in ['department', 'grade', 'squadron']:
            try:
                keywords[keyword] = int(request.GET.get(keyword))
            except (KeyError, TypeError, ValueError):
                keywords[keyword] = None

        if keywords['department']:
            try:
                keywords['department'] = Department.objects.get(id=keywords['department'])
            except ObjectDoesNotExist:
                keywords['department'] = None

        if keywords['squadron']:
            try:
                keywords['squadron'] = Squadron.objects.get(id=keywords['squadron'])
            except ObjectDoesNotExist:
                keywords['squadron'] = None

        num_pages, students = exammanager.query_students(**keywords, page=page)

        data = {
            'group': group,
            'students': students,
            'keywords': keywords,
            'page_range': range(num_pages),
            'page': page,
            'departments': Department.objects.all(),
            'squadrons': Squadron.objects.all(),
        }
        return render(request, 'exam/group_edit.html', data)


@permission_check(UserType.TestManager)
@require_http_methods(["GET"])
def delete_group(request, group_name: str):
    try:
        group = Group.objects.get(name=group_name)

    except ObjectDoesNotExist:
        raise ResourceNotFoundError('Cannot find group name = {}.'.format(group_name))

    group.delete()

    messages.success(request, 'Delete group name={}.'.format(group.name))

    return redirect(request.META.get('HTTP_REFERER', '/group'))


@permission_check(UserType.TestManager)
@require_http_methods(["GET"])
def member_list(request, group_name: str):
    try:
        group = Group.objects.get(name=group_name)

    except ObjectDoesNotExist:
        raise ResourceNotFoundError('Cannot find group name = {}.'.format(group_name))

    members = group.member.all()

    return render(request, 'exam/group_member_list.html', locals())