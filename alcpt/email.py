import base64

from django.conf import settings
from django.core.mail import EmailMessage
from alcpt.proclamation import *
from django.utils.translation import gettext as _ #translation


def send_alcpt_mail(subject, message, recipients):
    if isinstance(recipients, str):
        recipients = [recipients]

    email = EmailMessage(
        subject=subject,
        body=message,
        from_email=settings.DEFAULT_FROM_EMAIL,
        to=recipients,
    )
    return email.send(fail_silently=False)


def email_verified(verified_user, verified_email, request_user):
    # encode the verified email
    email = verified_email
    email_bytes = email.encode('ascii')
    base64_bytes = base64.b64encode(email_bytes)
    base64_email = base64_bytes.decode('ascii')

    content = "Hey, " + verified_user.reg_id + "！\n\n" + \
              "Welcome to use ALCPT Online-Practice Platform. You had modified your email.\n" + \
              "Please click on the following URL to complete the email verification process: \n\n" + \
              settings.SITE_URL + "/email_verification_done/" + base64_email + "\n\n" + \
              "This is an automatic notification mail from the system. Please did not reply directly.\n" + \
              "Thank you for your cooperation."

    proclamation_content = _("Please check out your email to complete the email verification, thank you for your cooperation.")
    Proclamation.objects.create(title=_("Email Verification"),
                                text=proclamation_content,
                                is_read=False,
                                is_public=False,
                                created_by=request_user,
                                recipient=verified_user)

    return send_alcpt_mail("ALCPT Email Verification", content, verified_email)


def reset_password_mail(reg_id, email):
    reg_id = reg_id
    reg_id_bytes = reg_id.encode('ascii')
    base64_bytes = base64.b64encode(reg_id_bytes)
    base64_reg_id = base64_bytes.decode('ascii')

    content = "Hey, " + reg_id + ", We had received your request to reset your password." + \
              "Don't worry, we will help you complete this.\n\n" + \
              "Please click on the following link, and step by step to complete the reset password process:\n\n" + \
              settings.SITE_URL + "/accounts/password/reset/" + base64_reg_id + "\n\n" + \
              "This is an automatic notification mail from the system. Please did not reply directly.\n" + \
              "Thank you for your cooperation.\n" + \
              "Hope you will have a better experience at this platform."

    return send_alcpt_mail("ALCPT Reset Password", content, email)


def notification_mail(recipients: list, content: str):
    recipient_emails = [recipient.email for recipient in recipients if recipient.email]
    if not recipient_emails:
        return 0

    return send_alcpt_mail("ALCPT Notification", content, recipient_emails)
