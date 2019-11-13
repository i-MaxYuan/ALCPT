import time

from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager

from alcpt.definitions import UserType

# Create your models here.


class UserManager(BaseUserManager):
    def create_user(self, reg_id, password=None):
        """
        Creates and saves a user with the given serial number.
        """

        user = self.model(
            reg_id=reg_id,
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
class User(AbstractBaseUser):
    reg_id = models.CharField(max_length=10, unique=True)
    name = models.CharField(max_length=20, blank=True, null=True)
    gender = models.PositiveSmallIntegerField(blank=True, null=True)
    priviledge = models.PositiveSmallIntegerField(default=0)
    created_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)

    objects = UserManager()

    USERNAME_FIELD = 'reg_id'

    def get_short_name(self):
        return self.reg_id

    def get_full_name(self):
        return self.reg_id

    def has_perm(self, require_priviledge: UserType):
        # if require_priviledge is UserType.SystemManager:
        #     return self.priviledge & UserType.SystemManager.value[0]
        #
        # else:
        #     return (self.priviledge & require_priviledge.value[0]) > 0
        return (self.priviledge & require_priviledge.value[0]) > 0


# 學系
class Department(models.Model):
    name = models.CharField(max_length=10, unique=True)


# 中隊
class Squadron(models.Model):
    name = models.CharField(max_length=10, unique=True)


# 學生
class Student(models.Model):
    user = models.OneToOneField("User", on_delete=models.CASCADE)
    department = models.ForeignKey("Department", on_delete=models.PROTECT, blank=True, null=True)
    grade = models.PositiveSmallIntegerField(default=time.localtime().tm_year - 1911)
    squadron = models.ForeignKey("Squadron", on_delete=models.PROTECT, blank=True, null=True)


# 試卷
class TestPaper(models.Model):
    name = models.CharField(max_length=100, unique=True)
    created_time = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey("User", on_delete=models.PROTECT, related_name='tester_created')
    update_time = models.DateTimeField(auto_now=True)
    valid = models.BooleanField(default=False)

    def __str__(self):
        return self.name


# 模擬考
class Exam(models.Model):
    name = models.CharField(max_length=100, unique=True)
    exam_type = models.PositiveSmallIntegerField(default=2)
    testpaper = models.ForeignKey('TestPaper', on_delete=models.CASCADE, null=True)
    group = models.ForeignKey('Group', on_delete=models.CASCADE, null=True)
    use_freq = models.IntegerField(default=0)
    modified_times = models.IntegerField(default=0)
    start_time = models.DateTimeField(blank=True, null=True)
    created_time = models.DateTimeField(auto_now_add=True)
    duration = models.PositiveSmallIntegerField(default=-1)
    created_by = models.ForeignKey('User', on_delete=models.PROTECT, related_name='exam_created')
    finish_time = models.DateTimeField(auto_now=True)
    is_public = models.BooleanField(default=False)

    class Meta:
        ordering = ('-created_time',)

    def __str__(self):
        return self.name

    @property
    def correct_rate(self):
        return self.modified_times / self.use_freq * 100


# 題目
class Question(models.Model):
    question_type = models.PositiveSmallIntegerField()
    question_file = models.TextField(blank=True, null=True)
    question = models.TextField(blank=True, null=True)
    option = models.TextField()
    answer = models.PositiveSmallIntegerField()
    difficulty = models.PositiveSmallIntegerField(default=0)
    issued_freq = models.IntegerField(default=0)
    correct_freq = models.IntegerField(default=0)
    created_time = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey('User', on_delete=models.PROTECT, related_name='question_created')
    update_time = models.DateTimeField(auto_now=True)
    last_updated_by = models.ForeignKey('User', on_delete=models.SET_NULL, blank=True, null=True, related_name='last_updated')
    is_valid = models.BooleanField(default=False)
    used_to = models.ManyToManyField(TestPaper)
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
        ordering = ('-question',)

    @property
    def correct_rate(self):
        return self.correct_freq / self.issued_freq * 100


# 答案卷
class AnswerSheet(models.Model):
    exam = models.ForeignKey('Exam', on_delete=models.CASCADE, blank=True)
    user = models.ForeignKey('Student', on_delete=models.CASCADE)
    questions = models.TextField(blank=True, null=True)
    answers = models.TextField(blank=True, null=True)
    finish_time = models.DateTimeField(auto_now_add=True)
    is_finished = models.BooleanField(default=False)
    score = models.PositiveSmallIntegerField()

    def __str__(self):
        return str(self.user) + '\'s' + str(self.exam)


# 受測名單
class Group(models.Model):
    name = models.CharField(max_length=255, unique=True)
    member = models.ManyToManyField('Student', blank=True)
    created_by = models.ForeignKey("User", on_delete=models.PROTECT, related_name='group_created')
    update_time = models.DateTimeField(auto_now=True)
    created_time = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ('-name',)

    def __str__(self):
        return self.name


# 公告
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
