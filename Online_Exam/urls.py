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
from django.views.generic import RedirectView
from django.conf.urls import url, include
from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from django.urls import path, re_path

from django.conf.urls.i18n import i18n_patterns # traslation

from alcpt import registration, system, views, exam, question, viewer, testee, group, proclamation

# ^ means beginning of the line, $ means end of the line
urlpatterns = [
    re_path(r'^favicon.ico$', RedirectView.as_view(url=r'static/favicon.ico')), 
    re_path(r'^admin/', admin.site.urls),
    re_path(r'^$', views.About.as_view(), name='about'), #首頁
    re_path(r'^1$', views.about1, name='about1'),
    # re_path(
    #     r'^/',
    #     include([
    #         re_path(r'^download_system_pdf$',
    #                 views.downloadSystemPDF,
    #                 name='Download_system_pdf'),
    #         re_path(r'^download_OM_pdf$',
    #                 views.downloadOperationManual,
    #                 name='Download_OM_pdf'),
    #     ])),
    re_path(r'^download_system_pdf$',
            views.downloadSystemPDF,
            name='Download_system_pdf'),

    re_path(r'^download_system_pdf111$',
            views.downloadSystemPDF111,
            name='Download_system_pdf111'),

    re_path(r'^download_system_pdf112$',
            views.downloadSystemPDF112,
            name='Download_system_pdf112'),

    re_path(r'^download_OM_pdf$',
            views.downloadOperationManual,
            name='Download_OM_pdf'),

    re_path(
        r'^about/',
        include([
            re_path(r'^project_history',
                    views.ProjectHistory.as_view(),
                # views.project_history,
                name='project_history'),
            re_path(r'^SystemManager',
                    views.about_SystemManager,
                    name='about_SystemManager'),
            re_path(r'^TestManager',
                    views.about_TestManager,
                    name='about_TestManager'),
            re_path(r'^TBManager',
                    views.about_TBManager,
                    name='about_TBManager'),
            re_path(r'^TBOperator',
                    views.about_TBOperator,
                    name='about_TBOperator'),
            re_path(r'^Viewer', views.about_Viewer, name='about_Viewer'),
            re_path(r'^Testee', views.about_Testee, name='about_Testee'),
            re_path(r'^developer',
                    views.about_developer,
                    name='about_developer'),
        ])),
    
    # 系統使用手冊
    re_path(
        r'operation_manual/', 
        include([
            re_path(r'^System$', views.OM_System, name='OM_System'),
            re_path(r'^Report$', views.OM_Report, name='OM_Report'),
            re_path(r'^User$', views.OM_User, name='OM_User'),
            re_path(r'^Sidebar$', views.OM_Sidebar, name='OM_Sidebar'),
            re_path(r'^SystemManager$',
                    views.OM_SystemManager,
                    name='OM_SystemManager'),
            re_path(r'^TestManager$',
                    views.OM_TestManager,
                    name='OM_TestManager'),
            re_path(r'^TBManager$', views.OM_TBManager, name='OM_TBManager'),
            re_path(r'^TBOperator$', views.OM_TBOperator,
                    name='OM_TBOperator'),
            re_path(r'^Viewer$', views.OM_Viewer, name='OM_Viewer'),
            re_path(r'^Testee$', views.OM_Testee, name='OM_Testee'),
        ])),
    
    # 問題回報
    re_path(r'^report$', system.ReportCreate.as_view(), name='report'), 
    re_path(
        r'^report/',
        include([
            re_path(r'^(?P<question_id>[0-9]+)$',
                    testee.report_question,
                    name='report_question'),
            re_path(r'^list$', registration.ReportList.as_view(), name='report_list'),
            re_path(r'^(?P<report_id>[0-9]+)/detail$',
                    registration.ReportDetail.as_view(),
                #     registration.report_detail,
                    name='report_detail'),
            re_path(r'^(?P<report_id>[0-9]+)/view$',
                    system.ViewReportDetail.as_view(),
                #     system.view_report_detail,
                    name='view_report_detail'),
            re_path(
                r'^list/(?P<responsibility>(SystemManager|TestManager|TBManager))',
                system.ResponsibleReportList.as_view(),
                # system.responsible_report_list,
                name='responsible_report_list'),
            re_path(r'^reply/(?P<report_id>[0-9]+)$',
                    system.ReportReply.as_view(),
                #     system.report_reply,
                    name='report_reply'),
            re_path(r'^(?P<report_id>[0-9]+)/done$',
                    system.report_done,
                    name='report_done'),
        ])),

    # 公告設定
    re_path(r'^proclamation$', views.index, name='Homepage'),
    re_path(
        r'^proclamation/',
        include([
            re_path(r'^create$',
                    proclamation.create,
                    name='proclamation_create'),
            re_path(r'^(?P<proclamation_id>[0-9]+)/detail$',
                    proclamation.detail,
                    name='proclamation_detail'),
            re_path(r'^(?P<proclamation_id>[0-9]+)/delete$',
                    proclamation.delete,
                    name='proclamation_delete'),
            re_path(r'^(?P<proclamation_id>[0-9]+)/edit$',
                    proclamation.edit,
                    name='proclamation_edit'),
            re_path(r'^(?P<action>(read|delete))/toggle$',
                    proclamation.toggle,
                    name='proclamation_toggle'),
            re_path(r'^notification_center$',
                    proclamation.notification_center,
                    name='notification_center'),
            re_path(r'^(?P<proclamation_id>[0-9]+)/notification_delete$',
                    proclamation.notification_delete,
                    name='notification_delete'),
        ])),

    re_path(r'^email_verification$',
            registration.verification,
            name='email_verification'),
    re_path(
        r'^email_verification_done/(?P<encode_email>[\w\=\!\@\#\$\%\^\&\*\(\)\s]+)',
        registration.verify_done,
        name='verify_done'),
    re_path(r'^captcha/', include('captcha.urls')),

    # 使用者帳號設定
    re_path(
        r'^accounts/', 
        include([
            re_path(r'^login/', registration.Login.as_view(), name='login'),
            re_path(r'^logout/', registration.logout, name='logout'),
            re_path(r'^profile$', registration.Profile.as_view(), name='profile'),
            re_path(r'^edit$', registration.EditProfile.as_view(), name='profile_edit'),
            re_path(r'^password/change$',
                    registration.ChangePassword.as_view(),
                #     registration.change_password,
                    name='password_change'),
            re_path(r'^password/forget$',
                    registration.forget_password,
                    name='password_forget'),
            re_path(
                r'^password/reset/(?P<encode_reg_id>[\w\=\!\@\#\$\%\^\&\*\(\)\s]+)',
                registration.reset_password,
                name='password_reset'),
            re_path(r'^email$', registration.email, name='email'),
        ])),

    # 系統管理員部分
    re_path(
        r'^user/',
        include([
            re_path(r'^list$', system.UserList.as_view(), name='user_list'),
            re_path(r'^create$', system.UserCreate.as_view(), name='user_create'),
            re_path(r'^multiCreate$',
                    system.UserMultiCreate.as_view(),
                #     system.user_multiCreate,
                    name='user_multiCreate'),
            re_path(r'^edit/(?P<reg_id>[a-zA-Z0-9]+)$',
                    system.UserEdit.as_view(),
                #     system.user_edit,
                    name='user_edit'),
            re_path(r'^unit_list/$', system.Unit.as_view(), name='unit_list'),
            re_path(
                r'^unit_list/',
                include([
                    re_path(r'^create$',
                            system.CreateUnit.as_view(),
                        #     system.create_unit,
                            name='unit_create'),
                    re_path(
                        r'^(?P<unit_kind>(squadron|department))/(?P<unit_name>[\w]+)$',
                        system.UnitMemberList.as_view(),
                        # system.unit_member_list,
                        name='unit_member_list'),
                    # url(r'^check_unit_name$', system.check_unit_name, name='check_unit_name'),
                    re_path(
                        r'^(?P<unit_kind>(squadron|department))/(?P<unit_name>[\w]+)/edit$',
                        system.UnitEdit.as_view(),
                        # system.unit_edit,
                        name='unit_edit'),
                ])),
            re_path(
                r'^report_category/',
                include([
                    re_path(r'^list$',
                            system.ReportCategoryList.as_view(),
                        #     system.report_category_list,
                            name='report_category_list'),
                    re_path(r'^create$',
                            system.ReportCategoryCreate.as_view(),
                        #     system.report_category_create,
                            name='report_category_create'),
                    re_path(r'^detail/(?P<category_id>[0-9]+)$',
                            system.ReportCategoryDetail.as_view(),
                        #     system.report_category_detail,
                            name='report_category_detail'),
                    re_path(r'^(?P<category_id>[0-9]+)/edit$',
                            system.ReportCategoryEdit.as_view(),
                        #     system.report_category_edit,
                            name='report_category_edit'),
                ])),
            re_path(r'^view_profile/(?P<reg_id>[a-zA-Z0-9]+)$',
                    system.ViewProfile.as_view(),
                #     system.view_profile,
                    name='view_profile'),
            re_path(r'^achievement$', system.AchievementList.as_view(),
                    name='achievement_list'),
            re_path(
                r'^achievement/',
                include([
                    re_path(r'^create$',
                            system.AchievementCreate.as_view(),
                        #     system.achievement_create,
                            name='achievement_create'),
                ])),
        ])),

    # 考試管理員
    re_path(r'^exam$', exam.ExamList.as_view(), name='exam_list'),
    re_path(
        r'^exam/',
        include([
            re_path(r'^create$', exam.ExamCreate.as_view(), name='exam_create'),
            re_path(r'^(?P<exam_id>[0-9]+)/content$',
                    exam.exam_content,
                    name='exam_content'),
            re_path(r'^(?P<exam_id>[0-9]+)/edit$',
                    exam.exam_edit,
                    name='exam_edit'),
            re_path(r'^(?P<exam_id>[0-9]+)/delete$',
                    exam.exam_delete,
                    name='exam_delete'),
            re_path(
                r'^testpaper/',
                include([
                    re_path(r'^list$',
                            exam.testpaper_list,
                            name='testpaper_list'),
                    re_path(r'^create$',
                            exam.testpaper_create,
                            name='testpaper_create'),
                    re_path(r'^(?P<testpaper_id>[0-9]+)/content$',
                            exam.testpaper_content,
                            name='view_testpaper_content'),
                    re_path(r'^(?P<testpaper_id>[0-9]+)/valid$',
                            exam.testpaper_valid,
                            name='testpaper_valid'),
                    re_path(r'^(?P<testpaper_id>[0-9]+)/unvalid$',
                            exam.testpaper_unvalid,
                            name='testpaper_unvalid'),
                    re_path(r'^(?P<testpaper_id>[0-9]+)/edit$',
                            exam.testpaper_edit,
                            name='testpaper_edit'),
                    re_path(r'^(?P<testpaper_id>[0-9]+)/delete$',
                            exam.testpaper_delete,
                            name='testpaper_delete'),
                    re_path(
                        r'^(?P<testpaper_id>[0-9]+)/(?P<question_type>[0-9]+)/(?P<difficulty>[0-9]+)/auto_pick',
                        exam.auto_pick,
                        name='auto_pick'),
                    re_path(
                        r'^(?P<testpaper_id>[0-9]+)/(?P<question_type>[0-9]+)/manual_pick',
                        exam.manual_pick,
                        name='manual_pick'),
                    re_path(
                        r'^(?P<testpaper_id>[0-9]+)/(?P<question_type>[0-9]+)/reset_pick',
                        exam.reset_pick,
                        name='reset_pick'),
                ])),
            re_path(r'^testee_group$',
                    group.GroupList.as_view(),
                #     group.group_list,
                    name='testee_group_list'),
            re_path(
                r'^testee_group/',
                include([
                    url(r'^create$',
                        group.GroupCreate.as_view(),
                        # group.group_create,
                        name='testee_group_create'),
                    re_path(r'^(?P<group_id>[0-9]+)/edit$',
                            group.GroupEdit.as_view(),
                        #     group.group_edit,
                            name='testee_group_edit'),
                    re_path(r'^(?P<group_id>[0-9]+)/delete$',
                            group.group_delete,
                            name='testee_group_delete'),
                    re_path(r'^(?P<group_id>[0-9]+)/content$',
                            group.GroupContent.as_view(),
                        #     group.group_content,
                            name='testee_group_member_list'),
                ])),
        ])),

    # 題庫管理員
    re_path(r'^question$',
            question.ManagerIndex.as_view(),
        #     question.manager_index,
            name='tbmanager_question_list'),
    re_path(
        r'^question/',
        include([
            re_path(r'^review$', question.Review.as_view(), name='question_review'),
            re_path(r'^(?P<question_id>[0-9]+)/pass$',
                    question.question_pass,
                    name='question_pass'),
            re_path(r'^(?P<question_id>[0-9]+)/reject$',
                    question.QuestionReject.as_view(),
                #     question.question_reject,
                    name='question_reject'),
            re_path(r'^(?P<question_id>[0-9]+)/edit$',
                    question.QuestionEdit.as_view(),
                #     question.question_edit,
                    name='question_edit'),
        ])),

    # 題目操作員
    re_path(r'^operator$',
            question.OperatorIndex.as_view(),
        #     question.operator_index,
            name='tboperator_question_list'),
    re_path(
        r'^operator/',
        include([
            re_path(r'^question_multiCreate',
                    question.QuestionMultiCreate.as_view(),
                #     question.question_multiCreate,
                    name="question_multiCreate"),
            re_path(r'^submit/(?P<question_id>[0-9]+)$',
                    question.question_submit,
                    name='question_submit'),
            re_path(r'^(?P<kind>(listening|reading))/question_create$',
                    question.QuestionCreate.as_view(),
                #     question.question_create,
                    name='question_create'),
            re_path(r'^(?P<question_id>[0-9]+)/edit$',
                    question.OperatorEdit.as_view(),
                #     question.operator_edit,
                    name='operator_edit'),
            re_path(r'^(?P<question_id>[0-9]+)/delete$',
                    question.question_delete,
                    name='question_delete'),
        ])),

    # 成績檢閱者
    re_path(r'^viewer$', viewer.index, name='exam_score_list'),
    re_path(
        r'^viewer/',
        include([
            re_path(r'^(?P<exam_id>[0-9]+)/detail$',
                    viewer.exam_score_detail,
                    name='exam_score_detail'),
            re_path(
                r'^(?P<exam_id>[0-9]+)/detail/(?P<reg_id>[a-zA-Z0-9]+)/info$',
                viewer.view_testee_info,
                name='view_testee_info'),
        ])),

    # 受測者部分
    re_path(r'^testee$', testee.score_list,
            name='testee_score_list'),  # 受測者主頁（顯示自我成績）
    re_path(
        r'^testee/',
        include([
            re_path(
                r'^exam/',
                include([
                    re_path(r'^pending/(?P<exam_id>[0-9]+)$',
                            testee.pending,
                            name='pending'),
                    re_path(r'^list$',
                            testee.exam_list,
                            name='testee_exam_list'),
                    re_path(r'^favorite_question_list$',
                            testee.favorite_question_list,
                            name='favorite_question_list'),
                    re_path(
                        r'^favorite_question_delete/(?P<question_id>[0-9]+)$',
                        testee.favorite_question_delete,
                        name='favorite_question_delete'),
                    re_path(r'^start_exam/(?P<exam_id>[0-9]+)$',
                            testee.start_exam,
                            name='testee_start_exam'),
                    re_path(r'^start_practice/(?P<exam_id>[0-9]+)$',
                            testee.start_practice,
                            name='testee_start_practice'),
                    re_path(
                        r'^favorite_question/(?P<question_id>[0-9]+)/(?P<answersheet_id>[0-9]+)$',
                        testee.favorite_question,
                        name='favorite_question'),
                    re_path(
                        r'^answering/(?P<exam_id>[0-9]+)/(?P<answer_id>[0-9]+)$',
                        testee.answering,
                        name='testee_answering'),
                    re_path(
                        r'^submit_answersheet/(?P<exam_id>[0-9]+)$',
                        testee.submit_answersheet,
                        name='submit_answersheet'),
                    re_path(r'^(?P<exam_id>[0-9]+)/settle$',
                            testee.settle,
                            name='testee_settle_exam'),
                ])),
            re_path(r'^answer_sheet/content/(?P<answersheet_id>[0-9]+)$',
                    testee.view_answersheet_content,
                    name='view_answersheet_content'),
            re_path(r'^leaderboard$',
                    testee.leaderboard,
                    name='leaderboard'),
            re_path(r'^achievement_list$',
                    testee.achievement_list,
                    name='testee_achievement_list'),

            re_path(r'^achievement/create/(?P<achievement_id>[0-9]+)/(?P<achievement_category>[0-9]+)$',
                    testee.accept_achievement,
                    name='accept_achievement'),
            re_path(
                r'^practice/',
                include([
                    re_path(r'^(?P<kind>(listening|reading))$',
                            testee.practice_create,
                            name='testee_practice_create'),
                ])),
        ])),
]

urlpatterns += i18n_patterns(
re_path(r'^favicon.ico$', RedirectView.as_view(url=r'static/favicon.ico')),
re_path(r'^$', views.About.as_view(), name='about'),
re_path(r'^1$', views.about1, name='about1'),
# re_path(
#     r'^/',
#     include([
#         re_path(r'^download_system_pdf$',
#                 views.downloadSystemPDF,
#                 name='Download_system_pdf'),
#         re_path(r'^download_OM_pdf$',
#                 views.downloadOperationManual,
#                 name='Download_OM_pdf'),
#     ])),
re_path(
    r'^about/',
    include([
        re_path(r'^project_history',
                views.ProjectHistory.as_view(),
        #     views.project_history,
            name='project_history'),
        re_path(r'^SystemManager',
                views.about_SystemManager,
                name='about_SystemManager'),
        re_path(r'^TestManager',
                views.about_TestManager,
                name='about_TestManager'),
        re_path(r'^TBManager',
                views.about_TBManager,
                name='about_TBManager'),
        re_path(r'^TBOperator',
                views.about_TBOperator,
                name='about_TBOperator'),
        re_path(r'^Viewer', views.about_Viewer, name='about_Viewer'),
        re_path(r'^Testee', views.about_Testee, name='about_Testee'),
        re_path(r'^developer',
                views.about_developer,
                name='about_developer'),
    ])),


re_path(
    r'^operation_manual/',
    include([
        re_path(r'^System$', views.OM_System, name='OM_System'),
        re_path(r'^Report$', views.OM_Report, name='OM_Report'),
        re_path(r'^User$', views.OM_User, name='OM_User'),
        re_path(r'^Sidebar$', views.OM_Sidebar, name='OM_Sidebar'),
        re_path(r'^SystemManager$',
                views.OM_SystemManager,
                name='OM_SystemManager'),
        re_path(r'^TestManager$',
                views.OM_TestManager,
                name='OM_TestManager'),
        re_path(r'^TBManager$', views.OM_TBManager, name='OM_TBManager'),
        re_path(r'^TBOperator$', views.OM_TBOperator,
                name='OM_TBOperator'),
        re_path(r'^Viewer$', views.OM_Viewer, name='OM_Viewer'),
        re_path(r'^Testee$', views.OM_Testee, name='OM_Testee'),
    ])),
re_path(r'^report$', system.ReportCreate.as_view(), name='report'),
re_path(
    r'^report/',
    include([
        re_path(r'^(?P<question_id>[0-9]+)$',
                testee.report_question,
                name='report_question'),
        re_path(r'^list$', registration.ReportList.as_view(), name='report_list'),
        re_path(r'^(?P<report_id>[0-9]+)/detail$',
                registration.ReportDetail.as_view(),
                # registration.report_detail,
                name='report_detail'),
        re_path(r'^(?P<report_id>[0-9]+)/view$',
                system.ViewReportDetail.as_view(),
                # system.view_report_detail,
                name='view_report_detail'),
        re_path(
            r'^list/(?P<responsibility>(SystemManager|TestManager|TBManager))',
            system.ResponsibleReportList.as_view(),
        #     system.responsible_report_list,
            name='responsible_report_list'),
        re_path(r'^reply/(?P<report_id>[0-9]+)$',
                system.ReportReply.as_view(),
                # system.report_reply,
                name='report_reply'),
        re_path(r'^(?P<report_id>[0-9]+)/done$',
                system.report_done,
                name='report_done'),
    ])),
re_path(r'^proclamation$', views.index, name='Homepage'),
re_path(
    r'^proclamation/',
    include([
        re_path(r'^create$',
                proclamation.create,
                name='proclamation_create'),
        re_path(r'^(?P<proclamation_id>[0-9]+)/detail$',
                proclamation.detail,
                name='proclamation_detail'),
        re_path(r'^(?P<proclamation_id>[0-9]+)/delete$',
                proclamation.delete,
                name='proclamation_delete'),
        re_path(r'^(?P<proclamation_id>[0-9]+)/edit$',
                proclamation.edit,
                name='proclamation_edit'),
        re_path(r'^(?P<action>(read|delete))/toggle$',
                proclamation.toggle,
                name='proclamation_toggle'),
        re_path(r'^notification_center$',
                proclamation.notification_center,
                name='notification_center'),
        re_path(r'^(?P<proclamation_id>[0-9]+)/notification_delete$',
                proclamation.notification_delete,
                name='notification_delete'),
    ])),

re_path(r'^email_verification$',
        registration.verification,
        name='email_verification'),
re_path(
    r'^email_verification_done/(?P<encode_email>[\w\=\!\@\#\$\%\^\&\*\(\)\s]+)',
    registration.verify_done,
    name='verify_done'),
re_path(r'^captcha/', include('captcha.urls')),
re_path(
    r'^accounts/',
    include([
        re_path(r'^login/', registration.Login.as_view(), name='login'),
        re_path(r'^logout/', registration.logout, name='logout'),
        re_path(r'^profile$', registration.Profile.as_view(), name='profile'),
        re_path(r'^edit$', registration.EditProfile.as_view(), name='profile_edit'),
        re_path(r'^password/change$',
                registration.ChangePassword.as_view(),
                # registration.change_password,
                name='password_change'),
        re_path(r'^password/forget$',
                registration.forget_password,
                name='password_forget'),
        re_path(
            r'^password/reset/(?P<encode_reg_id>[\w\=\!\@\#\$\%\^\&\*\(\)\s]+)',
            registration.reset_password,
            name='password_reset'),
        re_path(r'^email$', registration.email, name='email'),
    ])),

# 系統管理員部分
re_path(
    r'^user/',
    include([
        re_path(r'^list$', system.UserList.as_view(), name='user_list'),
        re_path(r'^create$', system.UserCreate.as_view(), name='user_create'),
        re_path(r'^multiCreate$',
                system.UserMultiCreate.as_view(),
                # system.user_multiCreate,
                name='user_multiCreate'),
        re_path(r'^edit/(?P<reg_id>[a-zA-Z0-9]+)$',
                system.UserEdit.as_view(),
                # system.user_edit,
                name='user_edit'),
        re_path(r'^delete/(?P<reg_id>[a-zA-Z0-9]+)$',
                system.user_del,
                name='user_del'),
        re_path(r'^unit_list/$', system.Unit.as_view(), name='unit_list'),
        re_path(
            r'^unit_list/',
            include([
                re_path(r'^create$',
                        system.CreateUnit.as_view(),
                        # system.create_unit,
                        name='unit_create'),
                re_path(
                    r'^(?P<unit_kind>(squadron|department))/(?P<unit_name>[\w]+)$',
                    system.UnitMemberList.as_view(),
                #     system.unit_member_list,
                    name='unit_member_list'),
                # url(r'^check_unit_name$', system.check_unit_name, name='check_unit_name'),
                re_path(
                    r'^(?P<unit_kind>(squadron|department))/(?P<unit_name>[\w]+)/edit$',
                    system.UnitEdit.as_view(),
                #     system.unit_edit,
                    name='unit_edit'),
            ])),
        re_path(
            r'^report_category/',
            include([
                re_path(r'^list$',
                        system.ReportCategoryList.as_view(),
                        # system.report_category_list,
                        name='report_category_list'),
                re_path(r'^create$',
                        system.ReportCategoryCreate.as_view(),
                        # system.report_category_create,
                        name='report_category_create'),
                re_path(r'^detail/(?P<category_id>[0-9]+)$',
                        system.ReportCategoryDetail.as_view(),
                        # system.report_category_detail,
                        name='report_category_detail'),
                re_path(r'^(?P<category_id>[0-9]+)/edit$',
                        system.ReportCategoryEdit.as_view(),
                        # system.report_category_edit,
                        name='report_category_edit'),
            ])),
        re_path(r'^view_profile/(?P<reg_id>[a-zA-Z0-9]+)$',
                system.ViewProfile.as_view(),
                # system.view_profile,
                name='view_profile'),
        re_path(r'^achievement$', system.AchievementList.as_view(),
                name='achievement_list'),
        re_path(
            r'^achievement/',
            include([
                re_path(r'^create$',
                        system.AchievementCreate.as_view(),
                        # system.achievement_create,
                        name='achievement_create'),
            ])),
    ])),

# 考試管理員
re_path(r'^exam$', exam.ExamList.as_view(), name='exam_list'),
re_path(
    r'^exam/',
    include([
        re_path(r'^create$', exam.ExamCreate.as_view(), name='exam_create'),
        re_path(r'^(?P<exam_id>[0-9]+)/content$',
                exam.exam_content,
                name='exam_content'),
        re_path(r'^(?P<exam_id>[0-9]+)/edit$',
                exam.exam_edit,
                name='exam_edit'),
        re_path(r'^(?P<exam_id>[0-9]+)/delete$',
                exam.exam_delete,
                name='exam_delete'),
        re_path(
            r'^testpaper/',
            include([
                re_path(r'^list$',
                        exam.testpaper_list,
                        name='testpaper_list'),
                re_path(r'^create$',
                        exam.testpaper_create,
                        name='testpaper_create'),
                re_path(r'^(?P<testpaper_id>[0-9]+)/content$',
                        exam.testpaper_content,
                        name='view_testpaper_content'),
                re_path(r'^(?P<testpaper_id>[0-9]+)/valid$',
                        exam.testpaper_valid,
                        name='testpaper_valid'),
                re_path(r'^(?P<testpaper_id>[0-9]+)/unvalid$',
                        exam.testpaper_unvalid,
                        name='testpaper_unvalid'),
                re_path(r'^(?P<testpaper_id>[0-9]+)/edit$',
                        exam.testpaper_edit,
                        name='testpaper_edit'),
                re_path(r'^(?P<testpaper_id>[0-9]+)/delete$',
                        exam.testpaper_delete,
                        name='testpaper_delete'),
                re_path(
                    r'^(?P<testpaper_id>[0-9]+)/(?P<question_type>[0-9]+)/(?P<difficulty>[0-9]+)/auto_pick',
                    exam.auto_pick,
                    name='auto_pick'),
                re_path(
                    r'^(?P<testpaper_id>[0-9]+)/(?P<question_type>[0-9]+)/manual_pick',
                    exam.manual_pick,
                    name='manual_pick'),
                re_path(
                    r'^(?P<testpaper_id>[0-9]+)/(?P<question_type>[0-9]+)/reset_pick',
                    exam.reset_pick,
                    name='reset_pick'),
            ])),
        re_path(r'^testee_group$',
                group.GroupList.as_view(),
                # group.group_list,
                name='testee_group_list'),
        re_path(
            r'^testee_group/',
            include([
                url(r'^create$',
                    group.GroupCreate.as_view(),
                #     group.group_create,
                    name='testee_group_create'),
                re_path(r'^(?P<group_id>[0-9]+)/edit$',
                        group.GroupEdit.as_view(),
                        # group.group_edit,
                        name='testee_group_edit'),
                re_path(r'^(?P<group_id>[0-9]+)/delete$',
                        group.group_delete,
                        name='testee_group_delete'),
                re_path(r'^(?P<group_id>[0-9]+)/content$',
                        group.GroupContent.as_view(),
                        # group.group_content,
                        name='testee_group_member_list'),
            ])),
    ])),

# 題庫管理員
re_path(r'^question$',
        question.ManagerIndex.as_view(),
        # question.manager_index,
        name='tbmanager_question_list'),
re_path(
    r'^question/',
    include([
        re_path(r'^review$', question.Review.as_view(), name='question_review'),
        re_path(r'^(?P<question_id>[0-9]+)/pass$',
                question.question_pass,
                name='question_pass'),
        re_path(r'^(?P<question_id>[0-9]+)/reject$',
                question.QuestionReject.as_view(),
                # question.question_reject,
                name='question_reject'),
        re_path(r'^(?P<question_id>[0-9]+)/edit$',
                question.QuestionEdit.as_view(),
                # question.question_edit,
                name='question_edit'),
    ])),

# 題目操作員
re_path(r'^operator$',
        question.OperatorIndex.as_view(),
        # question.operator_index,
        name='tboperator_question_list'),
re_path(
    r'^operator/',
    include([
        re_path(r'^question_multiCreate',
                question.QuestionMultiCreate.as_view(),
                # question.question_multiCreate,
                name="question_multiCreate"),
        re_path(r'^submit/(?P<question_id>[0-9]+)$',
                question.question_submit,
                name='question_submit'),
        re_path(r'^(?P<kind>(listening|reading))/question_create$',
                question.QuestionCreate.as_view(),
                # question.question_create,
                name='question_create'),
        re_path(r'^(?P<question_id>[0-9]+)/edit$',
                question.OperatorEdit.as_view(),
                # question.operator_edit,
                name='operator_edit'),
        re_path(r'^(?P<question_id>[0-9]+)/delete$',
                question.question_delete,
                name='question_delete'),
    ])),

# 成績檢閱者
re_path(r'^viewer$', viewer.index, name='exam_score_list'),
re_path(
    r'^viewer/',
    include([
        re_path(r'^(?P<exam_id>[0-9]+)/detail$',
                viewer.exam_score_detail,
                name='exam_score_detail'),
        re_path(
            r'^(?P<exam_id>[0-9]+)/detail/(?P<reg_id>[a-zA-Z0-9]+)/info$',
            viewer.view_testee_info,
            name='view_testee_info'),
    ])),

# 受測者部分
re_path(r'^testee$', testee.score_list,
        name='testee_score_list'),  # 受測者主頁（顯示自我成績）
re_path(
    r'^testee/',
    include([
        re_path(
            r'^exam/',
            include([
                re_path(r'^pending/(?P<exam_id>[0-9]+)$',
                        testee.pending,
                        name='pending'),
                re_path(r'^list$',
                        testee.exam_list,
                        name='testee_exam_list'),
                re_path(r'^favorite_question_list$',
                        testee.favorite_question_list,
                        name='favorite_question_list'),
                re_path(
                    r'^favorite_question_delete/(?P<question_id>[0-9]+)$',
                    testee.favorite_question_delete,
                    name='favorite_question_delete'),
                re_path(r'^start_exam/(?P<exam_id>[0-9]+)$',
                        testee.start_exam,
                        name='testee_start_exam'),
                re_path(r'^start_practice/(?P<exam_id>[0-9]+)$',
                        testee.start_practice,
                        name='testee_start_practice'),
                re_path(
                    r'^favorite_question/(?P<question_id>[0-9]+)/(?P<answersheet_id>[0-9]+)$',
                    testee.favorite_question,
                    name='favorite_question'),
                re_path(
                    r'^answering/(?P<exam_id>[0-9]+)/(?P<answer_id>[0-9]+)$',
                    testee.answering,
                    name='testee_answering'),
                re_path(
                    r'^submit_answersheet/(?P<exam_id>[0-9]+)$',
                    testee.submit_answersheet,
                    name='submit_answersheet'),
                re_path(r'^(?P<exam_id>[0-9]+)/settle$',
                        testee.settle,
                        name='testee_settle_exam'),
            ])),
        re_path(r'^answer_sheet/content/(?P<answersheet_id>[0-9]+)$',
                testee.view_answersheet_content,
                name='view_answersheet_content'),
        re_path(r'^leaderboard$',
                testee.leaderboard,
                name='leaderboard'),
        re_path(r'^achievement_list$',
                testee.achievement_list,
                name='testee_achievement_list'),

        re_path(r'^achievement/create/(?P<achievement_id>[0-9]+)/(?P<achievement_category>[0-9]+)$',
                testee.accept_achievement,
                name='accept_achievement'),
        re_path(
            r'^practice/',
            include([
                re_path(r'^(?P<kind>(listening|reading))$',
                        testee.practice_create,
                        name='testee_practice_create'),
            ])),
        re_path(r'^forum$',
                testee.forum,
                name="forum"),
        re_path(r'^forum_question/(?P<question_id>[0-9]+)/(?P<answersheet_id>[0-9]+)$',
                testee.forum_question,
                name="forum_question"),
        re_path(r'^forum_question_add/(?P<question_id>[0-9]+)/(?P<answersheet_id>[0-9]+)$',
                testee.forum_question_add,
                name='forum_question_add'),
        re_path(r'^forum_comment_add/(?P<question_id>[0-9]+)$',
                testee.forum_comment_add,
                name='forum_comment_add'),
        re_path(r'^forum_comment_delete/(?P<forum_comment_id>[0-9]+)$',
                testee.forum_comment_delete,
                name='forum_comment_delete'),
        re_path(r'^answersheet_comment_delete/(?P<forum_comment_id>[0-9]+)/(?P<answersheet_id>[0-9]+)$',
                testee.answersheet_comment_delete,
                name='answersheet_comment_delete'),
        re_path(r'^word_library$',
                testee.word_library,
                name='word_library'),
        re_path(r'^word_library_create$',
                testee.word_library_create,
                name='word_library_create'),
        path('word_library_del/<str:words>',
                testee.word_library_del,
                name='word_library_del'),


        path('word_library_edit/<str:words>/<str:translations>',
                testee.word_library_edit,
                name='word_library_edit'),
        

                
    ])),
)

urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
