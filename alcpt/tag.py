from django.shortcuts import render
from .models import word

def home(request):
    word_list = word.objects.all()
    return render(request, 'home.html', {
        'word_list': word_list,
    })