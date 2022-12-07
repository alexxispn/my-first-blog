# syntax=docker/dockerfile:1
FROM python:3.8.15-slim-bullseye
WORKDIR /app
COPY requirements.txt requirements.txt
RUN python -m pip install -r requirements.txt
COPY . .
RUN python manage.py makemigrations && \
    python manage.py migrate && \
    python manage.py loaddata db.json
RUN export DJANGO_SUPERUSER_PASSWORD='password' && \
    export DJANGO_SUPERUSER_USERNAME='admin' && \
    export DJANGO_SUPERUSER_EMAIL='admin@gmail.com' && \
    python manage.py createsuperuser --noinput
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
