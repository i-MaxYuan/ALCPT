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
from alcpt.models import User, Department, Squadron, Report, Reply, OnlineStatus, Student
from alcpt.email import email_verified, reset_password_mail
from alcpt.managerfuncs import systemmanager
from django.utils.translation import gettext as _

from django.views.generic import View
from alcpt.views import OnlineUserStat
from django.utils.decorators import method_decorator
from django.contrib.auth import login, authenticate

# 註冊
class Register(View):
    template_name = 'registration/register.html'

    def get(self, request):
        # 傳入 Identity Enum 供前端自動生成下拉選單
        return render(request, self.template_name, {"Identity": Identity})

    def post(self, request):
        reg_id = request.POST.get('username')
        email = request.POST.get('email')
        password = request.POST.get('password')
        confirm = request.POST.get('confirm')
        identity = request.POST.get('identity')  # 1=Visitor, 2=Student, 3=Teacher

        # ---------- 基本驗證 ----------
        if not reg_id or not email or not password or not confirm:
            messages.error(request, _('All fields are required.'))
            return redirect('register')

        if password != confirm:
            messages.error(request, _('Passwords do not match.'))
            return redirect('register')

        if User.objects.filter(reg_id=reg_id).exists():
            messages.error(request, _('Account already exists.'))
            return redirect('register')

        if User.objects.filter(email=email).exists():
            messages.error(request, _('Email already registered.'))
            return redirect('register')

        # ---------- 建立新帳號 ----------
        identity_value = int(identity) if identity else Identity.Student.value[0]

        user = User.objects.create_user(
            reg_id=reg_id,
            email=email,
            password=password,
            identity=identity_value
        )

        # ---------- 指定權限 (privilege) ----------
        if identity_value in [Identity.Visitor.value[0], Identity.Student.value[0]]:
            # 訪客與學生 → 受測者
            privilege_value = UserType.Testee.value[0]
        elif identity_value == Identity.Teacher.value[0]:
            # 老師 → 成績檢閱者
            privilege_value = UserType.Viewer.value[0]
        else:
            privilege_value = UserType.Testee.value[0]

        # 強制更新 privilege 欄位
        user.privilege = privilege_value
        user.save(update_fields=['privilege'])

        # ---------- 如果是學生，建立 Student ----------
        if identity_value == Identity.Student.value[0]:
            import time
            stu_id = f"S{user.id:04d}"
            current_grade = time.localtime().tm_year - 1911

            Student.objects.create(
                user=user,
                stu_id=stu_id,
                department=None,
                squadron=None,
                grade=current_grade
            )

        # ---------- 建立在線狀態紀錄 ----------
        OnlineStatus.objects.create(user=user, online_status=False)

        # ---------- 自動登入 ----------
        auth_user = auth.authenticate(username=reg_id, password=password)
        if auth_user is not None:
            login(request, auth_user)
            messages.success(request, _('Welcome! Please complete your profile.'))
            return redirect('edit_profile')

        messages.success(request, _('Register success, please login.'))
        return redirect('login')



# 登入
class Login(View,OnlineUserStat):
    
    template_name = 'registration/login.html'
    
    def do_content_works(self,request):  
        captcha = CaptchaForm()
        if request.user.is_authenticated:
            return redirect('/')

        else:
            return dict(captcha=captcha)
    
    def post(self,request):
        captcha = CaptchaForm(request.POST)
        if captcha.is_valid():  # 驗證通過
            reg_id = request.POST.get('reg_id', '')
            password = request.POST.get('password', '')
            next_page = request.GET.get('next', LOGIN_REDIRECT_URL)

            try:
                user = auth.authenticate(request, reg_id=reg_id, password=password)
                #確保自定義 backend 支援 reg_id 驗證，並加上錯誤訊息更明確
                #user = auth.authenticate(reg_id=reg_id, password=password)
                
                if user is None or not user.is_active:
                    messages.error(request, _('Wrong Password or User unexist.'))
                    return redirect('login')
                    #return render(request,self.template_name,dict(captcha=captcha))
                
                # 設定線上狀態
                login_user, created = OnlineStatus.objects.get_or_create(user=user)
                login_user.online_status = True
                login_user.save()
                
                # auth.login(request, user)
                # user.browser = request.session.session_key
                # user.save()
                
                if user.last_login is None:
                    auth.login(request, user)
                    user.browser = request.session.session_key
                    user.save()
                    
                    departments = Department.objects.all()
                    squadrons = Squadron.objects.all()
                    messages.warning(request, _('Fist login, please edit your data'))
                    privileges = UserType.__members__
                    identities = Identity.__members__.values()
                    return render(request, 'registration/edit_profile.html',
                                  dict(user=user,
                                       privileges=privileges,
                                       departments=departments,
                                       squadrons=squadrons))
                    
                auth.login(request, user)
                user.browser = request.session.session_key
                user.save()
                
                messages.success(request, _('Login Success.'))

            except ObjectDoesNotExist:
                return redirect('login')

            return redirect(next_page)
        else:
            # online_num = OnlineStatus.objects.filter(online_status=True).count()
            messages.error(request, _('Verification code error'))
            return redirect('login')


# 登出
@login_required
def logout(request, relogin=False):
    session_id = request.COOKIES.get('sessionid')
    if session_id and request.user.browser == session_id:
        request.user.browser = None
        request.user.save()
        logout_user = OnlineStatus.objects.get(user=request.user)
        logout_user.online_status = False
        logout_user.save()

    auth.logout(request)

    if relogin:
        return
    else:
        messages.success(request, _('Logout Success.'))

    return redirect(LOGOUT_REDIRECT_URL)



# 檢視個人資料
@method_decorator(login_required, name='get')
class Profile(View, OnlineUserStat):

    template_name = 'registration/profile.html'

    def do_content_works(self, request):
        user = request.user
        privileges = UserType.__members__

        return dict(user=user, privileges=privileges)



# 編輯個人資料
@method_decorator(login_required,name='get')
class EditProfile(View,OnlineUserStat):
    
    template_name = 'registration/edit_profile.html'
    
    def do_content_works(self,request):
        user = request.user
        privileges = UserType.__members__
        identities = Identity.__members__.values()
        departments = Department.objects.all()
        squadrons = Squadron.objects.all()
        
        return dict(user=user, privileges=privileges, departments=departments, squadrons=squadrons) 

    def post(self, request):
        user = request.user

        name = request.POST.get('name')
        gender = int(request.POST.get('gender', user.gender))
        introduction = request.POST.get('introduction')
        photo = request.FILES.get('photo_file')

        user = systemmanager.update_user(
            user=user, name=name, gender=gender, introduction=introduction, photo=photo
        )

        # 處理學生資料
        try:
            student = getattr(user, 'student', None)
            if not student:
                student = Student(user=user)

            # 統一處理 stu_id
            posted_stu_id = request.POST.get("stu_id")
            if not posted_stu_id:
                posted_stu_id = f"STU{user.reg_id}"

            # 檢查是否重複
            if Student.objects.exclude(user=user).filter(stu_id=posted_stu_id).exists():
                messages.error(request, f"Student ID '{posted_stu_id}' 已經存在，請使用其他值。")
                return redirect('profile')

            student.stu_id = posted_stu_id
            student.grade = int(request.POST.get('grade', 0))
            student.department = Department.objects.get(id=int(request.POST.get('department', 0)))
            student.squadron = Squadron.objects.get(id=int(request.POST.get('squadron', 0)))
            student.save()
        except ObjectDoesNotExist:
            pass

        messages.success(request, _('Saved profile successfully.'))
        return redirect('profile')

# 編輯個人資料
#@method_decorator(login_required, name='dispatch')
#class EditProfile(View):
    #template_name = 'registration/edit_profile.html'

  #  def get(self, request):
       # context = self.do_content_works(request)
      # return render(request, self.template_name, context)

    #def do_content_works(self, request):
        #user = request.user
       # departments = Department.objects.all()
      #  squadrons = Squadron.objects.all()

        # 建立 privileges list，判斷每個是否被勾選
        #privileges_list = []
        #for name, enum in UserType.__members__.items():
         #   privileges_list.append({
          #      "name": name,
           #     "label": name,  # 如果 enum 有 label 可以改成 enum.value[1]
            #    "checked": bool(user.privilege & enum.value[0])
           # })

        #return {
         #   "user": user,
          #  "privileges": privileges_list,
           # "departments": departments,
            #"squadrons": squadrons,
       # }

    #def post(self, request):
     #   user = request.user

        # ---- 更新基本資料 ----
        #user.name = request.POST.get('name', user.name)
        #try:
       #     user.gender = int(request.POST.get('gender', user.gender))
      #  except (ValueError, TypeError):
     #       pass
    #    user.introduction = request.POST.get('introduction', user.introduction)
   #     photo = request.FILES.get('photo_file')
  #      if photo:
 #           user.photo = photo
#        user.save()

        # ---- 更新權限 ----
        #privileges_selected = request.POST.getlist('privileges')  # list of privilege names
        #privilege_value = 0
        #for name in privileges_selected:
        #    if name in UserType.__members__:
        #        privilege_value |= UserType[name].value[0]  # 將選中的 bitmask 加到 privilege_value
        #user.privilege = privilege_value
        #user.save()

        # ---- 更新學生資料 ----
 #       if user.identity == 2:  # 身分是學生
#            student, _ = Student.objects.get_or_create(user=user)

      #      grade = request.POST.get('grade')
     #       if grade:
    #            try:
   #                 student.grade = int(grade)
  #              except ValueError:
 #                   pass
#
   #         department_id = request.POST.get('department')
  #          if department_id:
 #               student.department = Department.objects.filter(id=department_id).first()
#
   #         squadron_id = request.POST.get('squadron')
  #          if squadron_id:
 #               student.squadron = Squadron.objects.filter(id=squadron_id).first()
#
 #           student.save()
#
#        messages.success(request, ("Saved profile successfully."))
#        return redirect('profile')  # 導向自己的個人資料頁
    

@method_decorator(login_required, name='get')
class ChangePassword(View, OnlineUserStat):

    template_name = 'registration/password_change.html'

    def do_content_works(self, request):
        return {}

    def post(self, request):
        user = request.user
        old_password = request.POST.get('old_password')
        new_password = request.POST.get('new_password')
        verification_password = request.POST.get('verification_password')

        if not user.check_password(old_password):
            messages.error(request, _('Old password does not match.'))
            return redirect('password_change')

        if new_password != verification_password:
            messages.error(request, _('New password and confirm password do not match.'))
            return redirect('password_change')

        if new_password == old_password:
            messages.error(request, _('New password and old password are the same.'))
            return redirect('password_change')

        user.set_password(new_password)
        user.update_time = timezone.now()
        user.save()

        messages.success(request, _('Password changed successfully. Please login again.'))
        return redirect('login')



def reset_password(request, encode_reg_id):
    if request.method == 'POST':
        new_password = request.POST.get('new_password')
        verification_password = request.POST.get('verification_password')

        if new_password != verification_password:
            messages.warning(request, _("New password and verificaiton password doesn't match."))
            return render(request, 'registration/password_reset.html', locals())
        else:
            # 安全 Base64 解碼
            try:
                decode_reg_id = base64.b64decode(encode_reg_id.encode('ascii')).decode('ascii')
            except (binascii.Error, UnicodeDecodeError):
                messages.error(request, _("Invalid reset link."))
                return redirect('login')

            try:
                user = User.objects.get(reg_id=decode_reg_id)
            except ObjectDoesNotExist:
                messages.error(request, _("User does not exist."))
                return redirect('login')

            user.set_password(new_password)
            user.save()
            messages.success(request, _("Reset password successfully, please login with new password."))
            return redirect('login')
    else:
        return render(request, 'registration/password_reset.html', locals())


@login_required
def verification(request):
    user = request.user
    user.email = request.POST.get('verified_email')
    user.email_is_verified = False
    user.save()
    try:
        email_verified(user, request.POST.get('verified_email'), request.user)
        messages.success(request, _("Verification email has been sent, please check out."))
    except Exception as e:
        messages.error(request, _("Failed to send verification email: {}").format(e))


@login_required
def verify_done(request, encode_email):
    user = request.user
    # 安全 Base64 解碼
    try:
        decode_email = base64.b64decode(encode_email.encode('ascii')).decode('ascii')
    except (binascii.Error, UnicodeDecodeError):
        messages.error(request, _("Invalid verification link."))
        return redirect('profile')
    
    if user.email and user.email != decode_email:
        messages.error(request, _("Verification email does not match current user."))
        return redirect('profile')

    user.email = decode_email
    user.email_is_verified = True
    user.save()
    messages.success(request, _("Verfication Success"))
    return redirect('profile')


def forget_password(request):
    if request.method == 'POST':
        reg_id = request.POST.get('reg_id')
        email = request.POST.get('email')

        if User.objects.filter(reg_id=reg_id, email=email):
            reset_password_mail(reg_id, email)
            messages.success(request, _("Reset link has been sent, please check your email."))
            return redirect('login')
        else:
            messages.error(request, _("User does not exist. Try again."))
            return render(request, 'email_to_reset_password.html', locals())
    else:
        return render(request, 'email_to_reset_password.html')


# 取得個人所回報的所有問題
@method_decorator(login_required, name='get')
class ReportList(View, OnlineUserStat):

    template_name = 'registration/report_list.html'

    def do_content_works(self, request):
        reports = Report.objects.filter(created_by=request.user).order_by('-created_time')
        return dict(reports=reports)


@method_decorator(login_required, name='get')
class ReportDetail(View, OnlineUserStat):

    template_name = 'registration/report_detail.html'

    def do_content_works(self, request, report_id):
        try:
            viewed_report = Report.objects.get(id=report_id)
            if viewed_report.created_by == request.user:
                pass
            elif request.user.has_perm(UserType.SystemManager):
                pass
            else:
                messages.warning(request, _('You have no permission'))
                return redirect('Homepage')
        except ObjectDoesNotExist:
            messages.error(request, "Report doesn't exist, report id: {}".format(report_id))
            return redirect('report_list')

        Report.objects.filter(id=report_id).update(user_notification=False)

        replies = viewed_report.reply_set.all().order_by('created_time')
        return dict(viewed_report=viewed_report, replies=replies)

    def post(self, request, report_id):
        viewed_report = Report.objects.get(id=report_id)

        if viewed_report.state == 3 or viewed_report.resolved_by:
            messages.warning(request, _('This report had been resolved.'))
            return redirect('report_list')

        reply = request.POST.get('reply')
        new_reply = Reply.objects.create(source=viewed_report, content=reply, created_by=request.user)
        viewed_report.user_notification = False
        viewed_report.staff_notification = True
        viewed_report.save()
        return redirect('report_list')


@login_required
def email(request):
    user = request.user
    return render(request, 'registration/email.html', locals())

