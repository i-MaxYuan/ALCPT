from django.contrib.auth.decorators import login_required
from django.shortcuts import redirect
from django.http import HttpResponseRedirect
from .exceptions import PermissionWrongError
from . import registration


# Function's permission authorize user to use that function
def permission_check(required_privilege):
    def decorator(view):
        @login_required
        def check(request, *args, **kwargs):
            if not required_privilege:
                raise ValueError("Missing required_privilege")

            # 使用自訂 bit 權限檢查
            user_privilege = getattr(request.user, 'privilege', 0)
            if user_privilege & required_privilege.value[0] == 0:
                # 直接重導向到權限不足提示頁，而不是報 500
                return redirect('/')  

            # 檢查 session
            if request.COOKIES.get('sessionid') != getattr(request.user, 'browser', None):
                relogin = True
                registration.logout(request, relogin)
                return redirect('login')

            return view(request, *args, **kwargs)
        return check
    return decorator



# customized redirect
def custom_redirect(url_name, *args, **kwargs):
    from django.core.urlresolvers import reverse
    import urllib
    url = reverse(url_name, args=args)
    params = urllib.urlencode(kwargs)
    return HttpResponseRedirect(url + "?%s" % params)
