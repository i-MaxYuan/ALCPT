"""Online_Exam URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url, include
from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static

from alcpt import registration, system, views, exam, question, viewer, testee, group

urlpatterns = [
    url(r'^admin/', admin.site.urls),

    url(r'^$', views.index, name='Homepage'),

    url(r'^report$', system.report, name='report'),
    url(r'^report/', include([
        url(r'^list$', registration.report_list, name='report_list'),
        url(r'^(?P<report_id>[0-9]+)/detail$', registration.report_detail, name='report_detail'),
        url(r'^list/(?P<responsibility>(SystemManager|TestManager|TBManager))', system.responsible_report_list, name='responsible_report_list'),
        url(r'^reply/(?P<report_id>[0-9]+)$', system.report_reply, name='report_reply'),
        url(r'^reply/(?P<report_id>[0-9]+)/done$', system.report_done, name='report_done'),
    ])),

    url(r'^email_verification$', registration.verification, name='email_verification'),

    url(r'^captcha/', include('captcha.urls')),

    url(r'^accounts/', include([
        url(r'^login/', registration.login, name='login'),  # 登入
        url(r'^logout/', registration.logout, name='logout'),  # 登出
        url(r'^profile$', registration.profile, name='profile'),
        url(r'^edit/(?P<reg_id>[a-zA-Z0-9]+)$', registration.edit_profile, name='profile_edit'),
        url(r'^password/change$', registration.change_password, name='password_change'),
        url(r'^password/forget$', registration.forget_password, name='password_forget'),
        url(r'^password/reset$', registration.reset_password, name='password_reset'),
    ])),

    # 系統管理員部分
    url(r'^user/', include([
        url(r'^list$', system.user_list, name='user_list'),
        url(r'^create$', system.user_create, name='user_create'),
        url(r'^multiCreate$', system.user_multiCreate, name='user_multiCreate'),
        url(r'^edit/(?P<reg_id>[a-zA-Z0-9]+)$', system.user_edit, name='user_edit'),

        url(r'^unit_list/$', system.unit, name='unit_list'),
        url(r'^unit_list/', include([
            url(r'^create$', system.create_unit, name='unit_create'),
            url(r'^(?P<unit_kind>(squadron|department))/(?P<unit_name>[\w]+)$', system.unit_member_list, name='unit_member_list'),
            url(r'^check_unit_name$', system.check_unit_name, name='check_unit_name'),
        ])),

        url(r'^proclamation/', include([
            url(r'^create$', system.proclamation_create, name='proclamation_create'),
            url(r'^(?P<proclamation_id>[0-9]+)/detail$', system.proclamation_detail, name='proclamation_detail'),
            url(r'^(?P<proclamation_id>[0-9]+)/delete$', system.proclamation_delete, name='proclamation_delete'),
            url(r'^(?P<proclamation_id>[0-9]+)/edit$', system.proclamation_edit, name='proclamation_edit'),
        ])),

        url(r'^report_category/', include([
            url(r'^list$', system.report_category_list, name='report_category_list'),
            url(r'^create$', system.report_category_create, name='report_category_create'),
            url(r'^detail/(?P<category_id>[0-9]+)$', system.report_category_detail, name='report_category_detail'),
            url(r'^(?P<category_id>[0-9]+)/edit$', system.report_category_edit, name='report_category_edit'),
        ])),

        url(r'^view_profile/(?P<reg_id>[a-zA-Z0-9]+)$', system.view_profile, name='view_profile'),
    ])),

    # 考試管理員
    url(r'^exam$', exam.exam_list, name='exam_list'),
    url(r'^exam/', include([
        url(r'^create$', exam.exam_create, name='exam_create'),

        url(r'^testpaper/', include([
            url(r'^list$', exam.testpaper_list, name='testpaper_list'),
            url(r'^create$', exam.testpaper_create, name='testpaper_create'),
            url(r'^(?P<testpaper_id>[0-9]+)/content$', exam.testpaper_content, name='view_testpaper_content'),
            url(r'^(?P<testpaper_id>[0-9]+)/edit$', exam.testpaper_edit, name='testpaper_edit'),
            url(r'^(?P<testpaper_id>[0-9]+)/delete$', exam.testpaper_delete, name='testpaper_delete'),
            url(r'^(?P<testpaper_id>[0-9]+)/(?P<question_type>[0-9]+)/auto_pick', exam.auto_pick, name='auto_pick'),
            url(r'^(?P<testpaper_id>[0-9]+)/(?P<question_type>[0-9]+)/manual_pick', exam.manual_pick, name='manual_pick'),
        ])),
        url(r'^testee_group$', group.group_list, name='testee_group_list'),
        url(r'^testee_group/', include([
            url(r'^create$', group.group_create, name='testee_group_create'),
            url(r'^edit/(?P<group_id>[0-9]+)$', group.group_edit, name='testee_group_edit'),
            # url(r'delete/(?P<group_id>[0-9]+)$', group.group_delete, name='testee_group_delete'),
            url(r'^content/(?P<group_id>[0-9]+)$', group.group_content, name='testee_group_member_list'),
        ])),
    ])),

    # 題庫管理員
    url(r'^question$', question.manager_index, name='tbmanager_question_list'),
    url(r'^question/', include([
        url(r'^review$', question.review, name='question_review'),
        url(r'^(?P<question_id>[0-9]+)/pass$', question.question_pass, name='question_pass'),
        url(r'^(?P<question_id>[0-9]+)/reject$', question.question_reject, name='question_reject'),
        url(r'^(?P<question_id>[0-9]+)/edit$', question.question_edit, name='question_edit'),
    ])),

    # 題目操作員
    url(r'^operator$', question.operator_index, name='tboperator_question_list'),
    url(r'^operator/', include([
        url(r'^question_multiCreate', question.question_multiCreate, name="question_multiCreate"),
        url(r'^submit/(?P<question_id>[0-9]+)$', question.question_submit, name='question_submit'),
        url(r'^(?P<kind>(listening|reading))/question_create$', question.question_create, name='question_create'),
        url(r'^(?P<question_id>[0-9]+)/edit$', question.operator_edit, name='operator_edit'),
        url(r'^(?P<question_id>[0-9]+)/delete$', question.question_delete, name='question_delete'),
    ])),

    # 成績檢閱者
    url(r'^viewer$', viewer.index, name='exam_score_list'),
    url(r'^viewer/(?P<exam_id>[0-9]+)/detail$', viewer.exam_score_detail, name='exam_score_detail'),

    # 受測者部分
    url(r'^testee$', testee.score_list, name='testee_score_list'),  # 受測者主頁（顯示自我成績）
    url(r'^testee/', include([
        url(r'^exam/', include([
            url(r'^list$', testee.exam_list, name='testee_exam_list'),
            url(r'^start/(?P<exam_id>[0-9]+)$', testee.start_exam, name='testee_start_exam'),
            url(r'^answering/(?P<exam_id>[0-9]+)/(?P<answer_id>[0-9]+)$', testee.answering, name='testee_answering'),
        ])),

        url(r'^answer_sheet/content/(?P<answersheet_id>[0-9]+)$', testee.view_answersheet_content, name='view_answersheet_content'),

        url(r'^practice/', include([
            url(r'^(?P<kind>(listening|reading))$', testee.practice_create, name='testee_practice_create'),
        ]))
    ])),
]

urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
