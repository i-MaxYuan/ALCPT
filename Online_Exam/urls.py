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
from django.urls import path, re_path

from alcpt import registration, system, views, exam, question, viewer, testee, group, proclamation

urlpatterns = [
    re_path(r'^admin/', admin.site.urls),

    re_path(r'^$', views.about, name='about'),
    re_path(r'^/', include([
        re_path(r'^download_system_pdf$', views.downloadSystemPDF, name='download_system_pdf'),
        re_path(r'^download_OM_pdf$', views.downloadOperationManual, name='download_OM_pdf'),
    ])),

    re_path(r'^about/', include([
        re_path(r'^SystemManager', views.about_SystemManager, name='about_SystemManager'),
        re_path(r'^TestManager', views.about_TestManager, name='about_TestManager'),
        re_path(r'^TBManager', views.about_TBManager, name='about_TBManager'),
        re_path(r'^TBOperator', views.about_TBOperator, name='about_TBOperator'),
        re_path(r'^Viewer', views.about_Viewer, name='about_Viewer'),
        re_path(r'^Testee', views.about_Testee, name='about_Testee'),
        re_path(r'^developer', views.about_developer, name='about_developer'),
    ])),

    re_path(r'operation_manual/', include([
        re_path(r'^System$', views.OM_System, name='OM_System'),
        re_path(r'^Report$', views.OM_Report, name='OM_Report'),
        re_path(r'^User$', views.OM_User, name='OM_User'),
        re_path(r'^SystemManager$', views.OM_SystemManager, name='OM_SystemManager'),
        re_path(r'^TestManager$', views.OM_TestManager, name='OM_TestManager'),
        re_path(r'^TBManager$', views.OM_TBManager, name='OM_TBManager'),
        re_path(r'^TBOperator$', views.OM_TBOperator, name='OM_TBOperator'),
        re_path(r'^Viewer$', views.OM_Viewer, name='OM_Viewer'),
        re_path(r'^Testee$', views.OM_Testee, name='OM_Testee'),
    ])),

    re_path(r'^report$', system.report, name='report'),
    re_path(r'^report/', include([
        re_path(r'^(?P<question_id>[0-9]+)$', testee.report_question, name='report_question'),
        re_path(r'^list$', registration.report_list, name='report_list'),
        re_path(r'^(?P<report_id>[0-9]+)/detail$', registration.report_detail, name='report_detail'),
        re_path(r'^(?P<report_id>[0-9]+)/view$', system.view_report_detail, name='view_report_detail'),
        re_path(r'^list/(?P<responsibility>(SystemManager|TestManager|TBManager))', system.responsible_report_list, name='responsible_report_list'),
        re_path(r'^reply/(?P<report_id>[0-9]+)$', system.report_reply, name='report_reply'),
        re_path(r'^(?P<report_id>[0-9]+)/done$', system.report_done, name='report_done'),
    ])),

    re_path(r'^proclamation$', views.index, name='Homepage'),
    re_path(r'^proclamation/', include([
        re_path(r'^create$', proclamation.create, name='proclamation_create'),
        re_path(r'^(?P<proclamation_id>[0-9]+)/detail$', proclamation.detail, name='proclamation_detail'),
        re_path(r'^(?P<proclamation_id>[0-9]+)/delete$', proclamation.delete, name='proclamation_delete'),
        re_path(r'^(?P<proclamation_id>[0-9]+)/edit$', proclamation.edit, name='proclamation_edit'),
        re_path(r'^(?P<action>(read|delete))/toggle$', proclamation.toggle, name='proclamation_toggle'),
    ])),

    re_path(r'^notification$', proclamation.index, name='notification_center'),

    re_path(r'^email_verification$', registration.verification, name='email_verification'),
    re_path(r'^email_verification_done/(?P<encode_email>[\w\=\!\@\#\$\%\^\&\*\(\)\s]+)', registration.verify_done, name='verify_done'),

    re_path(r'^captcha/', include('captcha.urls')),

    re_path(r'^accounts/', include([
        re_path(r'^login/', registration.login, name='login'),
        re_path(r'^logout/', registration.logout, name='logout'),
        re_path(r'^profile$', registration.profile, name='profile'),
        re_path(r'^edit$', registration.edit_profile, name='profile_edit'),
        re_path(r'^password/change$', registration.change_password, name='password_change'),
        re_path(r'^password/forget$', registration.forget_password, name='password_forget'),
        re_path(r'^password/reset/(?P<encode_reg_id>[\w\=\!\@\#\$\%\^\&\*\(\)\s]+)', registration.reset_password, name='password_reset'),
        re_path(r'^email$', registration.email, name='email'),
    ])),

    # 系統管理員部分
    re_path(r'^user/', include([
        re_path(r'^list$', system.user_list, name='user_list'),
        re_path(r'^create$', system.user_create, name='user_create'),
        re_path(r'^multiCreate$', system.user_multiCreate, name='user_multiCreate'),
        re_path(r'^edit/(?P<reg_id>[a-zA-Z0-9]+)$', system.user_edit, name='user_edit'),

        re_path(r'^unit_list/$', system.unit, name='unit_list'),
        re_path(r'^unit_list/', include([
            re_path(r'^create$', system.create_unit, name='unit_create'),
            re_path(r'^(?P<unit_kind>(squadron|department))/(?P<unit_name>[\w]+)$', system.unit_member_list, name='unit_member_list'),
            # url(r'^check_unit_name$', system.check_unit_name, name='check_unit_name'),
            re_path(r'^(?P<unit_kind>(squadron|department))/(?P<unit_name>[\w]+)/edit$', system.unit_edit, name='unit_edit'),
        ])),

        re_path(r'^report_category/', include([
            re_path(r'^list$', system.report_category_list, name='report_category_list'),
            re_path(r'^create$', system.report_category_create, name='report_category_create'),
            re_path(r'^detail/(?P<category_id>[0-9]+)$', system.report_category_detail, name='report_category_detail'),
            re_path(r'^(?P<category_id>[0-9]+)/edit$', system.report_category_edit, name='report_category_edit'),
        ])),

        re_path(r'^view_profile/(?P<reg_id>[a-zA-Z0-9]+)$', system.view_profile, name='view_profile'),
    ])),

    # 考試管理員
    re_path(r'^exam$', exam.exam_list, name='exam_list'),
    re_path(r'^exam/', include([
        re_path(r'^create$', exam.exam_create, name='exam_create'),
        re_path(r'^(?P<exam_id>[0-9]+)/content$', exam.exam_content, name='exam_content'),
        re_path(r'^(?P<exam_id>[0-9]+)/edit$', exam.exam_edit, name='exam_edit'),
        re_path(r'^(?P<exam_id>[0-9]+)/delete$', exam.exam_delete, name='exam_delete'),

        re_path(r'^testpaper/', include([
            re_path(r'^list$', exam.testpaper_list, name='testpaper_list'),
            re_path(r'^create$', exam.testpaper_create, name='testpaper_create'),
            re_path(r'^(?P<testpaper_id>[0-9]+)/content$', exam.testpaper_content, name='view_testpaper_content'),
            re_path(r'^(?P<testpaper_id>[0-9]+)/edit$', exam.testpaper_edit, name='testpaper_edit'),
            re_path(r'^(?P<testpaper_id>[0-9]+)/delete$', exam.testpaper_delete, name='testpaper_delete'),
            re_path(r'^(?P<testpaper_id>[0-9]+)/(?P<question_type>[0-9]+)/auto_pick', exam.auto_pick, name='auto_pick'),
            re_path(r'^(?P<testpaper_id>[0-9]+)/(?P<question_type>[0-9]+)/manual_pick', exam.manual_pick, name='manual_pick'),
        ])),
        re_path(r'^testee_group$', group.group_list, name='testee_group_list'),
        re_path(r'^testee_group/', include([
            url(r'^create$', group.group_create, name='testee_group_create'),
            re_path(r'^(?P<group_id>[0-9]+)/edit$', group.group_edit, name='testee_group_edit'),
            re_path(r'^(?P<group_id>[0-9]+)/delete$', group.group_delete, name='testee_group_delete'),
            re_path(r'^(?P<group_id>[0-9]+)/content$', group.group_content, name='testee_group_member_list'),
        ])),
    ])),

    # 題庫管理員
    re_path(r'^question$', question.manager_index, name='tbmanager_question_list'),
    re_path(r'^question/', include([
        re_path(r'^review$', question.review, name='question_review'),
        re_path(r'^(?P<question_id>[0-9]+)/pass$', question.question_pass, name='question_pass'),
        re_path(r'^(?P<question_id>[0-9]+)/reject$', question.question_reject, name='question_reject'),
        re_path(r'^(?P<question_id>[0-9]+)/edit$', question.question_edit, name='question_edit'),
    ])),

    # 題目操作員
    re_path(r'^operator$', question.operator_index, name='tboperator_question_list'),
    re_path(r'^operator/', include([
        re_path(r'^question_multiCreate', question.question_multiCreate, name="question_multiCreate"),
        re_path(r'^submit/(?P<question_id>[0-9]+)$', question.question_submit, name='question_submit'),
        re_path(r'^(?P<kind>(listening|reading))/question_create$', question.question_create, name='question_create'),
        re_path(r'^(?P<question_id>[0-9]+)/edit$', question.operator_edit, name='operator_edit'),
        re_path(r'^(?P<question_id>[0-9]+)/delete$', question.question_delete, name='question_delete'),
    ])),

    # 成績檢閱者
    re_path(r'^viewer$', viewer.index, name='exam_score_list'),
    re_path(r'^viewer/', include([
        re_path(r'^(?P<exam_id>[0-9]+)/detail$', viewer.exam_score_detail, name='exam_score_detail'),
        re_path(r'^(?P<exam_id>[0-9]+)/detail/(?P<reg_id>[a-zA-Z0-9]+)/info$', viewer.view_testee_info, name='view_testee_info'),
    ])),

    # 受測者部分
    re_path(r'^testee$', testee.score_list, name='testee_score_list'),  # 受測者主頁（顯示自我成績）
    re_path(r'^testee/', include([
        re_path(r'^exam/', include([
            re_path(r'^list$', testee.exam_list, name='testee_exam_list'),
            re_path(r'^start/(?P<exam_id>[0-9]+)$', testee.start_exam, name='testee_start_exam'),
            re_path(r'^answering/(?P<exam_id>[0-9]+)/(?P<answer_id>[0-9]+)$', testee.answering, name='testee_answering'),
            re_path(r'^(?P<exam_id>[0-9]+)/settle$', testee.settle, name='testee_settle_exam'),
        ])),

        re_path(r'^answer_sheet/content/(?P<answersheet_id>[0-9]+)$', testee.view_answersheet_content, name='view_answersheet_content'),

        re_path(r'^practice/', include([
            re_path(r'^(?P<kind>(listening|reading))$', testee.practice_create, name='testee_practice_create'),
        ]))
    ])),
]

urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
