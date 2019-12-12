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

    url(r'captcha/', include('captcha.urls')),

    url(r'^exam/proclamation/(?P<proclamation_id>[0-9]+)/', include([
        url(r'^detail$', views.proclamation_detail, name='proclamation_detail'),
        url(r'^edit$', exam.edit_proclamation, name='proclamation_edit'),
        url(r'^delete$', exam.delete_proclamation, name='proclamation_delete'),
    ])),

    url(r'^login$', views.login),
    url(r'^logout$', views.logout),

    url(r'^question$', question.manager_index),
    url(r'^question/', include([
        url(r'^create$', question.create_question),
        url(r'^review$', question.review_question_index),
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

    url(r'^exam$', exam.index, name='exam_list'),
    url(r'^exam/', include([
        url(r'^proclamation$', views.index, name='proclamation_list'),
        url(r'^proclamation/', include([
            url(r'^create$', exam.create_proclamation, name='proclamation_create'),
        ])),

        url(r'^create$', exam.create_exam, name='exam_create'),
        url(r'^(?P<exam_id>[0-9]+)/', include([
            url(r'^edit$', exam.edit_exam, name='exam_edit'),
            url(r'^delete$', exam.delete_exam, name='exam_delete')
            ])),

        url(r'^testpaper$', testpaper.testpaper_index, name='testpaper_list'),
        url(r'^testpaper/', include([
            url(r'^create$', testpaper.create_testpaper, name='testpaper_create'),
            url(r'^(?P<testpaper_name>[%\w\d]+)/', include([
                url(r'^pick-question/(?P<question_type>[0-9]+)$', testpaper.pick_question, name='testpaper_pick_question'),
                url(r'^auto-pick-question/(?P<question_type>[0-9]+)$', testpaper.auto_pick_question, name='testpaper_auto_pick_question'),
                url(r'^edit$', testpaper.edit_testpaper, name='testpaper_edit'),
                url(r'^delete$', testpaper.delete_testpaper, name='testpaper_delete')
            ]))
        ])),

        url(r'^group$', group.group_index, name='testee_group_list'),
        url(r'^group/', include([
            url(r'^create$', group.create_group, name='testee_group_create'),
            url(r'^(?P<group_name>[%\w\d]+)/', include([
                url(r'^edit$', group.edit_group, name='testee_group_edit'),
                url(r'^delete$', group.delete_group, name='testee_group_delete'),
                url(r'^detail$', group.member_list, name='testee_group_detail'),
            ]))
        ]))
    ])),

    url(r'^score$', scores.index, name='all_exam_score_list'),
    url(r'^score/', include([
        url(r'^pie$', views.pie_viewer, name='score_pie'),
        url(r'^exam/(?P<exam_id>[0-9]+)$', scores.show_given_exam, name='show_given_exam'),
        url(r'^testee/(?P<user_id>[0-9]+)$', scores.show_given_testee, name='show_given_testee'),
    ])),

    url(r'^tester$', scores.tester_index, name='testee_exam_score'),
    url(r'^tester/', include([
        url(r'^pie$', views.pie, name='testee_score_pie'),
        url(r'^practice/', include([
            url(r'^score$', scores.tester_index, name='testee_practice_score'),
            url(r'^(?P<practice_type>(listening|reading))$', practice.create, name='testee_practice_selected'),
            url(r'^integration$', practice.create_integration, name='testee_practice_all'),
            url(r'^(?P<practice_id>[0-9]+)/', include([
                url(r'^take/(?P<question_index>[0-9]*)$', practice.take_practice, name='testee_practice'),
            ])),
        ])),
        url(r'^simulation-exam$', simulation_exam.index, name='testee_sim_exam_list'),
        url(r'^simulation-exam/', include([
            url(r'^(?P<exam_id>[0-9]+)/', include([
                url(r'^take/(?P<question_index>[0-9]*)$', simulation_exam.take_exam, name='testee_sim_exam_take'),
            ])),
        ])),
    ])),
    url(r'^practice/score$', scores.tester_index),


    url(r'^user$', system.index, name='user_list'),
    url(r'^user/', include([
        url(r'^create$', system.create_user, name='user_create'),
        url(r'^(?P<reg_id>[a-zA-Z0-9]+)$', system.edit_user, name='user_edit'),
        url(r'^(?P<reg_id>[a-zA-Z0-9]+)/delete$', system.delete_user, name='delete'),

        url(r'^unit_list/$', system.unit, name='unit_list'),
        url(r'^unit_list/', include([
            url(r'^create$', system.create_unit, name='unit_create'),

            url(r'^(?P<department_id>[0-9]+)/', include([
                url(r'^edit$', system.edit_department, name='department_edit'),
                url(r'^delete$', system.delete_department, name='department_delete'),
            ])),
            url(r'^(?P<squadron_name>[\w]+)/', include([
                url(r'^edit$', system.edit_squadron, name='squadron_edit'),
                url(r'^delete$', system.delete_squadron, name='squadron_delete'),
            ])),
        ]))
    ]))
]

urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)