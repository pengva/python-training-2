#!/bin/sh

#python manage.py flush --no-input
python manage.py migrate
python manage.py collectstatic --noinput

gunicorn python_training_2.wsgi:application --bind 0.0.0.0:8000

exec "$@"