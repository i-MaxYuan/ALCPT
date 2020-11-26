
from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.core.exceptions import ObjectDoesNotExist
from django.views.decorators.http import require_http_methods

from .models import Achievement
from .decorators import permission_check
from .definitions import UserType


@permission_check(UserType.SystemManager)
def achievement_list(request):
    achievements = Achievement.objects.all()
    return render(request, 'achievement/achievement_list.html', locals())

@permission_check(UserType.SystemManager)
def achievement_create(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        badge = request.FILES.get('badge')
        point = request.POST.get('point')
        definition = request.POST.get('definition')
        created_by = request.user


        achievement = Achievement.objects.create(name=name, badge=badge, point=point, definition=definition, created_by=created_by)
        achievement.save()
        messages.success(request, 'Successfully created.')
        return redirect('achievement_list')
    else:
        return render(request, 'achievement/achievement_create.html', locals())
