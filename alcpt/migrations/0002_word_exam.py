# Generated by Django 3.2 on 2022-12-29 15:12

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('alcpt', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Word_exam',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('words', models.CharField(max_length=50)),
                ('translations', models.TextField()),
            ],
        ),
    ]
