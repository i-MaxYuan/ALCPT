# Generated by Django 3.2 on 2024-03-04 23:10

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('alcpt', '0004_alter_onlinestatus_online_status'),
    ]

    operations = [
        migrations.AlterField(
            model_name='onlinestatus',
            name='user',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]
