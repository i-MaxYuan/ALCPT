# Generated by Django 3.2 on 2023-05-02 14:55

import datetime
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('password', models.CharField(max_length=128, verbose_name='password')),
                ('last_login', models.DateTimeField(blank=True, null=True, verbose_name='last login')),
                ('photo', models.ImageField(default='default_propic/default_propic.png', null=True, upload_to='photos')),
                ('reg_id', models.CharField(max_length=50, unique=True)),
                ('email', models.EmailField(blank=True, max_length=254, null=True)),
                ('email_is_verified', models.BooleanField(default=False)),
                ('name', models.CharField(blank=True, max_length=20, null=True)),
                ('gender', models.PositiveSmallIntegerField(blank=True, null=True)),
                ('privilege', models.PositiveSmallIntegerField(default=1)),
                ('created_time', models.DateTimeField(auto_now_add=True)),
                ('update_time', models.DateTimeField(auto_now=True)),
                ('identity', models.PositiveSmallIntegerField(default=0, null=True)),
                ('introduction', models.TextField(null=True)),
                ('level', models.PositiveSmallIntegerField(default=1)),
                ('experience', models.IntegerField(default=0)),
                ('browser', models.TextField(null=True)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Achievement',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('trophy', models.ImageField(default='default_trophy/default_trophy.png', upload_to='photos')),
                ('name', models.CharField(max_length=75)),
                ('key', models.CharField(max_length=75)),
                ('description', models.TextField(blank=True, null=True)),
                ('category', models.PositiveSmallIntegerField(default=0)),
                ('point', models.IntegerField(default=0)),
                ('level', models.IntegerField(default=0)),
                ('completion', models.IntegerField(default=0)),
            ],
        ),
        migrations.CreateModel(
            name='Department',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=10, unique=True)),
            ],
            options={
                'ordering': ('id',),
            },
        ),
        migrations.CreateModel(
            name='Question',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('q_type', models.PositiveSmallIntegerField()),
                ('q_file', models.FileField(null=True, upload_to='question_files')),
                ('q_content', models.TextField(blank=True, null=True)),
                ('difficulty', models.PositiveSmallIntegerField(default=0)),
                ('issued_freq', models.IntegerField(default=0)),
                ('correct_freq', models.IntegerField(default=0)),
                ('q_time', models.IntegerField(default=0)),
                ('q_correct_time', models.IntegerField(default=0)),
                ('created_time', models.DateTimeField(auto_now_add=True)),
                ('update_time', models.DateTimeField(auto_now=True)),
                ('is_valid', models.BooleanField(default=False)),
                ('in_forum', models.BooleanField(default=False)),
                ('faulted_reason', models.CharField(blank=True, default='', max_length=255, null=True)),
                ('state', models.SmallIntegerField(choices=[(1, '審核通過'), (2, '審核未通過'), (3, '等待審核'), (4, '被回報錯誤'), (5, '被回報錯誤，已處理'), (6, '暫存')], default=6)),
                ('best_reply', models.TextField(blank=True, null=True)),
                ('created_by', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='question_created', to=settings.AUTH_USER_MODEL)),
                ('favorite', models.ManyToManyField(to=settings.AUTH_USER_MODEL)),
                ('last_updated_by', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='last_updated', to=settings.AUTH_USER_MODEL)),
                ('replier', models.OneToOneField(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='replier', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('-q_content',),
            },
        ),
        migrations.CreateModel(
            name='ReportCategory',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50, unique=True)),
                ('responsibility', models.PositiveSmallIntegerField(default=32)),
            ],
        ),
        migrations.CreateModel(
            name='Squadron',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=10, unique=True)),
            ],
            options={
                'ordering': ('id',),
            },
        ),
        migrations.CreateModel(
            name='Word_library',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('words', models.TextField(max_length=30)),
                ('translations', models.TextField(max_length=30)),
            ],
        ),
        migrations.CreateModel(
            name='UserAchievement',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('progress', models.IntegerField(default=0)),
                ('unlock', models.BooleanField(default=False)),
                ('registered_at', models.DateTimeField(auto_now_add=True)),
                ('achievement', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='userachievements', to='alcpt.achievement')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='TestPaper',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100, unique=True)),
                ('created_time', models.DateTimeField(auto_now_add=True)),
                ('is_testpaper', models.BooleanField(default=False)),
                ('is_used', models.BooleanField(default=False)),
                ('update_time', models.DateTimeField(auto_now=True)),
                ('valid', models.BooleanField(default=False)),
                ('created_by', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='testee_created', to=settings.AUTH_USER_MODEL)),
                ('question_list', models.ManyToManyField(to='alcpt.Question')),
            ],
        ),
        migrations.CreateModel(
            name='Student',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('stu_id', models.CharField(max_length=50, unique=True)),
                ('grade', models.PositiveSmallIntegerField(default=112)),
                ('department', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='alcpt.department')),
                ('squadron', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='alcpt.squadron')),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='student', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Report',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_notification', models.BooleanField(default=False)),
                ('staff_notification', models.BooleanField(default=False)),
                ('supplement_note', models.TextField()),
                ('state', models.SmallIntegerField(choices=[(1, '待處理'), (2, '處理中'), (3, '已解決'), (4, '暫存')], default=0)),
                ('created_time', models.DateTimeField(auto_now_add=True, null=True)),
                ('resolved_time', models.DateTimeField(auto_now=True, null=True)),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='alcpt.reportcategory')),
                ('created_by', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('question', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='alcpt.question')),
                ('resolved_by', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='resolve_by', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Reply',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField()),
                ('created_time', models.DateTimeField(auto_now_add=True)),
                ('created_by', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to=settings.AUTH_USER_MODEL)),
                ('source', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='alcpt.report')),
            ],
        ),
        migrations.CreateModel(
            name='Proclamation',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.TextField(max_length=255)),
                ('text', models.TextField()),
                ('is_read', models.BooleanField(default=True)),
                ('is_public', models.BooleanField(default=False)),
                ('exam_id', models.PositiveIntegerField(default=0)),
                ('report_id', models.PositiveIntegerField(default=0)),
                ('created_time', models.DateTimeField(auto_now_add=True)),
                ('created_by', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='announcer', to=settings.AUTH_USER_MODEL)),
                ('recipient', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('-created_time',),
            },
        ),
        migrations.CreateModel(
            name='Group',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255, unique=True)),
                ('update_time', models.DateTimeField(auto_now=True)),
                ('created_time', models.DateTimeField(auto_now_add=True)),
                ('created_by', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='group_created', to=settings.AUTH_USER_MODEL)),
                ('member', models.ManyToManyField(blank=True, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('-name',),
            },
        ),
        migrations.CreateModel(
            name='Forum',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('f_content', models.TextField()),
                ('data_time', models.DateTimeField(blank=True, default=datetime.datetime.now, null=True)),
                ('f_creator', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('f_question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='alcpt.question')),
            ],
        ),
        migrations.CreateModel(
            name='Exam',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100, unique=True)),
                ('exam_type', models.PositiveSmallIntegerField(default=2)),
                ('use_freq', models.IntegerField(default=0)),
                ('modified_time', models.DateTimeField(blank=True, null=True)),
                ('average_score', models.FloatField(default=0)),
                ('start_time', models.DateTimeField(blank=True, null=True)),
                ('created_time', models.DateTimeField(auto_now_add=True)),
                ('duration', models.PositiveSmallIntegerField(default=0)),
                ('finish_time', models.DateTimeField(blank=True, null=True)),
                ('is_public', models.BooleanField(default=False)),
                ('remaining_time', models.BigIntegerField(default=None, null=True)),
                ('is_started', models.BooleanField(default=False)),
                ('created_by', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='exam_created', to=settings.AUTH_USER_MODEL)),
                ('testeeList', models.ManyToManyField(to=settings.AUTH_USER_MODEL)),
                ('testpaper', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='alcpt.testpaper')),
            ],
            options={
                'ordering': ('-created_time',),
            },
        ),
        migrations.CreateModel(
            name='Choice',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('c_content', models.CharField(max_length=255)),
                ('is_answer', models.BooleanField(default=False)),
                ('question', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='alcpt.question')),
            ],
        ),
        migrations.CreateModel(
            name='AnswerSheet',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('finish_time', models.DateTimeField(auto_now_add=True)),
                ('is_tested', models.BooleanField(default=False)),
                ('is_finished', models.BooleanField(default=False)),
                ('score', models.PositiveSmallIntegerField(null=True)),
                ('exam', models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, to='alcpt.exam')),
                ('user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Answer',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('selected', models.SmallIntegerField(default=-1)),
                ('answer_sheet', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='alcpt.answersheet')),
                ('question', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='alcpt.question')),
            ],
        ),
    ]
