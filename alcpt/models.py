import time, datetime, json

from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager

from alcpt.definitions import UserType


class UserManager(BaseUserManager):
    def create_user(self, reg_id, privilege, password=None):
        """
        Creates and saves a user with the given serial number.
        """

        user = self.model(
            reg_id=reg_id,
            privilege=privilege
        )

        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(self, reg_id, password):
        """
        Creates and saves a superuser with the given serial number, password.
        """

        user = self.model(
            reg_id=reg_id,
        )
        user.set_password(password)
        user.is_admin = True
        user.save(using=self._db)

        return user


# 使用者
# red_id: user's registration id
# privilege: different roles have different privilege
# created_time: user's registration time
# update_time: user update its profile time
class User(AbstractBaseUser):
    reg_id = models.CharField(max_length=50, unique=True)
    email = models.EmailField(blank=True, null=True)
    email_is_verified = models.BooleanField(default=False)
    name = models.CharField(max_length=20, blank=True, null=True)
    gender = models.PositiveSmallIntegerField(blank=True, null=True)
    TESTEE_PREVILEGE = 1
    privilege = models.PositiveSmallIntegerField(default=TESTEE_PREVILEGE)     # 1 => Testee
    created_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)
    IDENTITY_CHOICES = (
        (0, '訪客'),
        (1, '學生'),
        (2, '老師'),
    )
    identity = models.PositiveSmallIntegerField(null=True, default=0)

    objects = UserManager()

    USERNAME_FIELD = 'reg_id'

    def get_short_name(self):
        return self.name

    def get_full_name(self):
        return self.name

    def has_perm(self, require_privilege: UserType):
        # if require_privilege is UserType.SystemManager:
        #     return self.privilege & UserType.SystemManager.value[0]
        #
        # else:
        #     return (self.privilege & require_privilege.value[0]) > 0
        return (self.privilege & require_privilege.value[0]) > 0


# 學系
# department is ordered by id
class Department(models.Model):
    name = models.CharField(max_length=10, unique=True)

    class Meta:
        ordering = ('id',)

    def __str__(self):
        return self.name


# 中隊
# squadron is ordered by id
class Squadron(models.Model):
    name = models.CharField(max_length=10, unique=True)

    class Meta:
        ordering = ('id',)

    def __str__(self):
        return self.name


# 學生
# stu_id: student's registration id
# user: student is related to the user
# department: user's department
# grade: user's grade
# squadron: user's squadron
class Student(models.Model):
    stu_id = models.CharField(max_length=10, unique=True)
    user = models.OneToOneField("User", on_delete=models.CASCADE)
    department = models.ForeignKey("Department", on_delete=models.PROTECT, blank=True, null=True)
    grade = models.PositiveSmallIntegerField(default=time.localtime().tm_year - 1911)
    squadron = models.ForeignKey("Squadron", on_delete=models.PROTECT, blank=True, null=True)

    def get_ID(self):
        return self.stu_id


# 試卷
# is_testpaper: 0 = False = practice; 1 = True = testpaper
# valid: True = testpaper is valid and can be used; False is the opposite
class TestPaper(models.Model):
    name = models.CharField(max_length=100, unique=True)
    created_time = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey("User", on_delete=models.PROTECT, related_name='testee_created')
    is_testpaper = models.BooleanField(default=False)
    is_used = models.BooleanField(default=False)
    update_time = models.DateTimeField(auto_now=True)
    valid = models.BooleanField(default=False)

    def __str__(self):
        return self.name


# 測驗
# exam_type: types of the exam be defined in alcpt/definitions.py
# testpaper: testpaper be used in this exam
# group: the group for the exam
# use_freq: How often this exam is used
# start_time: start time od this exam
# duration: duration of this exam
# finish_time: finish time od this exam
# is_public: if value is False the exam can't be used; True is the opposite
class Exam(models.Model):
    name = models.CharField(max_length=100, unique=True)
    exam_type = models.PositiveSmallIntegerField(default=2)
    testpaper = models.ForeignKey('TestPaper', on_delete=models.CASCADE, null=True)
    use_freq = models.IntegerField(default=0)
    modified_times = models.IntegerField(default=0)
    average_score = models.FloatField(default=0)     # 資料庫我有加一欄，不影響可以不用刪掉
    start_time = models.DateTimeField(blank=True, null=True)
    created_time = models.DateTimeField(auto_now_add=True)
    duration = models.PositiveSmallIntegerField(default=0)
    created_by = models.ForeignKey('User', on_delete=models.PROTECT, related_name='exam_created')
    finish_time = models.DateTimeField(blank=True, null=True)
    is_public = models.BooleanField(default=False)

    class Meta:
        ordering = ('-created_time',)

    def __str__(self):
        return self.name

    @property
    def correct_rate(self):
        return self.modified_times / self.use_freq * 100


# 題目
# q_type: type of the question be defined in alcpt/definitions.py
# q_file: question path of the english listening
# q_content: content of the question
# difficulty: difficulty of the question
# issued_freq: frequency of the question being issued
# correct_freq: fault of frequency of the question
# lasted_updated_by: user of last change the question
# is_valid: if value is False the question can't be used; True is the opposite
# used_to: question is used in what test paper
# faulted_reason: reason of the question fault
# state: state of the question
class Question(models.Model):
    q_type = models.PositiveSmallIntegerField()
    q_file = models.TextField(blank=True, null=True)
    q_content = models.TextField(blank=True, null=True)
    difficulty = models.PositiveSmallIntegerField(default=0)
    issued_freq = models.IntegerField(default=0)
    correct_freq = models.IntegerField(default=0)
    used_freq = models.PositiveIntegerField(default=0)
    created_time = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey('User', on_delete=models.PROTECT, related_name='question_created')
    update_time = models.DateTimeField(auto_now=True)
    last_updated_by = models.ForeignKey('User', on_delete=models.SET_NULL, blank=True, null=True,
                                        related_name='last_updated')
    is_valid = models.BooleanField(default=False)
    used_to = models.ManyToManyField(TestPaper)
    faulted_reason = models.CharField(max_length=255, blank=True, null=True, default="")
    STATES_CHOICES = (
        (0, '暫存'),
        (1, '審核通過'),
        (2, '審核未通過'),
        (3, '等待審核'),
        (4, '被回報錯誤'),
        (5, '被回報錯誤，已處理'),
    )
    state = models.SmallIntegerField(choices=STATES_CHOICES, default=0)

    class Meta:
        ordering = ('-q_content',)

    @property
    def correct_rate(self):
        return self.correct_freq / self.issued_freq * 100

    def __str__(self):
        return self.q_content


# 選項
# c_content: content of this option
# question: this option is related to what question
# is_answer: if value is False that this option can't answer; True is the opposite
class Choice(models.Model):
    c_content = models.CharField(max_length=255)
    question = models.ForeignKey('Question', on_delete=models.PROTECT)
    is_answer = models.BooleanField(default=False)

    def __str__(self):
        return self.c_content


# 答案卷
# exam: this answer sheet is related to what exam
# user: this answer sheet is related to what user
# finish_time: finished time of the answer sheet
# is_finished: if value is False that this answer sheet does not finish; True is the opposite
# score: score of the answer sheet
class AnswerSheet(models.Model):
    exam = models.ForeignKey('Exam', on_delete=models.CASCADE, blank=True)
    user = models.ForeignKey('User', on_delete=models.CASCADE)      # Student -> User
    finish_time = models.DateTimeField(auto_now_add=True)
    is_finished = models.BooleanField(default=False)
    score = models.PositiveSmallIntegerField(null=True)

    def __str__(self):
        return str(self.user) + '\'s' + str(self.exam)


# 單題答題內容
# answer_sheet: this answer is related to what answer sheet
# question: this answer is related to what question
# selected: selected option id this question
class Answer(models.Model):
    answer_sheet = models.ForeignKey('AnswerSheet', on_delete=models.PROTECT)
    question = models.ForeignKey('Question', on_delete=models.PROTECT)
    selected = models.SmallIntegerField(default=-1)

    def __str__(self):
        return self.question.q_content


# 試卷上的選項順序
# answer: the option list is related to what answer
# choice: the option list is related to what choice
# added_time: time of the option list is added
class OptionList(models.Model):
    answer = models.ForeignKey('Answer', on_delete=models.PROTECT)
    choice = models.ForeignKey('Choice', on_delete=models.PROTECT)
    added_time = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ('added_time', )

    def __str__(self):
        return self.choice.c_content


# 受測名單
# member: members of the group
# create_by: user of creating the group
# update_time: time of updating group profile
# create_time: create time of the group
class Group(models.Model):
    name = models.CharField(max_length=255, unique=True)
    member = models.ManyToManyField('User', blank=True)     # Student -> User
    created_by = models.ForeignKey("User", on_delete=models.PROTECT, related_name='group_created')
    update_time = models.DateTimeField(auto_now=True)
    created_time = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ('-name',)

    def __str__(self):
        return self.name


class TesteeList(models.Model):
    created_by = models.ForeignKey('Exam', on_delete=models.PROTECT)
    testees = models.ManyToManyField('User', blank=True)


# 公告
# text: content of the proclamation
# is_public: if value is False the proclamation can't be showed; True is the opposite
# create_time: create time of the proclamation
# created_by: user of creating the proclamation
class Proclamation(models.Model):
    title = models.TextField(max_length=255)
    text = models.TextField(max_length=512)
    is_public = models.BooleanField(default=False)
    created_time = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey('User', on_delete=models.PROTECT, related_name='proclamation_created')

    class Meta:
        ordering = ('-created_time',)

    def __str__(self):
        return self.title


# name: the name of report category
# responsibility: who responsible for this category
# 回報類別
class ReportCategory(models.Model):
    name = models.CharField(max_length=50, unique=True)
    responsibility = models.PositiveSmallIntegerField(default=32)

    def __str__(self):
        return self.name


# category: this report is belong to which category
# question: when the testees taking the exam and thinking the question is issued, then they can press the button, after
#           exam, they can submit the question report.
# reply:    the principal replied.
# supplement_note: when the user reported, they can describe their situation though the supplement to let the category
#             principal get more understanding.
# state: which state of this report.
# 問題回報
class Report(models.Model):
    user_notification = models.BooleanField(default=False)       # use to notify user the report had been change.
    staff_notification = models.BooleanField(default=False)
    category = models.ForeignKey('ReportCategory', on_delete=models.PROTECT)
    question = models.ForeignKey('Question', on_delete=models.PROTECT, blank=True, null=True)
    reply = models.TextField()
    supplement_note = models.TextField()
    STATES_CHOICES = (
        (0, '暫存'),
        (1, '待處理'),
        (2, '處理中'),
        (3, '已解決'),
    )
    state = models.SmallIntegerField(choices=STATES_CHOICES, default=0)
    created_by = models.ForeignKey('User', on_delete=models.PROTECT)
    created_time = models.DateTimeField(auto_now_add=True, blank=True, null=True)
    resolved_by = models.ForeignKey('User', on_delete=models.PROTECT, related_name='resolve_by', blank=True, null=True)
    resolved_time = models.DateTimeField(auto_now=True, blank=True, null=True)

    def __str__(self):
        return self.category

    def store_reply(self, reply):
        self.reply = json.dumps(reply).encode('utf-8').decode('unicode_escape')

    def get_reply(self):
        return json.loads(self.reply)
