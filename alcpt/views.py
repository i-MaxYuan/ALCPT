from django.shortcuts import render
from django.http import FileResponse
from django.utils.translation import gettext as _ #translation
import datetime


from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage

from .definitions import Identity
from .models import Proclamation, User, Exam, AnswerSheet, OnlineStatus, LocationUrl

from django.views.generic import View

from django.utils import timezone
from django.db.models.functions import Coalesce
import datetime

# Create your views here.

class FromWhere:

    def location(self,class_name,url_name):         #儲存當下url

        if LocationUrl.objects.filter(url_name=url_name).exists():    #如果url_name已存在資料庫,不做任何動作
            pass

        elif LocationUrl.objects.filter(from_class=class_name).exists():
            now_location = LocationUrl.objects.get(from_class=class_name)
            now_location.url_name = url_name
            now_location.save()

        else:
            LocationUrl.objects.create(from_class=class_name,url_name=url_name)

        return url_name
 

    def from_where(self,class_name):            #取得指定class執行時的url

        location_url = LocationUrl.objects.get(from_class=class_name)

        return location_url.url_name


class OnlineUserStat:
    template_name = ''
 
    def get(self, request, *args, **kwargs):
    # 基本統計
        online_num = OnlineStatus.objects.filter(online_status=True).count()
        reg_num = User.objects.count()  # 用 count() 比 len(QuerySet) 更有效率

        contents = {
            'reg_num': reg_num,
            'online_num': online_num
        }

    # 取得額外內容
        contents_dict = self.do_content_works(request, *args, **kwargs)

    # 保證 contents_dict 是 dict，如果不是就轉為空 dict
        if not isinstance(contents_dict, dict):
            try:
                contents_dict = dict(contents_dict)
            except (TypeError, ValueError):
                contents_dict = {}

    # 更新 contents
        contents.update(contents_dict)

        return render(request, self.template_name, contents)


class RegOnlineList(View,OnlineUserStat):
    
    template_name = 'user/reg_online_list.html'
    
    def do_content_works(self,request):
        reg = User.objects.all().order_by('id')
        status = OnlineStatus.objects.all().order_by('user_id')
        reg_list = list(zip(reg,status)) 
        
        page = request.GET.get('page', 1)
        paginator = Paginator(reg_list, 10)
        try:
            regList = paginator.page(page)
        except PageNotAnInteger:
            regList = paginator.page(1)
        except EmptyPage:
            regList = paginator.page(paginator.num_pages)
            
        return {'reg_list':reg_list, 'regList':regList, 'paginator':paginator}

      

class ProclamationCenter(View,OnlineUserStat):
    
    template_name='proclamation/proclamation.html'
    
    def do_content_works(self,request):
        privileges = Identity.__members__
        proclamations = Proclamation.objects.filter(is_public=True)

        now_time = datetime.datetime.now()

        exam = Exam.objects.all().filter(exam_type=1).order_by('-id')

        if exam:
            latest_exam = exam[0]
            leaderboard = AnswerSheet.objects.all().filter(exam_id=latest_exam.id).order_by("-score")

        page = request.GET.get('page', 1)
        paginator = Paginator(proclamations, 10)  # the second parameter is used to display how many items. Now is display 5

        try:
            pros = paginator.page(page)
        except PageNotAnInteger:
            pros = paginator.page(1)
        except EmptyPage:
            pros = paginator.page(paginator.num_pages)
        return dict(pros=pros,paginator=paginator)


def about(request):
    return render(request, 'SystemDocument/About.html', locals())
class About(View,OnlineUserStat): 

    template_name = 'SystemDocument/About.html'
    
    def do_content_works(self,request): #not do anything
        return {}

class ProjectHistory(View,OnlineUserStat):
    template_name = 'SystemDocument/about/project_history.html'
    
    def do_content_works(self,request):
        return {}

# def project_history(request):
#     return render(request, 'SystemDocument/about/project_history.html', locals())

# Email 設定頁面
from django.contrib import messages
from django.shortcuts import redirect
from django.middleware.csrf import get_token


class EmailSettingView(View):
    template_name = "registration/email_setting.html"

    def get(self, request):
        return render(request, self.template_name, {
            "current_email": request.user.email,
            "csrf_token": get_token(request),
            "_": _,  # 傳入模板，模板就可以用 _() 翻譯
        })

    def post(self, request):
        # 延遲 import 避免循環引用
        from alcpt.email import email_verified

        new_email = request.POST.get("new_email", "").strip()
        user = request.user

        if not new_email:
            messages.error(request, _("Email cannot be empty."))
            return redirect("email_setting")

        if new_email == user.email:
            messages.warning(request, _("You entered the same email as before."))
            return redirect("email_setting")

        # 更新使用者信箱，標記為未驗證
        user.email = new_email
        user.email_is_verified = False
        user.save()

        try:
            email_verified(user, new_email, request.user)
            messages.success(request, _("Verification email sent to ") + new_email)
        except Exception as e:
            messages.error(request, _("Failed to send email: ") + str(e))

        return redirect("email_setting")

def about1(request):
    users = list(User.objects.all())

        # To search top 5 the most practices testees
    answer_sheet_nums = [testee.answersheet_set.count() for testee in users]
    answer_sheetData = zip(users, answer_sheet_nums)
    answer_sheetData = list(answer_sheetData)
    sorted_Data = sorted(answer_sheetData, key=lambda x: x[1], reverse=True)[:5]

        # To search top 5 the highest average score testees
    total_scores = []
    for testee in users:
        tmp = 0
        if testee.answersheet_set.all() is None:
            total_scores.append(0)
            break
        else:
            for answer_sheet in testee.answersheet_set.all():
                if answer_sheet.score is None:
                    pass
                else:
                    tmp += answer_sheet.score
            total_scores.append(tmp)

    average_scoreData = zip(users, total_scores)
    average_scoreData = list(average_scoreData)
    average_score_sortedData = sorted(average_scoreData, key=lambda x: x[1], reverse=True)[:5]

    return render(request, 'SystemDocument/About1.html', locals())

def downloadSystemPDF(request):
    file = open('./static/document/project.pdf', 'rb')  # path have to start from root
    response = FileResponse(file)
    response['Content-Type'] = 'application/octet-stream'
    response['Content-Disposition'] = 'attachment;filename="project.pdf"'
    return response

def downloadSystemPDF111(request):
    file = open('./static/document/project111.pdf', 'rb')  # path have to start from root
    response = FileResponse(file)
    response['Content-Type'] = 'application/octet-stream'
    response['Content-Disposition'] = 'attachment;filename="project111.pdf"'
    return response


def downloadSystemPDF112(request):
    file = open('./static/document/project112.pdf', 'rb')  # path have to start from root
    response = FileResponse(file)
    response['Content-Type'] = 'application/octet-stream'
    response['Content-Disposition'] = 'attachment;filename="project112.pdf"'
    return response


def downloadSystemPDF113(request):
    file = open('./static/document/project113.pdf', 'rb')  # path have to start from root
    response = FileResponse(file)
    response['Content-Type'] = 'application/octet-stream'
    response['Content-Disposition'] = 'attachment;filename="project113.pdf"'
    return response


def downloadOperationManual(request):
    file = open('./static/document/ALCPT-Operation-Manual.pdf', 'rb')  # path have to start from root
    response = FileResponse(file)
    response['Content-Type'] = 'application/octet-stream'
    response['Content-Disposition'] = 'attachment;filename="ALCPT-Operation-Manual.pdf"'
    return response


def about_developer(request):
    return render(request, 'SystemDocument/about/developer.html')


def about_SystemManager(request):
    return render(request, 'SystemDocument/about/About_SystemManager.html')


def about_TestManager(request):
    return render(request, 'SystemDocument/about/About_TestManager.html')


def about_TBManager(request):
    return render(request, 'SystemDocument/about/About_TBManager.html')


def about_TBOperator(request):
    return render(request, 'SystemDocument/about/About_TBOperator.html')


def about_Viewer(request):
    return render(request, 'SystemDocument/about/About_Viewer.html')


def about_Testee(request):
    return render(request, 'SystemDocument/about/About_Testee.html')


def OM_System(request):
    return render(request, 'SystemDocument/OperationManual/OM_System.html')


def OM_Report(request):
    return render(request, 'SystemDocument/OperationManual/OM_Report.html')


def OM_User(request):
    return render(request, 'SystemDocument/OperationManual/OM_User.html')

def OM_Sidebar(request):
    return render(request, 'SystemDocument/OperationManual/OM_Sidebar.html')


def OM_SystemManager(request):
    return render(request, 'SystemDocument/OperationManual/OM_SystemManager.html')


def OM_TestManager(request):
    return render(request, 'SystemDocument/OperationManual/OM_TestManager.html')


def OM_TBManager(request):
    return render(request, 'SystemDocument/OperationManual/OM_TBManager.html')


def OM_TBOperator(request):
    return render(request, 'SystemDocument/OperationManual/OM_TBOperator.html')


def OM_Viewer(request):
    return render(request, 'SystemDocument/OperationManual/OM_Viewer.html')


def OM_Testee(request):
    return render(request, 'SystemDocument/OperationManual/OM_Testee.html')



    

