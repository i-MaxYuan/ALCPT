from django import forms


sex_combo = [
    ('0', '男'),
    ('1', '女')
]

squadron_combo = [
    ('1', '學生一中隊'),
    ('2', '學生二中隊'),
    ('3', '學生三中隊'),
    ('4', '學生四中隊'),
]

major_combo = [
    ('1', '法律學系'),
    ('2', '資訊管理學系'),
    ('3', '運籌管理謝'),
    ('4', '財務管理學系'),
]


# 登入表格
class LoginForm(forms.Form):
    account = forms.CharField(label='學號', max_length=10)
    password = forms.CharField(label='密碼', max_length=15, widget=forms.PasswordInput)


# 受測者註冊
class TesterForm(forms.Form):
    student_id = forms.CharField(label='學號', max_length=4)
    password = forms.CharField(label='密碼', max_length=20, widget=forms.PasswordInput)
    ck_password = forms.CharField(label='確認密碼', max_length=20, widget=forms.PasswordInput)
    username = forms.CharField(label='姓名', max_length=4)
    sex = forms.ChoiceField(label='性別', choices=sex_combo)
    _class = forms.CharField(label='年班', max_length=4)
    major = forms.ChoiceField(label='科系', choices=major_combo)
    squadron = forms.ChoiceField(label='中隊', choices=squadron_combo)
