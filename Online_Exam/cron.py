import os
import time
from datetime import datetime
from django.core import management
from django.conf import settings
from django_cron import CronJobBase, Schedule


def backup():
    try:
        print("printed from crontab"+str(datetime.now()))
        management.call_command("dbbackup")
    except Exception as e:
        print(e)
    finally:
        print("\n")
