FROM python:3.11.3-slim-buster

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Setup basic environment
RUN pip install -U pip
RUN apt-get update

# Setup poetry 1.3.2
RUN apt install -y curl
RUN curl -sSL curl -sSL https://install.python-poetry.org | python - --version 1.3.2
ENV PATH="${PATH}:/root/.local/bin"
RUN poetry config virtualenvs.create false

# Setup postgresql
RUN apt-get install -y libpq-dev gcc

# Setup netcat for entrypoint
RUN apt-get install -y netcat

# Set work directory and change into it
WORKDIR /app

# Copy poetry files
ADD pyproject.toml poetry.lock .

# Install dependencies
RUN poetry install --no-dev --no-interaction --no-ansi

ENTRYPOINT ["bash", "/app/entrypoint.sh"]

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
