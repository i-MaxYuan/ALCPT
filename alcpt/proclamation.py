from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage

from alcpt.decorators import permission_check, login_required
from alcpt.models import User, Proclamation
from alcpt.definitions import UserType
from django.utils.translation import gettext as _ #translation


@login_required
def index(request):
    notifications = Proclamation.objects.filter(recipient=request.user)
    pass


@permission_check(UserType.SystemManager)
def create(request):
    if request.method == 'POST':
        title = request.POST.get('p_title')
        text = request.POST.get('p_text')
        Proclamation.objects.create(title=title, text=text, is_public=True, created_by=request.user)

        messages.success(request, _("Create Successfully"))
        return redirect('Homepage')
    else:
        return render(request, 'proclamation/proclamation_create.html', locals())


@permission_check(UserType.SystemManager)
def edit(request, proclamation_id):
    try:
        proclamation = Proclamation.objects.get(id=proclamation_id)
    except ObjectDoesNotExist:
        messages.error(request, _("Proclamation doesn't exist, proclamation id: ")+(proclamation_id))
        return redirect(request.META.get('HTTP_REFERER'))

    if request.method == 'POST':
        proclamation.title = request.POST.get('p_title')
        proclamation.text = request.POST.get('p_text')
        proclamation.save()
        messages.success(request, _('Update Successfully. proclamation title - ') + proclamation.title)
        return redirect(request.META.get('HTTP_REFERER'))
    else:
        return render(request, 'proclamation/proclamation_edit.html', locals())


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


@permission_check(UserType.SystemManager)
def delete(request, proclamation_id):
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


@login_required
def detail(request, proclamation_id):
    try:
        proclamation = Proclamation.objects.get(id=proclamation_id)
        proclamation.is_read = True
        proclamation.save()
        return render(request, 'proclamation/proclamation_detail.html', locals())
    except ObjectDoesNotExist:
        return redirect('Homepage')


@login_required
def notification_center(request):
    notifications = request.user.proclamation_set.all()

    return render(request,'proclamation/notification_center.html',locals())

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
