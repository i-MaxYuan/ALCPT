from django.shortcuts import render

from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage

from .definitions import UserType
from .models import Proclamation

# Create your views here.


def index(request):
    privileges = UserType.__members__,
    proclamations = Proclamation.objects.filter(is_public=True)
    page = request.GET.get('page', 1)
    paginator = Paginator(proclamations, 5)  # the second parameter is used to display how many items. Now is display 5

    try:
        pros = paginator.page(page)
    except PageNotAnInteger:
        pros = paginator.page(1)
    except EmptyPage:
        pros = paginator.page(paginator.num_pages)

    return render(request, 'index.html', locals())
