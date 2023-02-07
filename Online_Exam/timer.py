import os
import time
from datetime import datetime
from django.core import management
from django.conf import settings


def timer():
    management.call_command("dbbackup")
