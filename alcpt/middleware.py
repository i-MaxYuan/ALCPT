from django.contrib import messages
from django.shortcuts import redirect

from .exceptions import BaseError


class EnglishExamSystemMiddleware:
    def process_exception(self, request, exception):
        if isinstance(exception, BaseError):
            error_msg = exception.message
            redirect_url = exception.redirect_url
        else:
            error_msg = 'Internal server error: {}'.format(repr(exception))
            redirect_url = None

        try:
            raise exception
        except Exception:
            pass

        messages.error(request, error_msg)

        return redirect(redirect_url or request.META.get('HTTP_REFERER', "/"))
