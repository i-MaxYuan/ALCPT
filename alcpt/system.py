import re
from string import punctuation

from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from django.views.decorators.http import require_http_methods
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import make_password

from .models import *
from .exceptions import *
from .decorators import permission_check
from .managerfuncs import systemmanager


# 系統管理員首頁
@permission_check(UserType.SystemManager)
@require_http_methods(["GET"])
def index(request):
    try:
        page = int(request.GET.get('page', 0))
    except ValueError:
        page = 0

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

    num_pages, users = systemmanager.query_users(**keywords, page=page)

    data = {
        'users': users,
        'departments': Department.objects.all(),
        'squadrons': Squadron.objects.all(),
        'user_types': UserType.__members__,
        'num_types': range(1, len(UserType.__members__) + 1),
        'keywords': keywords,
        'page': page,
        'page_range': range(num_pages),
    }

    return render(request, 'user/list.html', data)


# 系統管理員新增使用者頁面
@permission_check(UserType.SystemManager)
@require_http_methods(["GET", "POST"])
def create_user(request):
    if request.method == 'POST':
        new_accounts = []
        for account in request.POST.get('accounts').split(','):
            account = account.strip().lower()
            if not re.match('[a-z0-9]+', account):
                raise IllegalArgumentError('Account can only contain letters and numbers.')

            new_accounts.append(account)

        user_type_value = 0
        if request.user.has_perm(UserType.SystemManager):
            i = 0
            for user_type in UserType.__members__.values():
                if user_type and request.POST.get('user_type_{}'.format(i)):
                    user_type_value |= user_type.value[0]

                i += 1

        else:
            user_type_value = UserType.Tester.value[0]

        new_users = systemmanager.create_users(serial_numbers=new_accounts,
                                               user_type=user_type_value,)

        if user_type_value & UserType.Tester.value[0]:
            Student.objects.bulk_create([Student(user=new_user) for new_user in new_users])

        messages.success(request, 'Create user "{}" successful.'.format(len(new_users)))

        return redirect('/user')

    else:
        data = {'user_types': UserType.__members__}

        return render(request, 'user/create.html', data)


# 系統管理員＆使用者修改使用者資料頁面
@login_required
@require_http_methods(["GET", "POST"])
def edit_user(request, serial_number: str):
    if request.user.serial_number != serial_number:
        if request.user.has_perm(UserType.SystemManager):
            try:
                edited_user = User.objects.get(serial_number=serial_number)

            except ObjectDoesNotExist:
                raise ObjectNotFoundError('Can\'t find user whose serial number:{}'.format(serial_number))

        else:
            raise PermissionWrongError()

    else:
        edited_user = request.user

    try:
        student = Student.objects.get(user=request.user)

    except ObjectDoesNotExist:
        student = None

    if request.method == 'POST':
        data = {
            'name': request.POST.get('name'),
            'user_type': None,
        }

        if any(char in punctuation for char in data['name']):
            raise IllegalArgumentError('Name can\'t have special character.')

        for field_value in ['department', 'grade', 'squadron', 'gender']:
            try:
                data[field_value] = request.POST.get(field_value)

            except (KeyError, TypeError):
                raise ArgumentError('Missing "{}".'.format(field_value))

            except KeyError:
                raise IllegalArgumentError('"{}" can\'t blank.'.format(field_value))

        try:
            data['department'] = Department.objects.get(id=data['department'])
        except ObjectDoesNotExist:
            pass
            # 非學生的使用者因為沒科系跟中隊能選所以用pass不然會一直出錯
            # raise ResourceNotFoundError("Cannot find department id={}".format(data['department']))

        try:
            data['squadron'] = Squadron.objects.get(id=data['squadron'])
        except ObjectDoesNotExist:
            pass
            # raise ResourceNotFoundError("Cannot find squadron id={}".format(data['squadron']))

        if request.user.has_perm(UserType.SystemManager):
            data['user_type'] = 0
            i = 0
            for user_type in UserType.__members__.values():
                if user_type is not UserType.SystemManager and request.POST.get('user_type_{}'.format(i)):
                    data['user_type'] |= user_type.value[0]

                i += 1

        new_password = request.POST.get('password')
        if new_password:
            if new_password != request.POST.get('check-password'):
                raise IllegalArgumentError('Password not equal.')

            elif not re.match('^[a-z0-9]{32}$', new_password):
                raise IllegalArgumentError('Password context is illegal.')

            systemmanager.update_password(edited_user, new_password)

        systemmanager.updata_user(edited_user, **data)

        messages.success(request, 'Updated user: {}'.format(edited_user.serial_number))

        if request.user.serial_number is edited_user.serial_number:
            return redirect('/user/{}'.format(serial_number))

        else:
            return redirect('/user')

    else:
        if request.GET.get('reset-password'):
            if not request.user.has_perm(UserType.SystemManager):
                raise PermissionWrongError()

            systemmanager.update_password(user=edited_user)

            messages.success(request, 'Reset password to serial number successfully.')

            return redirect('/user')

        data = {
            'user': edited_user,
            'student': student,
            'departments': Department.objects.all(),
            'squadrons': Squadron.objects.all(),
            'user_types': UserType.__members__,
            'num_types': range(1, len(UserType.__members__) + 1),
            # 'password_pattern': '^(?!.*[^\x21-\x7e])[A-Za-z\d]{6,32}$',
            'password_pattern': '^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
        }

        return render(request, 'user/edit.html', data)