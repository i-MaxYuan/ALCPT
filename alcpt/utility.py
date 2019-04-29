from urllib.parse import urlsplit, parse_qs, urlencode, urlunsplit

from django.core.files.storage import FileSystemStorage


def save_file(*, file, path: str):
    file_system = FileSystemStorage()
    filename = file_system.save(path, file)
    return file_system.url(filename)


def set_query_parameter(url, param_name, param_value):
    """
    Given a URL, set or replace a query parameter and return the
    modified URL.

    from https://stackoverflow.com/questions/4293460/how-to-add-custom-parameters-to-an-url-query-string-with-python
    """
    scheme, netloc, path, query_string, fragment = urlsplit(url)
    query_params = parse_qs(query_string)

    query_params[param_name] = [param_value]
    new_query_string = urlencode(query_params, doseq=True)

    return urlunsplit((scheme, netloc, path, new_query_string, fragment))
