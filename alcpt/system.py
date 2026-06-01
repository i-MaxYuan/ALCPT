import re
import xlrd
import os
import json
import datetime

from string import punctuation
from django.contrib import auth
from django.core import serializers
from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.http import require_http_methods

from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.core.exceptions import ObjectDoesNotExist
from django.db import IntegrityError
from django.contrib import messages


from alcpt.managerfuncs import systemmanager
from alcpt.models import User, Student, Department, Squadron, ReportCategory, Report, Reply, UserAchievement, Achievement, OnlineStatus,Proclamation
from alcpt.proclamation import notify
from alcpt.definitions import UserType, Identity, AchievementCategory
from alcpt.decorators import permission_check, login_required
from alcpt.exceptions import IllegalArgumentError
from django.utils.translation import gettext as _
from django.apps import apps
from django.db import models


from django.views.generic import View
from alcpt.views import OnlineUserStat, FromWhere
from django.utils.decorators import method_decorator
from django.urls import reverse

from django.utils.http import urlencode
from django.db.models import Count

from alcpt.forms import AchievementForm

@method_decorator(permission_check(UserType.SystemManager),name='dispatch')
class AchievementList(View,OnlineUserStat):

    template_name = 'achievement/achievement_list.html'    
   
    def do_content_works(self,request): # list_achievements
        return {'achievements':Achievement.objects.all()}

# @permission_check(UserType.SystemManager)
# def achievement_list(request):
#     achievements = Achievement.objects.all()
#     return render(request, 'achievement/achievement_list.html', locals())

@method_decorator(permission_check(UserType.SystemManager),name='dispatch')
class AchievementCreate(View,OnlineUserStat):

    template_name = 'achievement/achievement_create.html'
   
    def do_content_works(self,request):
        return {'achievement_categories':AchievementCategory.__members__.values()}
   
    def post(self, request):
        trophy = request.FILES.get('trophy')
        name = request.POST.get('name')
        key = request.POST.get('key')
        description = request.POST.get('description')
        category = request.POST.get('category')
        point = request.POST.get('point')
        level = request.POST.get('level')
        completion = request.POST.get('completion')

        try:
            Achievement.objects.get(name=name)
            messages.error(request, "Failed created, Achievement name had been used - {}".format(name))
            return redirect('achievement_create')

        except:
            achievement = Achievement.objects.create(trophy=trophy,
                                                     name=name,
                                                     key=key,
                                                     description=description,
                                                     category=category,
                                                     point=point,
                                                     level=level,
                                                     completion=completion)
           
            messages.success(request, _('Successfully created.'))
            return redirect('achievement_list')




# @permission_check(UserType.SystemManager)
# def achievement_create(request):
#     if request.method == 'POST':
#         trophy = request.FILES.get('trophy')
#         name = request.POST.get('name')
#         key = request.POST.get('key')
#         description = request.POST.get('description')
#         category = request.POST.get('category')
#         point = request.POST.get('point')
#         level = request.POST.get('level')
#         completion = request.POST.get('completion')

#         try:
#             Achievement.objects.get(name=name)
#             messages.error(request, "Failed created, Achievement name had been used - {}".format(name))
#             return redirect('achievement_create')

#         except:
#             achievement = Achievement.objects.create(trophy=trophy,
#                                                      name=name,
#                                                      key=key,
#                                                      description=description,
#                                                      category=category,
#                                                      point=point,
#                                                      level=level,
#                                                      completion=completion)
#             achievement.save()
#             messages.success(request, _('Successfully created.'))
#             return redirect('achievement_list')
#     else:
#         achievement_categories = AchievementCategory.__members__.values()
#         return render(request, 'achievement/achievement_create.html', locals())

# 使用者列表
@method_decorator(permission_check(UserType.SystemManager), name='dispatch')
class UserList(View, OnlineUserStat):

    template_name = 'user/index.html'

    def do_content_works(self, request):
        # 關鍵字搜尋
        keywords = {
            'name': request.GET.get('name')
        }

        # 過濾特殊字符
        if keywords['name'] and any(char in punctuation for char in keywords['name']):
            keywords['name'] = None
            messages.warning(request, "Name cannot contain any special character.")

        # 其他篩選條件
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

        # 取得使用者列表
        query_content, users = systemmanager.query_users(**keywords)
        users = users.order_by('-last_login')  # 依最後登入時間排序

        # 分頁
        page_str = request.GET.get('page', '1')
        try:
            page = int(page_str)
            if page < 1:
                page = 1
        except (ValueError, TypeError):
            page = 1

        paginator = Paginator(users, 8)
        try:
            userList = paginator.page(page)
        except (PageNotAnInteger, EmptyPage):
            # 如果頁碼非法或超出範圍，顯示第一頁
            userList = paginator.page(1)

        # 產生 query string（排除 page）
        query_dict = request.GET.copy()
        query_dict.pop('page', None)
        query_content = urlencode(query_dict)

        return {
            'departments': Department.objects.all(),
            'squadrons': Squadron.objects.all(),
            'privileges': UserType.__members__,
            'keywords': keywords,
            'userList': userList,
            'query_content': query_content
        }


# @permission_check(UserType.SystemManager)
# def user_list(request):
#     keywords = {
#         'name': request.GET.get('name')
#     }

#     if keywords['name'] and any(char in punctuation for char in keywords['name']):
#         keywords['name'] = None
#         messages.warning(request, "Name cannot contains any special character.")

#     for keyword in ['department', 'grade', 'squadron']:
#         try:
#             keywords[keyword] = int(request.GET.get(keyword))
#         except (KeyError, TypeError, ValueError):
#             keywords[keyword] = None

#     if keywords['department']:
#         try:
#             keywords['department'] = Department.objects.get(id=keywords['department'])
#         except ObjectDoesNotExist:
#             keywords['department'] = None

#     if keywords['squadron']:
#         try:
#             keywords['squadron'] = Squadron.objects.get(id=keywords['squadron'])
#         except ObjectDoesNotExist:
#             keywords['squadron'] = None

#     query_content, users = systemmanager.query_users(**keywords)
#     departments = Department.objects.all()
#     squadrons = Squadron.objects.all()
#     privileges = UserType.__members__

#     page = request.GET.get('page', 1)
#     paginator = Paginator(users, 8)  # the second parameter is used to display how many items. Now is display 10

#     try:
#         userList = paginator.page(page)
#     except PageNotAnInteger:
#         userList = paginator.page(1)
#     except EmptyPage:
#         userList = paginator.page(paginator.num_pages)

#     return render(request, 'user/index.html', locals())


# 新增使用者（單一）
@method_decorator(permission_check(UserType.SystemManager),name='dispatch')
class UserCreate(View,OnlineUserStat):
   
    template_name = 'user/create_user.html'
   
    privileges = UserType.__members__.values()
    identities = Identity.__members__.values()
    departments = Department.objects.all()
    squadrons = Squadron.objects.all()
   
    def do_content_works(self,request):
        return dict(privileges = self.privileges,
                    identities = self.identities,
                    departments = self.departments,
                    squadrons = self.squadrons)
   
    def post(self,request):
        reg_id = request.POST.get('reg_id',)
        stu_id = request.POST.get('stu_id')
        privilege_value = 0
   
        for privilege in self.privileges:
   
            if privilege and request.POST.get('{}'.format(privilege)):
                privilege_value |= privilege.value[0]

        try:
            identity = int(request.POST.get('identity'))
   
            if identity == 2:
               
                if stu_id:
                    #判斷stu_id是否存在
                    if Student.objects.all().filter(stu_id=stu_id):
                        messages.error(request, _('exist student ID._'+stu_id))
                        privileges = self.privileges
                        identities = self.identities
                        departments = self.departments
                        squadrons = self.squadrons
                        return redirect('user_create')
                       
                    else:
                        new_user = User.objects.create_user(reg_id=reg_id, privilege=privilege_value, password=reg_id)
                        new_user.identity = identity
                        new_user_stu = Student.objects.create(stu_id=stu_id, user=new_user)
                        OnlineStatus.objects.create(user=new_user)  #新增上線狀態欄位
                         
                        if request.POST.get('department'):
                            new_user_stu.department = Department.objects.get(id=int(request.POST.get('department')))
   
                        if request.POST.get('squadron'):
                            new_user_stu.squadron = Squadron.objects.get(id=int(request.POST.get('squadron')))
   
                        if request.POST.get('grade'):
                            new_user_stu.grade = request.POST.get('grade')

                        new_user.save()
                        new_user_stu.save()


                        messages.success(request, _('Successfully Created - User, Student'))
                        return redirect('user_list')

                else:
                    messages.warning(request, _('Please input the student ID.'))
                    privileges = UserType.__members__
                    identities = self.identities
                    departments = self.departments
                    squadrons = self.squadrons
                    return redirect('user_create')
                   

            else:
                new_user = User.objects.create_user(reg_id=reg_id, privilege=privilege_value, password=reg_id)
                new_user.identity = identity
                new_user.save()
                OnlineStatus.objects.create(user=new_user)
                messages.success(request, _('Successfully Created - User'))

                if stu_id:
                    messages.warning(request, _('You are not student.'))

                return redirect('user_list')

        except IntegrityError:
            messages.error(request, "Existed user, register ID - {}".format(reg_id))
            privileges = UserType.__members__
            identities = self.identities
            departments = self.departments
            squadrons = self.squadrons
            return redirect('user_create')


# @permission_check(UserType.SystemManager)
# def user_create(request):
#     if request.method == 'POST':
#         reg_id = request.POST.get('reg_id',)

#         privilege_value = 0
#         for privilege in UserType.__members__.values():
#             if privilege and request.POST.get('{}'.format(privilege)):
#                 privilege_value |= privilege.value[0]

#         try:
#             identity = int(request.POST.get('identity'))
#             if identity == 2:
#                 if request.POST.get('stu_id'):
#                     #判斷stu_id是否存在
#                     if Student.objects.all().filter(stu_id=request.POST.get('stu_id')):
#                         privileges = UserType.__members__.values()
#                         identities = Identity.__members__.values()
#                         departments = Department.objects.all()
#                         squadrons = Squadron.objects.all()
#                         messages.error(request, _('exist student ID.'))
#                         return render(request, 'user/create_user.html', locals())
#                     else:
#                         new_user = User.objects.create_user(reg_id=reg_id, privilege=privilege_value, password=reg_id)
#                         new_user.identity = identity

#                         new_user_stu = Student.objects.create(stu_id=request.POST.get('stu_id'), user=new_user)
#                         if request.POST.get('department'):
#                             new_user_stu.department = Department.objects.get(id=int(request.POST.get('department')))
#                         if request.POST.get('squadron'):
#                             new_user_stu.squadron = Squadron.objects.get(id=int(request.POST.get('squadron')))
#                         if request.POST.get('grade'):
#                             new_user_stu.grade = request.POST.get('grade')

#                         new_user.save()
#                         new_user_stu.save()
#                         messages.success(request, _('Successfully Created - User, Student'))
#                         return redirect('user_list')

#                 else:
#                     messages.warning(request, _('Please input the student ID.'))
#                     privileges = UserType.__members__
#                     identities = Identity.__members__.values()
#                     departments = Department.objects.all()
#                     squadrons = Squadron.objects.all()
#                     return render(request, 'user/create_user.html', locals())

#             else:
#                 new_user = User.objects.create_user(reg_id=reg_id, privilege=privilege_value, password=reg_id)
#                 new_user.identity = identity
#                 new_user.save()
#                 messages.success(request, _('Successfully Created - User'))

#                 if request.POST.get('stu_id'):
#                     messages.warning(request, _('You are not student.'))

#                 return redirect('user_list')

#         except IntegrityError:
#             messages.error(request, "Existed user, register ID - {}".format(reg_id))
#             privileges = UserType.__members__
#             identities = Identity.__members__.values()
#             departments = Department.objects.all()
#             squadrons = Squadron.objects.all()
#             return redirect('user_create')

#     else:
#         privileges = UserType.__members__.values()
#         identities = Identity.__members__.values()
#         departments = Department.objects.all()
#         squadrons = Squadron.objects.all()
        # return render(request, 'user/create_user.html', locals())


# 新增使用者（多重）
@method_decorator(permission_check(UserType.SystemManager),name='dispatch')
class UserMultiCreate(View,OnlineUserStat):

    template_name = 'user/multi_create_user.html'

    def do_content_works(self,request):
        return dict(privileges = UserType.__members__)

    def post(self,request):
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

                        if re.findall(r"[#*'”;/\\ ,|+=-]", row[0]):
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

        for user in new_users:
            new_user = User.objects.create_user(reg_id=user[0], privilege=privilege_value, password=user[0])
            new_user.name = user[1]
            new_user.identity = user[2]
            new_user.save()

        messages.success(request, 'Successfully Created users - {}'.format(len(new_users)))

        return redirect('user_list')


# @permission_check(UserType.SystemManager)
# def user_multiCreate(request):
#     if request.method == 'POST':
#         if request.FILES.get('users_file',):
#             wb = xlrd.open_workbook(filename=None, file_contents=request.FILES['users_file'].read())
#             table = wb.sheets()[0]
#             new_users = []

#             for i in range(table.nrows):
#                 row = table.row_values(i)
#                 if row[0]:  # account
#                     if isinstance(row[0], float):
#                         row[0] = int(row[0])
#                     if isinstance(row[0], str):
#                         if re.findall("[#*'”;/\\\ ,|+=-]", row[0]):
#                             continue
#                     if not isinstance(row[2], float) or row[2] == '':   # identity
#                         row[2] = 1
#                     if isinstance(row[2], float):
#                         row[2] = int(row[2])
#                         if row[2] < 1 or row[2] > 3:
#                             row[2] = 1
#                     new_users.append(row)   # valid user

#         else:
#             messages.warning(request, 'Must enter textarea or load a file.')
#             return redirect('user_multiCreate')

#         privilege_value = 0
#         if request.user.has_perm(UserType.SystemManager):
#             i = 0
#             for privilege in UserType.__members__.values():
#                 if privilege and request.POST.get('privilege_{}'.format(i)):
#                     privilege_value |= privilege.value[0]
#                 i += 1

#         else:
#             privilege_value = UserType.Testee.value[0]

#         for user in new_users:
#             new_user = User.objects.create_user(reg_id=user[0], privilege=privilege_value, password=user[0])
#             new_user.name = user[1]
#             new_user.identity = user[2]
#             new_user.save()

#         messages.success(request, 'Successfully Created users - {}'.format(len(new_users)))

#         return redirect('user_list')

#     else:
#         privileges = UserType.__members__

#         return render(request, 'user/multi_create_user.html', locals())






# 更改使用者
@method_decorator(permission_check(UserType.SystemManager), name='dispatch')
class UserEdit(View):
    template_name = 'user/edit_user.html'

    def do_content_works(self, request, reg_id):
        try:
            edited_user = get_object_or_404(User, reg_id=reg_id)

            # 權限列舉轉為 dict list（含 checked 狀態）
            privileges = [
                {
                    "name": p.name,
                    "label": _(p.value[1]),
                    "checked": bool(edited_user.privilege & p.value[0]),
                }
                for p in UserType
            ]

            # 身分選項
            identities = [
                {"code": i.value[0], "label": i.value[1]} for i in Identity
            ]

            # 預設學生資料
            student = None
            #departments = Department.objects.none()
            #squadrons = Squadron.objects.none()
            departments = Department.objects.all()
            squadrons = Squadron.objects.all()

            # 若為學生身份，取資料
            if edited_user.identity == Identity.Student.value[0]:
                try:
                    #student = edited_user.student
                    student = getattr(edited_user, 'student', None)
                    departments = Department.objects.all()
                    squadrons = Squadron.objects.all()
                except Student.DoesNotExist:
                    student = None

            return {
                "edited_user": edited_user,
                #"user": edited_user,
                "student": student,
                "privileges": privileges,
                "identities": identities,
                "departments": departments,
                "squadrons": squadrons,
                "user_edit_url": reverse("user_edit", args=[reg_id]),
                "user_list_url": reverse("user_list"),
            }

        except User.DoesNotExist:
            messages.error(request, f"User doesn't exist, register id - {reg_id}")
            return {
                "edited_user": None,
                "user": None,
                "student": None,
                "privileges": [],
                "identities": [{"code": i.value[0], "label": i.value[1]} for i in Identity],
                "departments": Department.objects.none(),
                "squadrons": Squadron.objects.none(),
                "user_edit_url": "",
                "user_list_url": reverse("user_list"),
            }

    def get(self, request, reg_id):
        context = self.do_content_works(request, reg_id)
        return render(request, self.template_name, context)

    def post(self, request, reg_id):
        try:
            edited_user = get_object_or_404(User, reg_id=reg_id)

            # 更新權限
            selected_privs = request.POST.getlist("privileges") or []
            privilege_value = 0
            for p in UserType:
                if p.name in selected_privs:
                    privilege_value |= p.value[0]

            # 更新基本資料
            edited_user.name = request.POST.get("name", edited_user.name)
            edited_user.email = request.POST.get("email", edited_user.email)
            gender = request.POST.get("gender")
            if gender:
                edited_user.gender = int(gender)
            identity = request.POST.get("identity")
            if identity:
                edited_user.identity = int(identity)
            edited_user.privilege = privilege_value
            edited_user.save()

            # 處理學生資料
            if identity and int(identity) == Identity.Student.value[0]:
                student, _ = Student.objects.get_or_create(user=edited_user)

                # 統一處理 stu_id
                posted_stu_id = request.POST.get("stu_id")
                if not posted_stu_id:
                    # 若沒有輸入，就用 reg_id 或自訂規則生成
                    posted_stu_id = f"STU{edited_user.reg_id}"

                # 檢查是否重複
                if Student.objects.exclude(user=edited_user).filter(stu_id=posted_stu_id).exists():
                    messages.error(request, f"Student ID '{posted_stu_id}' 已經存在，請使用其他值。")
                    context = self.do_content_works(request, reg_id)
                    return render(request, self.template_name, context)

                student.stu_id = posted_stu_id

                grade = request.POST.get("grade")
                student.grade = int(grade) if grade else None

                dept_id = request.POST.get("department")
                student.department = Department.objects.get(id=int(dept_id)) if dept_id else None

                sq_id = request.POST.get("squadron")
                student.squadron = Squadron.objects.get(id=int(sq_id)) if sq_id else None

                student.save()
            else:
                Student.objects.filter(user=edited_user).delete()

            messages.success(request, "Successfully updated user.")
            return redirect("user_list")

        except Exception as e:
            import traceback
            print(traceback.format_exc())
            messages.error(request, f"Failed to update user: {str(e)}")
            context = self.do_content_works(request, reg_id)
            return render(request, self.template_name, context)




# @permission_check(UserType.SystemManager)
# def user_edit(request, reg_id):
#     privileges = UserType.__members__.values()
#     identities = Identity.__members__.values()

#     if request.method == 'POST':

#         privilege_value = 0
#         for privilege in privileges:
#             if privilege and request.POST.get('{}'.format(privilege)):
#                 privilege_value |= privilege.value[0]

#         try:
#             edited_user = User.objects.get(reg_id=reg_id)

#             edited_user.name = request.POST.get('name')
#             edited_user.email = request.POST.get('email')
#             edited_user.gender = int(request.POST.get('gender'))
#             edited_user.privilege = privilege_value

#             if int(request.POST.get('identity')) == 2:
#                 edited_user.identity = request.POST.get('identity')
#                 edited_user.save()
#                 try:
#                     edited_student = edited_user.student
#                     edited_student.grade = request.POST.get('grade')
#                     if request.POST.get('department'):
#                         edited_student.department = Department.objects.get(id=request.POST.get('department'))
#                     if request.POST.get('squadron'):
#                         edited_student.squadron = Squadron.objects.get(id=request.POST.get('squadron'))
#                     edited_student.save()
#                     try:
#                         edited_user.reg_id = request.POST.get('reg_id')
#                         edited_student.stu_id = request.POST.get('stu_id')
#                         edited_user.save()
#                         edited_student.save()

#                         messages.success(request, _("Successfully updated user."))
#                         return redirect('user_list')

#                     except IntegrityError:
#                         messages.warning(request, _("This ID had been used."))
#                         departments = Department.objects.all()
#                         squadrons = Squadron.objects.all()
#                         return render(request, 'user/edit_user.html', locals())

#                 except ObjectDoesNotExist:
#                     Student.objects.create(stu_id=edited_user.reg_id, user=edited_user).save()
#                     messages.warning(request, _("Please update Student information."))
#                     return redirect('user_list')

#             else:
#                 try:
#                     edited_user.reg_id = request.POST.get('reg_id')
#                     edited_user.identity = request.POST.get('identity')
#                     edited_user.save()

#                     if edited_user.student:
#                         Student.objects.get(user=edited_user).delete()

#                     messages.success(request, _("Successfully updated user."))
#                     return redirect('user_list')

#                 except IntegrityError:
#                     messages.warning(request, _("This register ID had been used."))
#                     try:
#                         edited_user.student
#                         departments = Department.objects.all()
#                         squadrons = Squadron.objects.all()
#                     except ObjectDoesNotExist:
#                         pass

#                     return render(request, 'user/edit_user.html', locals())

#         except ObjectDoesNotExist:
#             messages.error(request, "User doesn't exist, user register id - {}".format(reg_id))
#             return redirect('user_list')
#     else:
#         try:
#             edited_user = User.objects.get(reg_id=reg_id)
#             try:
#                 edited_user.student
#                 departments = Department.objects.all()
#                 squadrons = Squadron.objects.all()
#             except ObjectDoesNotExist:
#                 pass

#             reg_ids = [_.reg_id for _ in User.objects.all().exclude(reg_id=reg_id)]
#             stu_ids = [_.stu_id for _ in Student.objects.all().exclude(stu_id=edited_user.reg_id)]
#             return render(request, 'user/edit_user.html', locals())

#         except:
#             messages.error(request, "User doesn't exist, user register id - {}".format(reg_id))
#             return redirect('user_list')

# 刪除使用者
def user_del(request, reg_id):
    """
    安全刪除使用者：
    1. 將所有指向該使用者的 ForeignKey 更新為 NULL（如果允許 null）或管理員。
    2. 刪除使用者。
    """
    try:
        user = User.objects.get(reg_id=reg_id)
        
        # 嘗試找到管理員帳號
        try:
            admin_user = User.objects.get(reg_id=1)  # 假設 reg_id=1 是管理員
        except User.DoesNotExist:
            admin_user = None

        # 1. 更新 created_by
        if admin_user:
            Proclamation.objects.filter(created_by=user).update(created_by=admin_user)
        else:
            Proclamation.objects.filter(created_by=user).update(created_by=None)

        # 2. 更新 recipient
        Proclamation.objects.filter(recipient=user).update(recipient=None)

        # 3. 刪除使用者
        user.delete()
        messages.success(request, _("Successfully deleted user."))

    except ObjectDoesNotExist:
        messages.error(request, _("ERROR! user does not exist!"))

    return redirect('user_list')



# 刪除使用者
#def user_del(request,reg_id):
#    try:
#        user = User.objects.get(reg_id=reg_id).delete()
#        # user.delete()
#        # user_status = OnlineStatus.objects.get(reg_id=reg_id).delete()
#        messages.success(request, _("Successfully deleted user."))
#        # return redirect('user_list')
#    except ObjectDoesNotExist:
#        messages.error(request,_("ERROR! user does not exist!"))
#        # return redirect('user_list')
#    return redirect('user_list')

# 單位列表unit_kind ==> Model
#根據傳入的 unit_kind（單位種類字串）回傳對應的 Model 類別。若 unit_kind 無效，則回傳 None
def get_unit_model(unit_kind):
    if unit_kind == 'squadron':
        return Squadron
    elif unit_kind == 'department':
        return Department
    else:
        return None

# 單位列表
@method_decorator(permission_check(UserType.SystemManager), name='dispatch')
@method_decorator(require_http_methods(["GET"]), name='dispatch')
class Unit(View, OnlineUserStat):

    template_name = 'user/unit_list.html'

    def do_content_works(self, request):
        # 讀取 GET 參數，預設多→少
        dept_order = request.GET.get('dept_order', 'desc')
        squad_order = request.GET.get('squad_order', 'desc')

        departments = Department.objects.annotate(student_count=Count('student')).order_by('-student_count' if dept_order == 'desc' else 'student_count')
        squadrons = Squadron.objects.annotate(student_count=Count('student')).order_by('-student_count' if squad_order == 'desc' else 'student_count')

        return {
            'departments': departments,
            'squadrons': squadrons,
            'dept_order': dept_order,
            'squad_order': squad_order,
        }
        

# @permission_check(UserType.SystemManager)
# @require_http_methods(["GET"])
# def unit(request):
#     departments = Department.objects.all()
#     squadrons = Squadron.objects.all()
#     return render(request, 'user/unit_list.html', locals())


# 新增單位（學系、中隊）
@method_decorator(permission_check(UserType.SystemManager),name='dispatch')
@method_decorator(require_http_methods(["GET", "POST"]),name='dispatch')
class CreateUnit(View,OnlineUserStat):
   
    template_name = 'user/create_unit.html'

    def do_content_works(self,request):
        return {}
   
    def post(self,request):
        name = request.POST.get('unit_name', '').strip()
        unit_type = request.POST.get('unit', '').strip()
        # 從 POST 取得使用者輸入的單位名稱與類型，並使用 .strip() 去除多餘空白。
        # 若名稱或類型為空，顯示錯誤訊息並導回建立頁面。

        if not name or not unit_type:
            messages.error(request, _("Unit name cannot be empty."))
            return redirect('unit_create')
        
        model = get_unit_model(unit_type) #根據選擇的 unit_type 取得對應的資料模型
        if not model:
            messages.error(request, _("choose the correct unit type."))
            return redirect('unit_create')

        try:
            model.objects.create(name=name) # 嘗試建立新單位，名稱由使用者輸入
        except IntegrityError: # 若名稱已存在（唯一性衝突），顯示錯誤訊息並導回表單
            messages.error(request, _("This name has already been used."))
            return redirect('unit_create')
       
        messages.success(request, _(f"Successfully add new unit: {name}."))
        return redirect('unit_list')

# @permission_check(UserType.SystemManager)
# @require_http_methods(["GET", "POST"])
# def create_unit(request):
#     name = request.POST.get('unit_name')

#     if request.method == 'POST':
#         try:
#             if request.POST.get('unit') == 'department':
#                 Department.objects.create(name=name)

#             elif request.POST.get('unit') == 'squadron':
#                 Squadron.objects.create(name=name)

#             else:
#                 messages.error(request, _('Choose the unit which you want to create.'))
#                 return redirect('unit_create')
#         except IntegrityError:
#             messages.error(request, _("This name had been used."))
#             return redirect('unit_create')

#         messages.success(request, 'Success insert new unit: {}.'.format(name))

#         return redirect('unit_list')

#     else:
        # return render(request, 'user/create_unit.html', locals())

#刪除單位（學系、中隊）
@method_decorator(permission_check(UserType.SystemManager), name='dispatch')
class UnitDelete(View, OnlineUserStat):
    
    template_name = 'user/unit_edit.html'
    
    def get(self, request, unit_kind, unit_id):
        if unit_kind == 'department':
            obj = get_object_or_404(Department, id=unit_id)
        elif unit_kind == 'squadron':
            obj = get_object_or_404(Squadron, id=unit_id)
        else:
            messages.error(request, _("Invalid unit type."))
            return redirect('unit_list')

        obj_name = obj.name
        obj.delete()
        messages.success(request, _(f"Successfully deleted {unit_kind}: {obj_name}"))
        return redirect('unit_list')
    
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt

@method_decorator(csrf_exempt, name='dispatch')
class VerifyAdminPassword(View):
    """
    AJAX API: 驗證當前使用者是否為管理員，以及密碼是否正確
    """
    def post(self, request):
        user = request.user
        data = json.loads(request.body)
        password = data.get("password", "")

        if not user.is_authenticated or not user.is_superuser:  # 或自訂管理員判斷
            return JsonResponse({"valid": False})

        if user.check_password(password):
            return JsonResponse({"valid": True})
        else:
            return JsonResponse({"valid": False})


#編輯單位（學系、中隊）
@method_decorator(permission_check(UserType.SystemManager),name='dispatch')
@method_decorator(require_http_methods(["GET", "POST"]),name='dispatch')
class UnitEdit(View,OnlineUserStat):
   
    template_name = 'user/unit_edit.html'
   
    def do_content_works(self,request,unit_kind,unit_name):
        model = get_unit_model(unit_kind) # 根據 URL 參數取得對應模型
        if not model:
            messages.warning(request, _("Unknown unit type."))
            return redirect('unit_list')
        
        # 根據名稱取得要編輯的單位，若不存在則回傳 404
        edited_unit = get_object_or_404(model, name=unit_name)
        return {'edited_unit': edited_unit}
    
    def post(self,request,unit_kind,unit_name):
        model = get_unit_model(unit_kind) # 根據 URL 參數取得對應模型
        if not model:
            messages.warning(request, _("Unknown unit type."))
            return redirect('unit_list')
        
        # 取得目前要編輯的單位
        edited_unit = get_object_or_404(model, name=unit_name)
        
        # 透過 hidden input 來判斷是更新還是刪除
        action = request.POST.get('action', 'update')

        if action == 'delete':
            edited_unit.delete()
            messages.success(request, _("Unit deleted successfully."))
            return redirect('unit_list')

        # 從 POST 請求中取得新的名稱並去除多餘空白
        # 更新單位名稱並儲存變更
        new_name = request.POST.get('name', '').strip()

        if not new_name:
            messages.error(request, _("Unknown unit type."))
            return redirect('unit_edit', unit_kind=unit_kind, unit_name=unit_name)
        
        edited_unit.name = new_name
        edited_unit.save()

        messages.success(request, _("Update successfully."))
        return redirect('unit_list')

# @permission_check(UserType.SystemManager)
# def unit_edit(request, unit_kind, unit_name):
#     if request.method == "POST":
#         if unit_kind == 'squadron':
#             edited_unit = Squadron.objects.get(name=unit_name)
#             edited_unit.name = request.POST.get('name')
#             edited_unit.save()

#         elif unit_kind == 'department':
#             edited_unit = Department.objects.get(name=unit_name)
#             edited_unit.name = request.POST.get('name')
#             edited_unit.save()

#         messages.success(request, _("Update successfully."))
#         return redirect('unit_list')

#     else:
#         if unit_kind == 'squadron':
#             edited_unit = Squadron.objects.get(name=unit_name)

#         elif unit_kind == 'department':
#             edited_unit = Department.objects.get(name=unit_name)

#         else:
#             messages.warning(request, _("Unknown unit name."))
#             return redirect('unit_list')

#         return render(request, 'user/unit_edit.html', locals())


# 顯示單位人員
@method_decorator(permission_check(UserType.SystemManager),name='dispatch')
@method_decorator(require_http_methods(["GET"]),name='dispatch')
class UnitMemberList(View,OnlineUserStat):
   
    template_name = 'user/unit_member_list.html'
   
    def do_content_works(self,request,unit_kind,unit_name):
        model = get_unit_model(unit_kind) # 根據 URL 參數取得對應模型
        if not model:
            messages.warning(request, _(f"Unknown unit kind: {unit_kind}"))
            return redirect('unit_list')
        
        # 取得指定名稱的單位實例，若不存在則回傳 404
        viewed_unit = get_object_or_404(model, name=unit_name)
        # 取得該單位下的所有學生，依學號排序
        unit_members = viewed_unit.student_set.all().order_by('stu_id')
        
        # 回傳給模板使用
        return {
            'viewed_unit': viewed_unit,
            'unit_members':unit_members
        }


# @permission_check(UserType.SystemManager)
# def unit_member_list(request, unit_kind, unit_name):
#     if unit_kind == 'squadron':
#         try:
#             viewed_unit = Squadron.objects.get(name=unit_name)
#             unit_members = viewed_unit.student_set.all().order_by('stu_id')
#             return render(request, 'user/unit_member_list.html', locals())
#         except ObjectDoesNotExist:
#             messages.error(request, "Squadron doesn't exist, squadron name: {}".format(unit_name))
#     elif unit_kind == 'department':
#         try:
#             viewed_unit = Department.objects.get(name=unit_name)
#             unit_members = viewed_unit.student_set.all().order_by('stu_id')
#             return render(request, 'user/unit_member_list.html', locals())
#         except ObjectDoesNotExist:
#             messages.error(request, "Department doesn't exist, department name: {}".format(unit_name))
#     else:
#         messages.warning(request, "Unit kind doesn't exist, unit kind: {}".format(unit_kind))

#     return redirect('unit_list')


# 回報類別列表
@method_decorator(permission_check(UserType.SystemManager),name='get')
class ReportCategoryList(View,OnlineUserStat):
   
    template_name = 'report/report_category_list.html'
   
    def do_content_works(self,request):
        return dict(report_categories = ReportCategory.objects.all(),
                    privileges = UserType.__members__)


# @permission_check(UserType.SystemManager)
# def report_category_list(request):
#     report_categories = ReportCategory.objects.all()
#     privileges = UserType.__members__
    # return render(request, 'report/report_category_list.html', locals())


# 新增回報類別
@method_decorator(permission_check(UserType.SystemManager),name='get')
@method_decorator(permission_check(UserType.SystemManager),name='post')
class ReportCategoryCreate(View,OnlineUserStat):
   
    template_name = 'report/report_category_create.html'

    def do_content_works(self,request):
        return dict(privileges = UserType.__members__.values())
                    # categories_names = [_.name for _ in ReportCategory.objects.all()]

    def post(self,request):
        privileges = UserType.__members__.values()
        category_name = request.POST.get('category_name',)
        responsibility_value = 0
        for privilege in privileges:
            if privilege and request.POST.get('{}'.format(privilege)):
                responsibility_value |= privilege.value[0]

        try:
            new_category = ReportCategory.objects.create(name=category_name,
                                                         responsibility=responsibility_value)
            messages.success(request, 'Successfully created report category - {}.'.format(new_category))

        except IntegrityError:
            messages.error(request, "Existed category name - {}".format(category_name))
            # return redirect('report_category_list')

        return redirect('report_category_list')


# @permission_check(UserType.SystemManager)
# def report_category_create(request):
#     privileges = UserType.__members__.values()
#     if request.method == 'POST':
#         category_name = request.POST.get('category_name',)

#         responsibility_value = 0
#         for privilege in privileges:
#             if privilege and request.POST.get('{}'.format(privilege)):
#                 responsibility_value |= privilege.value[0]

#         try:
#             new_category = ReportCategory.objects.create(name=category_name,
#                                                          responsibility=responsibility_value)
#             new_category.save()
#         except IntegrityError:
#             messages.error(request, "Existed category name - {}".format(category_name))
#             return redirect('report_category_list')

#         messages.success(request, 'Successfully created report category - {}.'.format(new_category))

#         return redirect('report_category_list')
#     else:
#         categories_names = [_.name for _ in ReportCategory.objects.all()]
#         return render(request, 'report/report_category_create.html', locals())


# 回報類別內容
@method_decorator(permission_check(UserType.SystemManager),name='get')
class ReportCategoryDetail(View,OnlineUserStat):
   
    template_name = 'report/report_category_detail.html'
   
    def do_content_works(self,request,category_id):
        try:
            return dict(category = ReportCategory.objects.get(id=category_id))
   
        except ObjectDoesNotExist:
            messages.error(request, 'Report Category does not exist, report category id: {}'.format(category_id))
            return redirect('report_category_list')


# @permission_check(UserType.SystemManager)
# def report_category_detail(request, category_id):
#     try:
#         category = ReportCategory.objects.get(id=category_id)
#         return render(request, 'report/report_category_detail.html', locals())
#     except ObjectDoesNotExist:
#         messages.error(request, 'Report Category does not exist, report category id: {}'.format(category_id))
#         return redirect('report_category_list')


# 更改回報類別
@method_decorator(permission_check(UserType.SystemManager),name='get')
class ReportCategoryEdit(View,OnlineUserStat):
   
    template_name = 'report/report_category_edit.html'
   
    def do_content_works(self,request,category_id):
        try:
            return dict(category = ReportCategory.objects.get(id=category_id),
                        privileges = UserType.__members__.values())
                        # categories_names = [_.name for _ in ReportCategory.objects.all().exclude(id=category_id)])
   
        except ObjectDoesNotExist:
            messages.error(request, 'Report Category does not exist, report category id: {}'.format(category_id))
            return redirect('report_category_list')

    def post(self,request,category_id):
        privileges = UserType.__members__.values()
        category = ReportCategory.objects.get(id=category_id)
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


# @permission_check(UserType.SystemManager)
# def report_category_edit(request, category_id):
#     privileges = UserType.__members__.values()
#     try:
#         category = ReportCategory.objects.get(id=category_id)
#     except ObjectDoesNotExist:
#         messages.error(request, 'Report Category does not exist, report category id: {}'.format(category_id))
#         return redirect('report_category_list')

#     if request.method == 'POST':
#         category_name = request.POST.get('category_name')

#         responsibility_value = 0
#         for privilege in privileges:
#             if privilege and request.POST.get('{}'.format(privilege)):
#                 responsibility_value |= privilege.value[0]

#         try:
#             category.name = category_name
#             category.responsibility = responsibility_value
#             category.save()
#             messages.success(request, 'Update successfully.')
#             return redirect('report_category_list')
#         except IntegrityError:
#             messages.error(request, "Existed category name: {}".format(category_name))
#             return redirect('report_category_edit', category_id=category.id)
#     else:
#         categories_names = [_.name for _ in ReportCategory.objects.all().exclude(id=category_id)]
#         return render(request, 'report/report_category_edit.html', locals())


# 負責單位的回報列表
@method_decorator(login_required,name='get')
class ResponsibleReportList(View,FromWhere,OnlineUserStat):

    template_name = 'report/responsible_report_list.html'

    def do_content_works(self,request,responsibility):
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

        url_name = reverse('responsible_report_list',args=[responsibility])     #抓get()後的url
        FromWhere().location('ResponsibleReportList',url_name)                  #把url存進資料庫    
           
        return dict(reports=reports)


# @login_required
# def responsible_report_list(request, responsibility):
#     SM, TM, TBM = [], [], []
#     reports = []
#     for category in ReportCategory.objects.all():
#         if category.responsibility & UserType.SystemManager.value[0] > 0:
#             SM.append(category)
#         if category.responsibility & UserType.TestManager.value[0] > 0:
#             TM.append(category)
#         if category.responsibility & UserType.TBManager.value[0] > 0:
#             TBM.append(category)

#     if request.user.has_perm(UserType.SystemManager) and responsibility == 'SystemManager':
#         for category in SM:
#             reports.extend(category.report_set.all().order_by('-created_time'))
#     elif request.user.has_perm(UserType.TestManager) and responsibility == 'TestManager':
#         for category in TM:
#             reports.extend(category.report_set.all().order_by('-created_time'))
#     elif request.user.has_perm(UserType.TBManager) and responsibility == 'TBManager':
#         for category in TBM:
#             reports.extend(category.report_set.all().order_by('-created_time'))
#     else:
#         messages.success(request, 'Has no permission.')

#     return render(request, 'report/responsible_report_list.html', locals())


# 回報
@method_decorator(login_required,name='get')
class ReportCreate(View,OnlineUserStat):
   
    template_name = 'report/report.html'

    def do_content_works(self,request):
        return dict(categories = ReportCategory.objects.all())

    def post(self,request):
        try:
            category = ReportCategory.objects.get(id=int(request.POST.get('category',)))

        except ObjectDoesNotExist:
            messages.error(request, 'Category does not exist, category name: {}'.format(category))
            return dict(categories = ReportCategory.objects.all())

        #若資料庫對這欄位有 null=False，可能拋錯。加 .strip() 去除空白
        supplement_note = request.POST.get('supplement_note', '').strip()

        user_report = Report.objects.create(category=category,
                                            supplement_note=supplement_note,
                                            staff_notification=True,
                                            created_by=request.user,
                                            state=1)

        messages.success(request, _('Thanks for your advise, we will help you to solve your problem as soon as possible.'))

        return redirect('report_list')


# @login_required
# def report(request):
#     if request.method == 'POST':
#         try:
#             category = ReportCategory.objects.get(id=int(request.POST.get('category',)))

#         except ObjectDoesNotExist:
#             messages.error(request, 'Category does not exist, category name: {}'.format(category))
#             categories = ReportCategory.objects.all()
#             return render(request, 'report/report.html', locals())

#         supplement_note = request.POST.get('supplement_note')

#         user_report = Report.objects.create(category=category,
#                                             supplement_note=supplement_note,
#                                             staff_notification=True,
#                                             created_by=request.user,
#                                             state=1)

#         user_report.save()

#         messages.success(request, _('Thanks for your advise, we will help you to solve your problem as soon as possible.'))

#         return redirect('report_list')
#     else:
#         categories = ReportCategory.objects.all()
#         return render(request, 'report/report.html', locals())


# 負責單位對回報的回應
@method_decorator(login_required,name='get')
class ReportReply(View,OnlineUserStat,FromWhere):

    template_name = 'report/reply.html'
   
    def do_content_works(self, request, report_id):

        if request.user.has_perm(UserType.SystemManager):
            permission = 'SystemManager'
       
        elif request.user.has_perm(UserType.TestManager):
            permission = 'TestManager'
       
        elif request.user.has_perm(UserType.TBManager):
            permission = 'TBManager'
       
        else:
            messages.warning(request, _('Permission Denied.'))
            return redirect('Homepage')
   
        try:
            replying_report = Report.objects.get(id=report_id)
       
            if replying_report.category.responsibility & request.user.privilege == 0:
                messages.warning(request, _('This report not belongs to your permission.'))
                return redirect('responsible_report_list', responsibility=permission)
       
            elif replying_report.state == 1:
                replying_report.state = 2
                replying_report.save()
           
            else:
                pass
   
        except ObjectDoesNotExist:
            messages.error(request, "Report doesn't exist, report id: {}".format(report_id))
            return redirect('responsible_report_list', responsibility=permission)
       
        Report.objects.filter(id=report_id).update(staff_notification=False)

        replies = replying_report.reply_set.all().order_by('created_time')
   
        return dict(replying_report = replying_report, permission=permission)

   
    def post(self,request,report_id):

        replying_report = Report.objects.get(id=report_id)

        reply = request.POST.get('reply')

        new_reply = Reply.objects.create(source=replying_report, content=reply, created_by=request.user)

        proclamation_content =  (
            f"問題類別 : {replying_report.category.name}\n"
            f"問題 : {replying_report.supplement_note}\n"
            f"回覆 : {reply}\n"
            f"回覆人 : {request.user.name}")
       
        notify(title=_('Reply'),
               text=proclamation_content,
               is_read=False,
               is_public=False,
               announcer=request.user,
               exam_id=0,
               report_id=report_id,
               users=[replying_report.created_by])

        replying_report.user_notification = True
        replying_report.save()
        
        #找不到 URL，可能會導致錯誤，加預設 fallback
        back_url = FromWhere().from_where('ResponsibleReportList') or reverse('responsible_report_list', args=[permission])
         #取得ResponsibileReportList執行時的url

        return redirect(back_url)


# @login_required
# def report_reply(request, report_id):

#     if request.user.has_perm(UserType.SystemManager):
#         permission = 'SystemManager'
#         pass
#     elif request.user.has_perm(UserType.TestManager):
#         permission = 'TestManager'
#         pass
#     elif request.user.has_perm(UserType.TBManager):
#         permission = 'TBManager'
#         pass
#     else:
#         messages.warning(request, _('Permission Denied.'))
#         return redirect('Homepage')

#     try:
#         replying_report = Report.objects.get(id=report_id)

#         if replying_report.category.responsibility & request.user.privilege == 0:
#             messages.warning(request, _('This report not belongs to your permission.'))
#             return redirect('responsible_report_list', responsibility=permission)
#         elif replying_report.state == 1:
#             replying_report.state = 2
#             replying_report.save()
#     except ObjectDoesNotExist:
#         messages.error(request, "Report doesn't exist, report id: {}".format(report_id))
#         return redirect('responsible_report_list', responsibility=permission)

#     if request.method == 'POST':
#         if replying_report.state == 3:
#             messages.warning(request, _('This report had been resolved.'))
#             return redirect('responsible_report_list', responsibility=permission)

#         reply = request.POST.get('reply')
#         new_reply = Reply.objects.create(source=replying_report, content=reply, created_by=request.user)

#         proclamation_content =  "問題類別 : "+str(replying_report.category.name) +"\n"+\
#                                 "問題 : "+replying_report.supplement_note+"\n"+\
#                                 "回覆 : "+reply+"\n"+\
#                                 "回覆人 : "+request.user.name

#         notify(title=_('Reply'),
#                text=proclamation_content,
#                is_read=False,
#                is_public=False,
#                announcer=request.user,
#                exam_id=0,
#                report_id=report_id,
#                users=[replying_report.created_by])

#         replying_report.user_notification = True
#         replying_report.save()
#         return redirect('responsible_report_list', responsibility=permission)
#     else:
#         Report.objects.filter(id=report_id).update(staff_notification=False)

#         replies = replying_report.reply_set.all().order_by('created_time')
#         return render(request, 'report/reply.html', locals())


@method_decorator(permission_check(UserType.SystemManager),name='get')
class ViewReportDetail(View,OnlineUserStat):
   
    template_name = 'report/report_detail.html'
   
    def do_content_works(self,request,report_id):
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

        return dict(viewed_report = viewed_report,
                    replies = viewed_report.reply_set.all().order_by('created_time'))


# @permission_check(UserType.SystemManager)
# def view_report_detail(request, report_id):
#     try:
#         viewed_report = Report.objects.get(id=report_id)
#         if viewed_report.created_by == request.user:
#             pass
#         elif request.user.has_perm(UserType.SystemManager):
#             pass
#         else:
#             messages.warning(request, _('You have no permission'))
#             return redirect('Homepage')
#     except ObjectDoesNotExist:
#         messages.error(request, "Report doesn't exist, report id: {}".format(report_id))
#         return redirect('report_list')

#     replies = viewed_report.reply_set.all().order_by('created_time')
#     return render(request, 'report/report_detail.html', locals())


#把pass刪掉，
@login_required
def report_done(request, report_id):

    for role in ['SystemManager', 'TestManager', 'TBManager']:
        if request.user.has_perm(getattr(UserType, role)):
            permission = role
            break
    else:
        messages.warning(request, _('Permission Denied.'))
        return redirect('Homepage')

 
    replying_report = get_object_or_404(Report, id=report_id)

   
    if replying_report.category.responsibility & request.user.privilege == 0:
        messages.warning(request, _('This report not belongs to your permission.'))
        return redirect('responsible_report_list', responsibility=permission)

    
    if replying_report.state == 3:
        messages.warning(request, _('This report has already been resolved.'))
    elif replying_report.state == 2:
        replying_report.resolved_by = request.user
        replying_report.state = 3
        replying_report.user_notification = True
        replying_report.staff_notification = False
        replying_report.save()
        messages.success(request, _('This report has been resolved.'))

    return redirect('responsible_report_list', responsibility=permission)


# 系統管理員檢視使用者個人基本資料
@method_decorator(permission_check(UserType.SystemManager),name='get')
class ViewProfile(View, OnlineUserStat):
   
    template_name = 'user/view_profile.html'
   
    def do_content_works(self,request,reg_id):
        try:
            profile_user = User.objects.get(reg_id=reg_id)
            return dict(
                 profile_user=profile_user,
                privileges=UserType.__members__
            )
        except ObjectDoesNotExist:
            messages.error(request, "User doesn't exist, user id: {}".format(reg_id))
            return redirect('unit_list')


# @permission_check(UserType.SystemManager)
# def view_profile(request, reg_id):
#     try:
#         viewed_user = User.objects.get(reg_id=reg_id)
#         privileges = UserType.__members__
#         return render(request, 'user/view_profile.html', locals())
#     except ObjectDoesNotExist:
#         messages.error(request, "User doesn't exist, user id: {}".format(reg_id))
#         return redirect('unit_list')
