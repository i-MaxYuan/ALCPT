import random

from email.mime.text import MIMEText
from smtplib import SMTP, SMTPAuthenticationError, SMTPException
from alcpt.models import User


def email_verified(user: User):
    # strSmtp = "smtp.gmail.com:587"
    # 主機
    strAccount = "109alcpt@gmail.com"
    strPassword = "1090630alcpt"
    verification_code = random.randint(1000, 9999)

    content = "Your verification code is " + str(verification_code)
    msg = MIMEText(content)
    msg["Subject"] = "ALCPT Email Verification"
    # 郵件標題
    mail_to = user.email

    server = SMTP("smtp.gmail.com:587")
    # server = SMTP(strSmtp)
    # 建立連線
    server.ehlo()
    # 跟主機溝通
    server.starttls()
    # TTLS安全驗證

    try:
        server.login(strAccount, strPassword)
        server.sendmail(strAccount, mail_to, msg.as_string())
        hint = "郵件已發送"
    except SMTPAuthenticationError:
        hint = "無法登入"
    except:
        hint = "郵件發送產生錯誤"
    server.quit()
    # 關閉連線
    return verification_code
