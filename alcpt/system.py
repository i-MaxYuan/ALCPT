import re
import xlrd
import os
import json
import datetime

from string import punctuation

from django.core import serializers
from django.shortcuts import render, redirect
from django.views.decorators.http import require_http_methods

from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.core.exceptions import ObjectDoesNotExist
from django.db import IntegrityError
from django.contrib import messages

from alcpt.managerfuncs import systemmanager
from alcpt.models import User, Student, Department, Squadron, ReportCategory, Report, Reply
from alcpt.proclamation import notify
from alcpt.definitions import UserType, Identity
from alcpt.decorators import permission_check, login_required
from alcpt.exceptions import IllegalArgumentError


# 使用者列表
@permission_check(UserType.SystemManager)
def user_list(request):
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

    query_content, users = systemmanager.query_users(**keywords)
    departments = Department.objects.all()
    squadrons = Squadron.objects.all()
    privileges = UserType.__members__

    page = request.GET.get('page', 1)
    paginator = Paginator(users, 8)  # the second parameter is used to display how many items. Now is display 10

    try:
        userList = paginator.page(page)
    except PageNotAnInteger:
        userList = paginator.page(1)
    except EmptyPage:
        userList = paginator.page(paginator.num_pages)

    return render(request, 'user/index.html', locals())


# 新增使用者（單一）
@permission_check(UserType.SystemManager)
def user_create(request):
    if request.method == 'POST':
        reg_id = request.POST.get('reg_id',)

        privilege_value = 0
        for privilege in UserType.__members__.values():
            if privilege and request.POST.get('{}'.format(privilege)):
                privilege_value |= privilege.value[0]

        try:
            identity = int(request.POST.get('identity'))
            if identity == 2:
                if request.POST.get('stu_id'):
                    new_user = User.objects.create_user(reg_id=reg_id, privilege=privilege_value, password=reg_id)
                    new_user.identity = identity

                    new_user_stu = Student.objects.create(stu_id=request.POST.get('stu_id'), user=new_user)
                    if request.POST.get('department'):
                        new_user_stu.department = Department.objects.get(id=int(request.POST.get('department')))
                    if request.POST.get('squadron'):
                        new_user_stu.squadron = Squadron.objects.get(id=int(request.POST.get('squadron')))
                    if request.POST.get('grade'):
                        new_user_stu.grade = request.POST.get('grade')

                    new_user.save()
                    new_user_stu.save()
                    messages.success(request, 'Successfully Created - User, Student')
                    return redirect('user_list')

                else:
                    messages.warning(request, 'Please input the student ID.')
                    privileges = UserType.__members__
                    identities = Identity.__members__.values()
                    departments = Department.objects.all()
                    squadrons = Squadron.objects.all()
                    return render(request, 'user/create_user.html', locals())

            else:
                new_user = User.objects.create_user(reg_id=reg_id, privilege=privilege_value, password=reg_id)
                new_user.identity = identity
                new_user.save()
                messages.success(request, 'Successfully Created - User')

                if request.POST.get('stu_id'):
                    messages.warning(request, 'You are not student.')

                return redirect('user_list')

        except IntegrityError:
            messages.error(request, "Existed user, register ID - {}".format(reg_id))
            privileges = UserType.__members__
            identities = Identity.__members__.values()
            departments = Department.objects.all()
            squadrons = Squadron.objects.all()
            return render(request, 'user/create_user.html', locals())

    else:
        privileges = UserType.__members__.values()
        identities = Identity.__members__.values()
        departments = Department.objects.all()
        squadrons = Squadron.objects.all()
        return render(request, 'user/create_user.html', locals())


# 新增使用者（多重）
@permission_check(UserType.SystemManager)
def user_multiCreate(request):
    if request.method == 'POST':
        if request.FILES.get('users_file',):
            wb = xlrd.open_workbook(filename=None, file_contents=request.FILES['users_file'].read())
            table = wb.sheets()[0]
            new_users = []

            for i in range(table.nrows):
                row = table.row_values(i)
                if row[0]:  # account
                    if isinstance(row[0], float):
                        row[0] = int(row[0])
                    if isinstance(row[0], str):
                        if re.findall("[#*'”;/\\\ ,|+=-]", row[0]):
                            continue
                    if not isinstance(row[2], float) or row[2] == '':   # identity
                        row[2] = 1
                    if isinstance(row[2], float):
                        row[2] = int(row[2])
                        if row[2] < 1 or row[2] > 3:
                            row[2] = 1
                    new_users.append(row)   # valid user

        else:
            messages.warning(request, 'Must enter textarea or load a file.')
            return redirect('user_multiCreate')

        privilege_value = 0
        if request.user.has_perm(UserType.SystemManager):
            i = 0
            for privilege in UserType.__members__.values():
                if privilege and request.POST.get('privilege_{}'.format(i)):
                    privilege_value |= privilege.value[0]
                i += 1

        else:
            privilege_value = UserType.Testee.value[0]

        for user in new_users:
            new_user = User.objects.create_user(reg_id=user[0], privilege=privilege_value, password=user[0])
            new_user.name = user[1]
            new_user.identity = user[2]
            new_user.save()

        messages.success(request, 'Successfully Created users - {}'.format(len(new_users)))

        return redirect('user_list')

    else:
        privileges = UserType.__members__

        return render(request, 'user/multi_create_user.html', locals())


# 更改使用者
@permission_check(UserType.SystemManager)
def user_edit(request, reg_id):
    privileges = UserType.__members__.values()
    identities = Identity.__members__.values()

    if request.method == 'POST':
        privilege_value = 0
        for privilege in privileges:
            if privilege and request.POST.get('{}'.format(privilege)):
                privilege_value |= privilege.value[0]

        try:
            edited_user = User.objects.get(reg_id=reg_id)

            edited_user.name = request.POST.get('name')
            edited_user.email = request.POST.get('email')
            edited_user.gender = int(request.POST.get('gender'))
            edited_user.privilege = privilege_value

            if int(request.POST.get('identity')) == 2:
                edited_user.identity = request.POST.get('identity')
                edited_user.save()
                try:
                    edited_student = edited_user.student
                    edited_student.grade = request.POST.get('grade')
                    if request.POST.get('department'):
                        edited_student.department = Department.objects.get(id=request.POST.get('department'))
                    if request.POST.get('squadron'):
                        edited_student.squadron = Squadron.objects.get(id=request.POST.get('squadron'))
                    edited_student.save()
                    try:
                        edited_user.reg_id = request.POST.get('reg_id')
                        edited_student.stu_id = request.POST.get('stu_id')
                        edited_user.save()
                        edited_student.save()

                        messages.success(request, "Successfully updated user.")
                        return redirect('user_list')

                    except IntegrityError:
                        messages.warning(request, "This ID had been used.")
                        departments = Department.objects.all()
                        squadrons = Squadron.objects.all()
                        return render(request, 'user/edit_user.html', locals())

                except ObjectDoesNotExist:
                    Student.objects.create(stu_id=edited_user.reg_id, user=edited_user).save()
                    messages.warning(request, "Please update Student information.")
                    return redirect('user_list')

            else:
                try:
                    edited_user.reg_id = request.POST.get('reg_id')
                    edited_user.identity = request.POST.get('identity')
                    edited_user.save()

                    if edited_user.student:
                        Student.objects.get(user=edited_user).delete()

                    messages.success(request, "Successfully updated user.")
                    return redirect('user_list')

                except IntegrityError:
                    messages.warning(request, "This register ID had been used.")
                    try:
                        edited_user.student
                        departments = Department.objects.all()
                        squadrons = Squadron.objects.all()
                    except ObjectDoesNotExist:
                        pass

                    return render(request, 'user/edit_user.html', locals())

        except ObjectDoesNotExist:
            messages.error(request, "User doesn't exist, user register id - {}".format(reg_id))
            return redirect('user_list')
    else:
        try:
            edited_user = User.objects.get(reg_id=reg_id)
            try:
                edited_user.student
                departments = Department.objects.all()
                squadrons = Squadron.objects.all()
            except ObjectDoesNotExist:
                pass

            reg_ids = [_.reg_id for _ in User.objects.all().exclude(reg_id=reg_id)]
            stu_ids = [_.stu_id for _ in Student.objects.all().exclude(stu_id=edited_user.reg_id)]
            return render(request, 'user/edit_user.html', locals())

        except ObjectDoesNotExist:
            messages.error(request, "User doesn't exist, user register id - {}".format(reg_id))
            return redirect('user_list')


# 單位列表
@permission_check(UserType.SystemManager)
@require_http_methods(["GET"])
def unit(request):
    departments = Department.objects.all()
    squadrons = Squadron.objects.all()
    return render(request, 'user/unit_list.html', locals())


# 新增單位（學系、中隊）
@permission_check(UserType.SystemManager)
@require_http_methods(["GET", "POST"])
def create_unit(request):
    name = request.POST.get('unit_name')

    if request.method == 'POST':
        try:
            if request.POST.get('unit') == 'department':
                Department.objects.create(name=name)

            elif request.POST.get('unit') == 'squadron':
                Squadron.objects.create(name=name)

            else:
                messages.error(request, 'Choose the unit which you want to create.')
                return redirect('unit_create')
        except IntegrityError:
            messages.error(request, "This name had been used.")
            return redirect('unit_create')

        messages.success(request, 'Success insert new unit: {}.'.format(name))

        return redirect('unit_list')

    else:
        return render(request, 'user/create_unit.html', locals())


@permission_check(UserType.SystemManager)
def unit_edit(request, unit_kind, unit_name):
    if request.method == "POST":
        if unit_kind == 'squadron':
            edited_unit = Squadron.objects.get(name=unit_name)
            edited_unit.name = request.POST.get('name')
            edited_unit.save()

        elif unit_kind == 'department':
            edited_unit = Department.objects.get(name=unit_name)
            edited_unit.name = request.POST.get('name')
            edited_unit.save()

        messages.success(request, "Update successfully.")
        return redirect('unit_list')

    else:
        if unit_kind == 'squadron':
            edited_unit = Squadron.objects.get(name=unit_name)

        elif unit_kind == 'department':
            edited_unit = Department.objects.get(name=unit_name)

        else:
            messages.warning(request, "Unknown unit name.")
            return redirect('unit_list')

        return render(request, 'user/unit_edit.html', locals())


# 顯示單位人員
@permission_check(UserType.SystemManager)
def unit_member_list(request, unit_kind, unit_name):
    if unit_kind == 'squadron':
        try:
            viewed_unit = Squadron.objects.get(name=unit_name)
            unit_members = viewed_unit.student_set.all().order_by('stu_id')
            return render(request, 'user/unit_member_list.html', locals())
        except ObjectDoesNotExist:
            messages.error(request, "Squadron doesn't exist, squadron name: {}".format(unit_name))
    elif unit_kind == 'department':
        try:
            viewed_unit = Department.objects.get(name=unit_name)
            unit_members = viewed_unit.student_set.all().order_by('stu_id')
            return render(request, 'user/unit_member_list.html', locals())
        except ObjectDoesNotExist:
            messages.error(request, "Department doesn't exist, department name: {}".format(unit_name))
    else:
        messages.warning(request, "Unit kind doesn't exist, unit kind: {}".format(unit_kind))

    return redirect('unit_list')


# 回報類別列表
@permission_check(UserType.SystemManager)
def report_category_list(request):
    report_categories = ReportCategory.objects.all()
    privileges = UserType.__members__
    return render(request, 'report/report_category_list.html', locals())


# 新增回報類別
@permission_check(UserType.SystemManager)
def report_category_create(request):
    privileges = UserType.__members__.values()
    if request.method == 'POST':
        category_name = request.POST.get('category_name',)

        responsibility_value = 0
        for privilege in privileges:
            if privilege and request.POST.get('{}'.format(privilege)):
                responsibility_value |= privilege.value[0]

        try:
            new_category = ReportCategory.objects.create(name=category_name,
                                                         responsibility=responsibility_value)
            new_category.save()
        except IntegrityError:
            messages.error(request, "Existed category name - {}".format(category_name))
            return redirect('report_category_list')

        messages.success(request, 'Successfully created report category - {}.'.format(new_category))

        return redirect('report_category_list')
    else:
        categories_names = [_.name for _ in ReportCategory.objects.all()]
        return render(request, 'report/report_category_create.html', locals())


# 回報類別內容
@permission_check(UserType.SystemManager)
def report_category_detail(request, category_id):
    try:
        category = ReportCategory.objects.get(id=category_id)
        return render(request, 'report/report_category_detail.html', locals())
    except ObjectDoesNotExist:
        messages.error(request, 'Report Category does not exist, report category id: {}'.format(category_id))
        return redirect('report_category_list')


# 更改回報類別
@permission_check(UserType.SystemManager)
def report_category_edit(request, category_id):
    privileges = UserType.__members__.values()
    try:
        category = ReportCategory.objects.get(id=category_id)
    except ObjectDoesNotExist:
        messages.error(request, 'Report Category does not exist, report category id: {}'.format(category_id))
        return redirect('report_category_list')

    if request.method == 'POST':
        category_name = request.POST.get('category_name')

        responsibility_value = 0
        for privilege in privileges:
            if privilege and request.POST.get('{}'.format(privilege)):
                responsibility_value |= privilege.value[0]

        try:
            category.name = category_name
            category.responsibility = responsibility_value
            category.save()
            messages.success(request, 'Update successfully.')
            return redirect('report_category_list')
        except IntegrityError:
            messages.error(request, "Existed category name: {}".format(category_name))
            return redirect('report_category_edit', category_id=category.id)
    else:
        categories_names = [_.name for _ in ReportCategory.objects.all().exclude(id=category_id)]
        return render(request, 'report/report_category_edit.html', locals())


# 負責單位的回報列表
@login_required
def responsible_report_list(request, responsibility):
    SM, TM, TBM = [], [], []
    reports = []
    for category in ReportCategory.objects.all():
        if category.responsibility & UserType.SystemManager.value[0] > 0:
            SM.append(category)
        if category.responsibility & UserType.TestManager.value[0] > 0:
            TM.append(category)
        if category.responsibility & UserType.TBManager.value[0] > 0:
            TBM.append(category)

    if request.user.has_perm(UserType.SystemManager) and responsibility == 'SystemManager':
        for category in SM:
            reports.extend(category.report_set.all().order_by('-created_time'))
    elif request.user.has_perm(UserType.TestManager) and responsibility == 'TestManager':
        for category in TM:
            reports.extend(category.report_set.all().order_by('-created_time'))
    elif request.user.has_perm(UserType.TBManager) and responsibility == 'TBManager':
        for category in TBM:
            reports.extend(category.report_set.all().order_by('-created_time'))
    else:
        messages.success(request, 'Has no permission.')

    return render(request, 'report/responsible_report_list.html', locals())


# 回報
@login_required
def report(request):
    if request.method == 'POST':
        try:
            category = ReportCategory.objects.get(id=int(request.POST.get('category',)))

        except ObjectDoesNotExist:
            messages.error(request, 'Category does not exist, category name: {}'.format(category))
            categories = ReportCategory.objects.all()
            return render(request, 'report/report.html', locals())

        supplement_note = request.POST.get('supplement_note')

        user_report = Report.objects.create(category=category,
                                            supplement_note=supplement_note,
                                            staff_notification=True,
                                            created_by=request.user,
                                            state=1)

        user_report.save()

        messages.success(request, 'Thanks for your advise, we will help you to solve your problem as soon as possible.')

        return redirect('report_list')
    else:
        categories = ReportCategory.objects.all()
        return render(request, 'report/report.html', locals())


# 負責單位對回報的回應
@login_required
def report_reply(request, report_id):
    if request.user.has_perm(UserType.SystemManager):
        permission = 'SystemManager'
        pass
    elif request.user.has_perm(UserType.TestManager):
        permission = 'TestManager'
        pass
    elif request.user.has_perm(UserType.TBManager):
        permission = 'TBManager'
        pass
    else:
        messages.warning(request, 'Permission Denied.')
        return redirect('Homepage')

    try:
        replying_report = Report.objects.get(id=report_id)

        if replying_report.category.responsibility & request.user.privilege == 0:
            messages.warning(request, 'This report not belongs to your permission.')
            return redirect('responsible_report_list', responsibility=permission)
        elif replying_report.state == 1:
            replying_report.state = 2
            replying_report.save()
    except ObjectDoesNotExist:
        messages.error(request, "Report doesn't exist, report id: {}".format(report_id))
        return redirect('responsible_report_list', responsibility=permission)

    if request.method == 'POST':
        if replying_report.state == 3:
            messages.warning(request, 'This report had been resolved.')
            return redirect('responsible_report_list', responsibility=permission)

        reply = request.POST.get('reply')
        new_reply = Reply.objects.create(source=replying_report, content=reply, created_by=request.user)

        proclamation_content = "The administrator has responded the problem you encountered.\n" \
                               "Please refer to the notification center for more details."
        notify(title='Reply',
               text=proclamation_content,
               is_read=False,
               is_public=False,
               announcer=request.user,
               users=[replying_report.created_by])

        replying_report.user_notification = True
        replying_report.save()
        return redirect('responsible_report_list', responsibility=permission)
    else:
        Report.objects.filter(id=report_id).update(staff_notification=False)

        replies = replying_report.reply_set.all().order_by('created_time')
        return render(request, 'report/reply.html', locals())


@permission_check(UserType.SystemManager)
def view_report_detail(request, report_id):
    try:
        viewed_report = Report.objects.get(id=report_id)
        if viewed_report.created_by == request.user:
            pass
        elif request.user.has_perm(UserType.SystemManager):
            pass
        else:
            messages.warning(request, 'You have no permission')
            return redirect('Homepage')
    except ObjectDoesNotExist:
        messages.error(request, "Report doesn't exist, report id: {}".format(report_id))
        return redirect('report_list')

    replies = viewed_report.reply_set.all().order_by('created_time')
    return render(request, 'report/report_detail.html', locals())


@login_required
def report_done(request, report_id):
    if request.user.has_perm(UserType.SystemManager):
        permission = 'SystemManager'
        pass
    elif request.user.has_perm(UserType.TestManager):
        permission = 'TestManager'
        pass
    elif request.user.has_perm(UserType.TBManager):
        permission = 'TBManager'
        pass
    else:
        messages.warning(request, 'Permission Denied.')
        return redirect('Homepage')

    try:
        replying_report = Report.objects.get(id=report_id)

        if replying_report.category.responsibility & request.user.privilege == 0:
            messages.warning(request, 'This report not belongs to your permission.')
            return redirect('responsible_report_list', responsibility=permission)

        elif replying_report.state == 3:
            messages.warning(request, 'This report had been resolved.')
            return redirect('responsible_report_list', responsibility=permission)

        elif replying_report.state == 2:
            replying_report.resolved_by = request.user
            replying_report.state = 3
            replying_report.user_notification = True
            replying_report.staff_notification = False
            replying_report.save()
            messages.success(request, 'This report has resolved.')
    except ObjectDoesNotExist:
        messages.error(request, "Report doesn't exist, report id: {}".format(report_id))

    return redirect('responsible_report_list', responsibility=permission)


# 系統管理員檢視使用者個人基本資料
@permission_check(UserType.SystemManager)
def view_profile(request, reg_id):
    try:
        viewed_user = User.objects.get(reg_id=reg_id)
        privileges = UserType.__members__
        return render(request, 'user/view_profile.html', locals())
    except ObjectDoesNotExist:
        messages.error(request, "User doesn't exist, user id: {}".format(reg_id))
        return redirect('unit_list')
