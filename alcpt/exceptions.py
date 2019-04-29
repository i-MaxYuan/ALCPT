class BaseError(Exception):
    def __init__(self, message, redirect: bool=False):
        self.message = message
        self.redirect_url = '/' if redirect else None

    def __str__(self):
        return self.message


class ObjectNotFoundError(BaseError):
    def __init__(self, message):
        super().__init__(message=message)


class PermissionWrongError(BaseError):
    def __init__(self, redirect: bool=False):
        super().__init__(message='Permission denied.', redirect=redirect)


class IllegalArgumentError(BaseError):
    def __init__(self, message):
        super().__init__(message=message)


class ArgumentError(BaseError):
    def __init__(self, message):
        super().__init__(message=message)


class ResourceNotFoundError(BaseError):
    def __init__(self, message):
        super().__init__(message=message)
