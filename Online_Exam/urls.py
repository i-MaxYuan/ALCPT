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
from alcpt import views, question, exam, scores, system, testpaper, group, practice, simulation_exam

urlpatterns = [
    url(r'^admin/', include(admin.site.urls)),

    url(r'^$', views.index),

    url(r'^exam/proclamation/(?P<proclamation_id>[0-9]+)/', include([
        url(r'^detail$', views.proclamation_detail),
        url(r'^edit$', exam.edit_proclamation),
        url(r'^delete', exam.delete_proclamation),
    ])),

    url(r'^login$', views.login),
    url(r'^logout$', views.logout),

    url(r'^question$', question.manager_index),
    url(r'^question/', include([
        url(r'^create$', question.create_question),
        url(r'^review$', question.review_question_index),
        url(r'^review/', include([
            url(r'^(?P<question_id>[0-9]+)/', include([
                url(r'^enable$', question.enable_question),
                url(r'^unable$', question.unable_question),
            ]))
        ])),
        url(r'^(?P<question_id>[0-9]+)/', include([
            url(r'^edit$', question.edit_question),
            url(r'^delete$', question.delete_question),
        ]))
    ])),

    url(r'^question_operator$', question.operator_index),
    url(r'^question_operator/', include([
        url(r'^create$', question.operator_create_question),
        url(r'^(?P<question_id>[0-9]+)/', include([
            url(r'^edit$', question.operator_edit_question),
            url(r'^delete$', question.operator_delete_question),
        ]))
    ])),

    url(r'^exam$', exam.index),
    url(r'^exam/', include([
        url(r'^proclamation$', views.index),
        url(r'^proclamation/', include([
            url(r'^create$', exam.create_proclamation),
        ])),

        url(r'^create$', exam.create_exam),
        url(r'^(?P<exam_id>[0-9]+)/', include([
            url(r'^edit$', exam.edit_exam),
            url(r'^delete$', exam.delete_exam)
            ])),

        url(r'^testpaper$', testpaper.testpaper_index),
        url(r'^testpaper/', include([
            url(r'^create$', testpaper.create_testpaper),
            url(r'^(?P<testpaper_name>[%\w\d]+)/', include([
                url(r'^pick-question/(?P<question_type>[0-9]+)$', testpaper.pick_question),
                url(r'^auto-pick-question/(?P<question_type>[0-9]+)$', testpaper.auto_pick_question),
                url(r'^edit$', testpaper.edit_testpaper),
                url(r'^delete$', testpaper.delete_testpaper)
            ]))
        ])),

        url(r'^group$', group.group_index),
        url(r'^group/', include([
            url(r'^create$', group.create_group),
            url(r'^(?P<group_name>[%\w\d]+)/', include([
                url(r'^edit$', group.edit_group),
                url(r'^delete$', group.delete_group)
            ]))
        ]))
    ])),

    url(r'^score$', scores.index),
    url(r'^score/', include([
        url(r'^(?P<exam_id>[0-9]+)$', scores.sheet_detail),
    ])),

    url(r'^tester$', scores.tester_index),
    url(r'^tester/', include([
        url(r'^practice/', include([
            url(r'^(?P<practice_type>(listening|reading))$', practice.create),
            url(r'^integration$', practice.create_integration),
            url(r'^(?P<practice_id>[0-9]+)/', include([
                url(r'^take/(?P<question_index>[0-9]*)$', practice.take_practice),
            ])),
        ])),
        url(r'^simulation-exam$', simulation_exam.index),
        url(r'^simulation-exam/', include([
            url(r'^(?P<exam_id>[0-9]+)/', include([
                url(r'^take/(?P<question_index>[0-9]*)$', simulation_exam.take_exam),
            ])),
        ])),
    ])),



    url(r'^user$', system.index),
    url(r'^user/', include([
        url(r'^create$', system.create_user),
        url(r'^(?P<serial_number>[a-zA-Z0-9]+)$', system.edit_user),
        url(r'^(?P<serial_number>[a-zA-Z0-9]+)/delete', system.delete_user),

        # 單位刪除跟編輯 還沒好
        url(r'^unit_list/$', system.unit),
        url(r'^unit_list/', include([
            # url(r'^(?P<department_name>[\w]+)/edit', system.edit_unit),
            # url(r'^(?P<squadron_name>[\w]+)/edit', system.edit_unit),
            url(r'^insert$', system.insert_unit),
            # url(r'^(?P<department_name>[\w]+)/delete', system.delete_unit),
            # url(r'^(?P<squadron_name>[\w]+)/delete', system.delete_unit),
        ]))
    ]))
]

urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)