"""Online_Exam URL Configurationｒ

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.8/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import include, url
from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from alcpt import views, question, exam, scores, system

urlpatterns = [
    url(r'^admin/', include(admin.site.urls)),

    url(r'^$', views.index),

    url(r'^login$', views.login),
    url(r'^logout$', views.logout),

    url(r'^question$', question.index),
    url(r'^question/', include([
        url(r'^create$', question.create_question),
        url(r'^review$', question.review_question_index),
        url(r'^(?P<question_id>[0-9]+)/', include([
            url(r'^edit$', question.edit_question),
            url(r'^delete$', question.delete_question),
        ]))
    ])),

    url(r'^exam$', exam.index),
    url(r'^exam/', include([
        url(r'^create$', exam.create_exam),
    ])),

    url(r'^score$', scores.index),
    url(r'^score/', include([
        url(r'^(?P<exam_id>[0-9]+)$', scores.sheet_detail),
    ])),

    url(r'^user$', system.index),
    url(r'^user/', include([
        url(r'^create$', system.create_user),
        url(r'^(?P<serial_number>[0-9]+)$', system.edit_user),
    ]))
]

urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)