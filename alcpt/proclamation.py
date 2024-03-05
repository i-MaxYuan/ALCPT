from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage

from alcpt.decorators import permission_check, login_required
from alcpt.models import User, Proclamation
from alcpt.definitions import UserType
from django.utils.translation import gettext as _ #translation
from django.views.generic import View
from django.utils.decorators import method_decorator


@login_required
def index(request):
    notifications = Proclamation.objects.filter(recipient=request.user)
    pass


@method_decorator(permission_check(UserType.SystemManager),name='get')
# def create(request):
#     if request.method == 'POST':
#         title = request.POST.get('p_title')
#         text = request.POST.get('p_text')
#         Proclamation.objects.create(title=title, text=text, is_public=True, created_by=request.user)

#         messages.success(request, _("Create Successfully"))
#         return redirect('Homepage')
#     else:
#         return render(request, 'proclamation/proclamation_create.html', locals())
class ProclamationCreateView(View):
    def get(self, request):
        return render(request, 'proclamation/proclamation_create.html')
    
    def post(self, request):
        title = request.POST.get('p_title')
        text = request.POST.get('p_text')
        Proclamation.objects.create(title=title,  
                                    text=text,
                                    is_public=True,
                                    created_by=request.user)
        messages.success(request, _("Create Successfully"))
        return redirect('Homepage')


@method_decorator(permission_check(UserType.SystemManager),name='get')
# def edit(request, proclamation_id):
#     try:
#         proclamation = Proclamation.objects.get(id=proclamation_id)
#     except ObjectDoesNotExist:
#         messages.error(request, _("Proclamation doesn't exist, proclamation id: ")+(proclamation_id))
#         return redirect(request.META.get('HTTP_REFERER'))

#     if request.method == 'POST':
#         proclamation.title = request.POST.get('p_title')
#         proclamation.text = request.POST.get('p_text')
#         proclamation.save()
#         messages.success(request, _('Update Successfully. proclamation title - ') + proclamation.title)
#         # return redirect(request.META.get('HTTP_REFERER'))
#         return redirect('Homepage')
#     else:
#         return render(request, 'proclamation/proclamation_edit.html', locals())
class ProclamationEditView(View):
    def get(self,request,proclamation_id):
        proclamation = Proclamation.objects.get(id=proclamation_id)
        context={'proclamation':proclamation}
        return render(request, 'proclamation/proclamation_edit.html',context)
    def post(self,request,proclamation_id):
        try:
            proclamation = Proclamation.objects.get(id=proclamation_id)
        except ObjectDoesNotExist:
            messages.error(request, _("Proclamation doesn't exist, proclamation id: ")+(proclamation_id))
            return redirect(request.META.get('HTTP_REFERER'))
        proclamation.title=request.POST.get('p_title')
        proclamation.text=request.POST.get('p_text')
        proclamation.save()
        messages.success(request, _('Update Successfully. proclamation title - ') + proclamation.title)
        return redirect('Homepage')
    


def notify(title: str, text: str, is_read: bool, is_public: bool, exam_id: int, report_id: int, announcer: User, users):
    if is_public:
        Proclamation.objects.bulk_create(title=title,
                                         text=text,
                                         is_read=is_read,
                                         is_public=is_public,
                                         created_by=announcer)
    else:
        Proclamation.objects.bulk_create([Proclamation(title=title,
                                                       text=text,
                                                       is_read=is_read,
                                                       is_public=is_public,
                                                       recipient=user,
                                                       exam_id=exam_id,
                                                       report_id=report_id,
                                                       created_by=announcer) for user in users])



@method_decorator(permission_check(UserType.SystemManager),name='get')
# def delete(request, proclamation_id):
#     try:
#         proclamation = Proclamation.objects.get(id=proclamation_id)
#         if proclamation.is_public:
#             proclamation.delete()
#             messages.success(request, _("Successfully deleted"))
#         else:
#             messages.warning(request, _("Failed deleted"))
#     except ObjectDoesNotExist:
#         messages.error(request, _("Proclamation doesn't exist, proclamation id: ")+proclamation_id)
#         return redirect('Homepage')
#     return redirect('Homepage')
class ProclamationDeleteView(View):
    def get(self,request,proclamation_id):
        try:
            proclamation = Proclamation.objects.get(id=proclamation_id)
            if proclamation.is_public:
                proclamation.delete()
                messages.success(request, _("Successfully deleted"))
            else:
                messages.warning(request, _("Failed deleted"))
        except ObjectDoesNotExist:
            messages.error(request, _("Proclamation doesn't exist, proclamation id: ")+proclamation_id)
            return redirect('Homepage')
        return redirect('Homepage')


@login_required
def toggle(request, action):
    if request.method == 'POST':
        selected_proclamations = request.POST.getlist('proclamation')

        if action == 'read':
            for selected_proclamation in selected_proclamations:
                proclamation = Proclamation.objects.get(id=selected_proclamation)
                proclamation.is_read = True
                proclamation.save()
        elif action == 'delete':
            for selected_proclamation in selected_proclamations:
                Proclamation.objects.get(id=selected_proclamation).delete()
        else:
            messages.error(request, _("Failed executed"))

        return redirect(request.META.get('HTTP_REFERER'))
    else:
        return redirect(request.META.get('HTTP_REFERER'))


@method_decorator(login_required,name='get')
# def detail(request, proclamation_id):
#     try:
#         proclamation = Proclamation.objects.get(id=proclamation_id)
#         proclamation.is_read = True
#         proclamation.save()
#         time = proclamation.text.split('\n')[0][12:]
#         duration = proclamation.text.split('\n')[1][10:-9]
#         return render(request, 'proclamation/proclamation_detail.html', locals())
#     except ObjectDoesNotExist:
#         return redirect('Homepage')
class ProclamationDetailView(View):
    def get(self,request,proclamation_id):
        try:
            proclamation = Proclamation.objects.get(id=proclamation_id)
            proclamation.is_read=True
            proclamation.save()
            time = proclamation.text.split('\n')[0][12:]
            duration = proclamation.text.split('\n')[1][10:-9]
            context={'time':time,
                     'duration':duration,
                     'proclamation':proclamation}
            return render(request, 'proclamation/proclamation_detail.html',context)
        except ObjectDoesNotExist:
            return redirect('Homepage')


@method_decorator(login_required,name='get')
# def notification_center(request):
#     notifications = request.user.proclamation_set.all()

#     #   這樣寫總覺得不太對，期待後進學弟妹完善
#     if request.method == 'POST':
#         proclamations = request.POST.getlist('proclamation')
        
#         for proclamation_id in proclamations:
#             proclamation = Proclamation.objects.get(id=proclamation_id)
#             proclamation.delete()
    
#         messages.success(request, _("Successfully deleted"))
#     return render(request,'proclamation/notification_center.html',locals())
class NotificationCenterView(View):
    def get(self,request):
        notifications=request.user.proclamation_set.all()
        context={'notifications':notifications}
        return render(request,'proclamation/notification_center.html',context)   
    def post(self,request):
        proclamations=request.POST.getlist('proclamation')
        for proclamation_id in proclamations:
            proclamation = Proclamation.objects.get(id=proclamation_id)
            proclamation.delete()
        messages.success(request, _("Successfully deleted"))
        return render(request,'proclamation/notification_center.html')


@login_required
def notification_delete(request, proclamation_id):
    try:
        proclamation = Proclamation.objects.get(id=proclamation_id)
        proclamation.delete()
        messages.success(request, _("Successfully deleted"))

    except ObjectDoesNotExist:
        messages.error(request, _("Proclamation doesn't exist, proclamation id: ")+(proclamation_id))

        return redirect(request.META.get('HTTP_REFERER'))
    return redirect(request.META.get('HTTP_REFERER'))
