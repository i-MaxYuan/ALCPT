# Parent exception class
class BaseError(Exception):
    def __init__(self, message, redirect: bool = False):
        self.message = message
        self.redirect_url = '/' if redirect else None

    def __str__(self):
        return self.message


# class ObjectNotFoundError inherit BaseError
class ObjectNotFoundError(BaseError):
    def __init__(self, message):
        super().__init__(message=message)


# class PermissionWrongError inherit BaseError and change the error message
class PermissionWrongError(BaseError):
    def __init__(self, redirect: bool = False):
        super().__init__(message='Permission denied.', redirect=redirect)


# class IllegalArgumentError inherit BaseError
class IllegalArgumentError(BaseError):
    def __init__(self, message):
        super().__init__(message=message)


# class ArgumentError inherit BaseError
class ArgumentError(BaseError):
    def __init__(self, message):
        super().__init__(message=message)


# class ResourceNotFoundError inherit BaseError
class ResourceNotFoundError(BaseError):
    def __init__(self, message):
        super().__init__(message=message)


class IntegrityError(BaseError):
    def __init__(self, message):
        super().__init__(message=message)
