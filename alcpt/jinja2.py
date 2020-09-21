from django.templatetags.static import static
from django.urls import reverse

from jinja2 import Environment

from .templatetags.web_filters import *


def environment(**options):
    env = Environment(**options)
    env.globals.update({
        'static': static,
        'url': reverse,
    })

    # custom filters
    env.filters["has_perm"] = has_perm
    env.filters["linebreaksbr"] = linebreaksbr
    env.filters["unread_count"] = unread_count
    env.filters[
        "get_TBManager_report_notification"] = get_TBManager_report_notification
    env.filters[
        "get_TestManager_report_notification"] = get_TestManager_report_notification
    env.filters[
        "get_SystemManager_report_notification"] = get_SystemManager_report_notification

    return env
