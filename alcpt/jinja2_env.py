from django.templatetags.static import static
from django.urls import reverse
from django.utils.translation import gettext

from jinja2 import Environment

from .templatetags.web_filters import *


def environment(**options):
    env = Environment(**options)
    env.globals.update({
        'static': static,
        'url': reverse,
        'trans': gettext,
    })

    # add custom filters
    filters = [
        'has_perm',
        'has_perms',
        'has_permission',
        'replace_page',
        'readable_exam_type',
        'readable_user_type',
        'readable_question_type',
        'readable_question_difficulty',
        'linebreaksbr',
        'unread_count',
        'get_TBManager_report_notification',
        'get_TestManager_report_notification',
        'get_SystemManager_report_notification',
        'range_to',
        'loop_up',
        'is_student',
        'readableIdentity',
        'student_data',
        'check_correct',
        'readable_state',
        'readable_report_state',
        'trans_int',
        'responsible_unit',
        'question_kind',
        'is_finished',
        'belongs_to',
        'summary',
        'readable_question_query_content',
        'readable_user_query_contents',
        'question_type_transfer_to_original_data',
        'get_report_notification',
        'get_SystemManager_report_notification',
        'get_TestManager_report_notification',
        'get_TBManager_report_notification',
        'isAlpha',
    ]

    for f in filters:
        env.filters.update({f: eval(f)})

    return env
