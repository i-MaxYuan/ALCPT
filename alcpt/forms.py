from django import forms
from django.utils.translation import gettext as _
from django.core.exceptions import ValidationError

from captcha.fields import CaptchaField


# a CAPTCHA helps protect your forms against spammers and spambots
# that are programmed to attack websites flooding them with tons of
# unwanted information by requesting that a physical code word is
# typed into the box to be matched and checked.
class CaptchaForm(forms.Form):
    captcha = CaptchaField()


def validate_excel(value):
    if value.name.split('.')[-1] not in ['xls', 'xlsx']:
        raise ValidationError(_('Invalid File Type: %(value)s'), params={'value': value},)


class UploadExcelForm(forms.Form):
    excel = forms.FileField(validators=[validate_excel])

