import re

from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from Online_Exam.settings import LOGIN_REDIRECT_URL, LOGIN_URL
from django.contrib import auth, messages

from .definitions import UserType
from .exceptions import IllegalArgumentError

PATTERNS = {
    "serial_number": "[a-zA-Z0-9\._-]+",
    "password": "[a-zA-Z0-9\.!@#\$%\^&\*]+"
}


# 登入
def login(request):
    if request.method == 'POST':
        serial_number = request.POST.get('serial_number', '')
        password = request.POST.get('password', '')
        next_page = request.GET.get('next', LOGIN_REDIRECT_URL)

        try:
            for field in ['serial_number', 'password']:
                if not re.match(PATTERNS[field], eval(field)):
                    raise IllegalArgumentError()

            user = auth.authenticate(serial_number=serial_number, password=password)

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
    return render(request, 'index.html', {"user_types": UserType.__members__})