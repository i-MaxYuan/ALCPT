import base64
import io
import json
import secrets

import pyotp
import qrcode
from django.contrib.auth.hashers import check_password, make_password
from django.utils import timezone

from alcpt.models import MfaRememberedDevice

MFA_PENDING_USER_ID = 'mfa_pending_user_id'
MFA_PENDING_NEXT = 'mfa_pending_next'
MFA_SETUP_SECRET = 'mfa_setup_secret'
MFA_NEW_BACKUP_CODES = 'mfa_new_backup_codes'
MFA_REMEMBER_COOKIE = 'alcpt_mfa_device'
MFA_REMEMBER_DAYS = 30
MFA_ISSUER = 'ALCPT'


def generate_totp_secret():
    return pyotp.random_base32()


def get_totp(secret):
    return pyotp.TOTP(secret)


def get_provisioning_uri(user, secret):
    name = user.email or user.reg_id
    return get_totp(secret).provisioning_uri(name=name, issuer_name=MFA_ISSUER)


def get_qr_data_uri(uri):
    image = qrcode.make(uri)
    output = io.BytesIO()
    image.save(output, format='PNG')
    encoded = base64.b64encode(output.getvalue()).decode('ascii')
    return 'data:image/png;base64,' + encoded


def normalize_mfa_code(code):
    return ''.join((code or '').strip().replace('-', '').split()).upper()


def generate_backup_codes(count=10):
    alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'
    codes = []
    for _ in range(count):
        raw = ''.join(secrets.choice(alphabet) for _ in range(10))
        codes.append(raw[:5] + '-' + raw[5:])
    return codes


def encode_backup_codes(codes):
    return json.dumps([make_password(normalize_mfa_code(code)) for code in codes])


def get_backup_code_hashes(user):
    try:
        hashes = json.loads(user.mfa_backup_codes or '[]')
    except (TypeError, ValueError):
        return []
    return hashes if isinstance(hashes, list) else []


def backup_code_count(user):
    return len(get_backup_code_hashes(user))


def verify_mfa_code(user, code):
    normalized = normalize_mfa_code(code)
    if not normalized:
        return None

    if user.mfa_totp_secret and normalized.isdigit():
        if get_totp(user.mfa_totp_secret).verify(normalized, valid_window=1):
            return 'totp'

    hashes = get_backup_code_hashes(user)
    for index, code_hash in enumerate(hashes):
        if check_password(normalized, code_hash):
            del hashes[index]
            user.mfa_backup_codes = json.dumps(hashes)
            user.save(update_fields=['mfa_backup_codes'])
            return 'backup'

    return None


def remember_device_cookie_value(user, request):
    selector = secrets.token_urlsafe(18)
    token = secrets.token_urlsafe(32)
    MfaRememberedDevice.objects.create(
        user=user,
        selector=selector,
        token_hash=make_password(token),
        user_agent=request.META.get('HTTP_USER_AGENT', '')[:1000],
        expires_at=timezone.now() + timezone.timedelta(days=MFA_REMEMBER_DAYS),
    )
    return selector + ':' + token


def is_remembered_device(user, request):
    cookie_value = request.COOKIES.get(MFA_REMEMBER_COOKIE, '')
    if ':' not in cookie_value:
        return False

    selector, token = cookie_value.split(':', 1)
    try:
        device = MfaRememberedDevice.objects.get(user=user, selector=selector, expires_at__gt=timezone.now())
    except MfaRememberedDevice.DoesNotExist:
        return False

    return check_password(token, device.token_hash)


def set_remembered_device_cookie(response, cookie_value):
    response.set_cookie(
        MFA_REMEMBER_COOKIE,
        cookie_value,
        max_age=MFA_REMEMBER_DAYS * 24 * 60 * 60,
        httponly=True,
        samesite='Lax',
    )


def clear_remembered_devices(user):
    user.mfa_remembered_devices.all().delete()
