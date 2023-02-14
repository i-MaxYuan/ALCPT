# Generated by Django 3.1.1 on 2022-03-05 16:53

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('alcpt', '0014_auto_20220303_2319'),
    ]

    operations = [
        migrations.AlterField(
            model_name='forum',
            name='f_creator',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='forum',
            name='f_question',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='alcpt.question'),
        ),
    ]