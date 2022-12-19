import os
import time
from datetime import datetime
from django.core import management
from django.conf import settings
from django_cron import CronJobBase, Schedule

#from Online_Exam import urls
#
#from .models import DbBackupTime  # django.core.exceptions.AppRegistryNotReady: Apps aren't loaded yet.
#前端呼叫方法之腳本,未完成

def backup():
    try:
        print("printed from crontab"+str(datetime.now()))
        management.call_command("dbbackup")
    except Exception as e:
        print(e)
    finally:
        print("\n")

def restore():
    management.call_command("dbrestore")


def cron_time():
    min = "/1"
    hour = ""
    day_of_month = ""
    month = ""
    day_of_week = ""
    return(f"*{min} *{hour} *{day_of_month} *{month} *{day_of_week}")