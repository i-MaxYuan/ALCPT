import re

from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.core.exceptions import ObjectDoesNotExist
from Online_Exam.settings import LOGIN_REDIRECT_URL, LOGIN_URL
from django.contrib import auth
from django.views.decorators.http import require_http_methods

from .decorators import permission_check
from .definitions import UserType
from .exceptions import IllegalArgumentError, ResourceNotFoundError
from .models import Proclamation

PATTERNS = {
    "reg_id": "[a-zA-Z0-9\._-]+",
    "password": "[a-zA-Z0-9\.!@#\$%\^&\*]+"
}


# 登入
def login(request):
    if request.method == 'POST':
        reg_id = request.POST.get('reg_id', '')
        password = request.POST.get('password', '')
        next_page = request.GET.get('next', LOGIN_REDIRECT_URL)

        try:
            for field in ['reg_id', 'password']:
                if not re.match(PATTERNS[field], eval(field)):
                    raise IllegalArgumentError()

            user = auth.authenticate(reg_id=reg_id, password=password)

            if user is None or not user.is_active:
                raise IllegalArgumentError('')
            print()
            auth.login(request, user)

        except Exception:
            return redirect('/')

        return redirect(next_page)

    else:
        if request.user.is_authenticated():
            return redirect('/')

        else:
            return render(request, 'login.html')


# 登出
def logout(request):
    auth.logout(request)

    return redirect(LOGIN_URL)


@login_required
def index(request):
    data = {
        "priviledges": UserType.__members__,
        "proclamations": Proclamation.objects.filter(is_public=True)
    }
    return render(request, 'index.html', data)


@login_required
def proclamation_detail(request, proclamation_id):
    try:
        proclamation = Proclamation.objects.get(id=proclamation_id)

    except ObjectDoesNotExist:
        raise ResourceNotFoundError('Cannot find proclamation id = {}.'.format(proclamation_id))

    return render(request, 'proclamation_details.html', {'proclamation': proclamation})


@login_required
@require_http_methods(["GET"])
def pie(request):
    from .models import AnswerSheet
    answer_sheets_all = AnswerSheet.objects.all()

    answer_sheets = []
    for sheet in answer_sheets_all:
        if sheet.user.id == request.user.id:
            answer_sheets.append(sheet)

    over60 = 0
    under60 = 0
    for sheet in answer_sheets:
        if sheet.score >= 60:
            over60 += 1
        else:
            under60 += 1

    return render(request, 'testee/pie_for_tester.html', {'pass': over60, 'fail': under60})


@login_required
@permission_check(UserType.Viewer)
@require_http_methods(["GET"])
def pie_viewer(request):
    from .models import AnswerSheet
    answer_sheets_all = AnswerSheet.objects.all()

    over60 = 0
    under60 = 0

    for sheet in answer_sheets_all:
        if sheet.score >= 60:
            over60 += 1
        else:
            under60 += 1

    return render(request, 'score/pie_for_viewer.html', {'pass': over60, 'fail': under60})