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
from alcpt import views, exam, scores, systemmanage

urlpatterns = [
    url(r'^admin/', include(admin.site.urls)),

    url(r'^$', views.index),

    url(r'^login$', views.login),
    url(r'^logout$', views.logout),

    url(r'^exam$', exam.index),
    url(r'^exam/', include([
        url(r'^create$', exam.create_exam),
    ])),

    url(r'^score$', scores.index),
    url(r'^score/', include([
        url(r'^(?P<exam_id>[0-9]+)$', scores.sheet_detail),
    ])),

    url(r'^user$', systemmanage.index),
    url(r'^user/', include([
        url(r'^create$', systemmanage.create_user),
        url(r'^(?P<serial_number>[0-9]+)$', systemmanage.edit_user),
    ]))
]

urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)