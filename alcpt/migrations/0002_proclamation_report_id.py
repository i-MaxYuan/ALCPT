# Generated by Django 3.1.1 on 2020-12-15 16:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('alcpt', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='proclamation',
            name='report_id',
            field=models.PositiveIntegerField(default=0),
        ),
    ]