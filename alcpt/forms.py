from django import forms
from django.utils.translation import gettext as _
from django.core.exceptions import ValidationError
from .models import Exam
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


class DateTimeInput(forms.DateTimeInput):
    input_type = "datetime-local"

    def __init__(self, **kwargs):
        kwargs["format"] = "%Y-%m-%dT%H:%M"
        super().__init__(**kwargs)


class ExhibitionForm(forms.ModelForm):
    class Meta:
        model = Exam
        fields = "__all__"

        def __init__(self, *args, **kwargs):
            super().__init__(*args, **kwargs)
            self.fields["started_time"].widget = DateTimeInput()
            self.fields["started_time"].input_formats = ["%Y-%m-%dT%H:%M", "%Y-%m-%d %H:%M"]