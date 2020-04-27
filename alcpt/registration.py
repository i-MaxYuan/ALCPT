import base64

from django.shortcuts import render, redirect

from django.utils import timezone
from django.contrib import auth
from django.contrib import messages
from django.contrib.auth.decorators import login_required

from django.core.exceptions import ObjectDoesNotExist

from Online_Exam.settings import LOGIN_REDIRECT_URL, LOGOUT_REDIRECT_URL
from alcpt.definitions import UserType, Identity
from alcpt.forms import CaptchaForm
from alcpt.models import User, Department, Squadron, Report, Reply
from alcpt.email import email_verified, reset_password_mail
from alcpt.managerfuncs import systemmanager

# Create your views here.


# 登入
def login(request):
    if request.method == 'POST':
        captcha = CaptchaForm(request.POST)
        if captcha.is_valid():  # 驗證通過
            reg_id = request.POST.get('reg_id', '')
            password = request.POST.get('password', '')
            next_page = request.GET.get('next', LOGIN_REDIRECT_URL)

            try:
                user = auth.authenticate(reg_id=reg_id, password=password)

                if user is None or not user.is_active:
                    messages.error(request, 'Wrong Password or User unexist.')
                    return render(request, 'registration/login.html', locals())

                auth.login(request, user)
                user.save()
                if user.last_login is None:
                    departments = Department.objects.all()
                    squadrons = Squadron.objects.all()
                    messages.warning(request, 'Fist login, please edit your data')
                    privileges = UserType.__members__
                    identities = Identity.__members__.values()
                    return render(request, 'registration/edit_profile.html', locals())
                messages.success(request, 'Login Success.')

            except ObjectDoesNotExist:
                return redirect('login')

            return redirect(next_page)
        else:
            messages.error(request, 'Verification code error')
            return redirect('login')

    else:
        captcha = CaptchaForm()
        if request.user.is_authenticated:
            return redirect('/')

        else:
            return render(request, 'registration/login.html', locals())


# 登出
@login_required
def logout(request):
    auth.logout(request)
    messages.success(request, 'Logout Success.')

    return redirect(LOGOUT_REDIRECT_URL)


# 檢視個人資料
@login_required
def profile(request):
    user = request.user
    privileges = UserType.__members__
    return render(request, 'registration/profile.html', locals())


# 編輯個人資料
@login_required
def edit_profile(request):
    user = request.user

    if request.method == 'POST':
        name = request.POST.get('name')
        gender = int(request.POST.get('gender'))
        introduction = request.POST.get('introduction')
        photo = request.FILES.get('photo_file')

        user = systemmanager.update_user(user=user, name=name, gender=gender, introduction=introduction, photo=photo)

        try:
            student = user.student
            student.grade = int(request.POST.get('grade',))
            student.department = Department.objects.get(id=int(request.POST.get('department',)))
            student.squadron = Squadron.objects.get(id=int(request.POST.get('squadron',)))
            student.save()
        except ObjectDoesNotExist:
            pass

        messages.success(request, 'Saved profile successfully.')
        return redirect('profile')

    else:
        privileges = UserType.__members__
        identities = Identity.__members__.values()
        departments = Department.objects.all()
        squadrons = Squadron.objects.all()
        return render(request, 'registration/edit_profile.html', locals())


# 更改密碼
@login_required
def change_password(request):
    if request.method == 'POST':
        user = request.user
        old_password = request.POST.get('old_password',)

        if user.check_password(old_password):
            pass
        else:
            messages.error(request, 'Old password does not match.')
            return redirect('password_change')

        new_password = request.POST.get('new_password',)
        verification_password = request.POST.get('verification_password',)

        if new_password == old_password:
            messages.error(request, 'New password and old password are the same.')
            return redirect('password_change')
        elif new_password != verification_password:
            messages.error(request, 'Verification error.')
            return redirect('password_change')
        else:
            user.set_password(new_password)
            user.update_time = timezone.now()
            user.save()

            messages.success(request, 'Password change successfully. Please login again with new password.')
            return redirect('profile')
    else:
        return render(request, 'registration/password_change.html', locals())


def reset_password(request, encode_reg_id):
    if request.method == 'POST':
        new_password = request.POST.get('new_password')
        verification_password = request.POST.get('verification_password')

        if new_password != verification_password:
            messages.warning(request, "New password and verificaiton password doesn't match.")
            return render(request, 'registration/password_reset.html', locals())
        else:
            decode_reg_id = base64.b64decode(encode_reg_id.encode('ascii')).decode('ascii')
            user = User.objects.get(reg_id=decode_reg_id)

            user.set_password(new_password)
            user.save()
            messages.success(request, "Reset password successfully, please login with new password.")
            return redirect('login')
    else:
        return render(request, 'registration/password_reset.html', locals())


@login_required
def verification(request):
    user = request.user
    user.email = request.POST.get('verified_email')
    user.email_is_verified = False
    user.save()
    email_verified(user, request.POST.get('verified_email'), request.user)
    messages.success(request, "Verification email has been sent, please check out.")
    return redirect('email')


@login_required
def verify_done(request, encode_email):
    user = request.user

    # decode the verified email
    decode_email = base64.b64decode(encode_email.encode('ascii')).decode('ascii')

    user.email = decode_email
    user.email_is_verified = True
    user.save()
    messages.success(request, "Verfication Success")
    return redirect('profile')


def forget_password(request):
    if request.method == 'POST':
        reg_id = request.POST.get('reg_id')
        email = request.POST.get('email')

        if User.objects.filter(reg_id=reg_id, email=email):
            reset_password_mail(reg_id, email)
            messages.success(request, "Reset link has been sent, please check your email.")
            return redirect('login')
        else:
            messages.error(request, "User does not exist. Try again.")
            return render(request, 'email_to_reset_password.html', locals())
    else:
        return render(request, 'email_to_reset_password.html')


# 取得個人所回報的所有問題
@login_required
def report_list(request):
    reports = Report.objects.filter(created_by=request.user).order_by('-created_time')
    return render(request, 'registration/report_list.html', locals())


@login_required
def report_detail(request, report_id):
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

    if request.method == 'POST':
        if viewed_report.state == 3 or viewed_report.resolved_by:
            messages.warning(request, 'This report had been resolved.')
            return redirect('report_list')
        reply = request.POST.get('reply')
        new_reply = Reply.objects.create(source=viewed_report, content=reply, created_by=request.user)
        viewed_report.user_notification = False
        viewed_report.staff_notification = True
        viewed_report.save()
        return redirect('report_list')
    else:
        Report.objects.filter(id=report_id).update(user_notification=False)

        replies = viewed_report.reply_set.all().order_by('created_time')
        return render(request, 'registration/report_detail.html', locals())


@login_required
def email(request):
    user = request.user
    return render(request, 'registration/email.html', locals())
