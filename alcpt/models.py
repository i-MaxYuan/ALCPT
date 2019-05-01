import time

from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager

from alcpt.definitions import UserType

# Create your models here.


class UserManager(BaseUserManager):
    def create_user(self, serial_number, password=None):
        """
        Creates and saves a user with the given serial number.
        """

        user = self.model(
            serial_number=serial_number,
        )

        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(self, serial_number, password):
        """
        Creates and saves a superuser with the given serial number, password.
        """

        user = self.model(
            serial_number=serial_number,
        )
        user.set_password(password)
        user.is_admin = True
        user.save(using=self._db)

        return user


# 使用者
class User(AbstractBaseUser):
    serial_number = models.CharField(max_length=10, unique=True)
    name = models.CharField(max_length=20, blank=True, null=True)
    gender = models.PositiveSmallIntegerField(blank=True, null=True)
    user_type = models.PositiveSmallIntegerField(default=0)
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)

    objects = UserManager()

    USERNAME_FIELD = 'serial_number'

    def get_short_name(self):
        return self.serial_number

    def get_full_name(self):
        return self.serial_number

    def has_perm(self, require_user_type: UserType):
        # if require_user_type is UserType.SystemManager:
        #     return self.user_type & UserType.SystemManager.value[0]
        #
        # else:
        #     return (self.user_type & require_user_type.value[0]) > 0
        return (self.user_type & require_user_type.value[0]) > 0


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
    name = models.CharField(max_length=100, primary_key=True)
    questions = models.TextField(max_length=255, blank=True)
    create_time = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey("User", on_delete=models.PROTECT, related_name='tester_created')
    update_time = models.DateTimeField(auto_now=True)
    enable = models.BooleanField(default=False)

    def __str__(self):
        return self.name


# 模擬考
class Exam(models.Model):
    name = models.CharField(max_length=100, primary_key=True)
    type = models.PositiveSmallIntegerField(default=2)
    testpaper = models.ForeignKey('TestPaper', on_delete=models.CASCADE)
    usetimes = models.IntegerField(default=0)
    correcttimes = models.IntegerField(default=0)
    start_time = models.DateTimeField(blank=True, null=True)
    create_time = models.DateTimeField(auto_now_add=True)
    duration = models.PositiveSmallIntegerField()
    created_by = models.ForeignKey('User', on_delete=models.PROTECT, related_name='exam_created')
    update_time = models.DateTimeField(auto_now=True)
    public = models.BooleanField(default=False)

    class Meta:
        ordering = ('-create_time',)

    def __str__(self):
        return self.name

    @property
    def correctrate(self):
        return self.correcttimes / self.usetimes * 100


# 題目
class Question(models.Model):
    question_type = models.PositiveSmallIntegerField()
    question_file = models.TextField(blank=True, null=True)
    question = models.TextField(blank=True, null=True)
    option = models.TextField()
    answer = models.PositiveSmallIntegerField()
    difficult = models.PositiveSmallIntegerField(default=0)
    use_time = models.IntegerField(default=0)
    correct_time = models.IntegerField(default=0)
    create_time = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey('User', on_delete=models.PROTECT, related_name='question_created')
    update_time = models.DateTimeField(auto_now=True)
    last_updated_by = models.ForeignKey('User', on_delete=models.SET_NULL, blank=True, null=True, related_name='last_updated')
    enable = models.BooleanField(default=False)
    used_to = models.ManyToManyField(TestPaper)
    
    class Meta:
        ordering = ('-question',)

    @property
    def correct_rate(self):
        return self.correct_time / self.use_time * 100


# 答案卷
class AnswerSheet(models.Model):
    exam = models.ForeignKey('Exam', on_delete=models.CASCADE, blank=True)
    user = models.ForeignKey('Student', on_delete=models.CASCADE)
    questions = models.TextField(blank=False, null=True)
    answers = models.TextField(blank=True, null=True)
    create_time = models.DateTimeField(auto_now_add=True)
    score = models.PositiveSmallIntegerField()

    def __str__(self):
        return str(self.user) + '\'s' + str(self.exam)


# 受測名單
class Group(models.Model):
    name = models.CharField(max_length=255, primary_key=True)
    member = models.ManyToManyField('Student', blank=True)

    class Meta:
        ordering = ('-name',)

    def __str__(self):
        return self.name


# 公告
class Proclamation(models.Model):
    title = models.TextField(max_length=255)
    text = models.TextField(max_length=512)
    enable = models.BooleanField(default=False)
    create = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey('User', on_delete=models.PROTECT, related_name='proclamation_created')

    class Meta:
        ordering = ('-create',)

    def __str__(self):
        return self.title
