from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect
from .exceptions import PermissionWrongError


# Function's permission authorize user to use that function
def permission_check(required_privilege):
    def decorator(view):
        @login_required
        def check(request, *args, **kwargs):
            if not required_privilege:
                raise ValueError("Loss argument 'required_privilege'")

            if not request.user.has_perm(required_privilege):
                raise PermissionWrongError()

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
