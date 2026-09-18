from django.contrib import messages
from django.shortcuts import redirect
from django.utils.deprecation import MiddlewareMixin

from .exceptions import BaseError


class EnglishExamSystemMiddleware(MiddlewareMixin):
    MFA_SETUP_EXEMPT_PREFIXES = (
        '/static/',
        '/media/',
        '/captcha/',
        '/admin/',
    )

    MFA_SETUP_EXEMPT_NAMES = {
        'mfa_setup',
        'mfa_backup_codes',
        'logout',
    }

    def _path_without_language(self, request):
        path = request.path_info or '/'
        parts = path.split('/')
        if len(parts) > 2 and parts[1] in {'zh', 'en-us'}:
            return '/' + '/'.join(parts[2:])
        return path

    def process_request(self, request):
        user = getattr(request, 'user', None)
        if not user or not user.is_authenticated or getattr(user, 'mfa_enabled', False):
            return None

        normalized_path = self._path_without_language(request)
        if any(normalized_path.startswith(prefix) for prefix in self.MFA_SETUP_EXEMPT_PREFIXES):
            return None

        resolver_match = getattr(request, 'resolver_match', None)
        url_name = getattr(resolver_match, 'url_name', None)
        if url_name in self.MFA_SETUP_EXEMPT_NAMES:
            return None

        if normalized_path in {'/accounts/mfa/setup', '/accounts/mfa/backup-codes', '/accounts/logout/'}:
            return None

        return redirect('mfa_setup')

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
