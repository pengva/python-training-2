FROM python:3.10-alpine

RUN mkdir -p /home/app
RUN addgroup -S app && adduser -S app -G app

ENV APP_HOME=/home/app/
RUN mkdir $APP_HOME/staticfiles

WORKDIR $APP_HOME

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY Pipfile* ./

RUN pip install --upgrade pip && \
  pip install -U pipenv && \
  pipenv install --system

COPY ./python_training_2 $APP_HOME
COPY ./entrypoint.sh $APP_HOME

RUN chown -R app:app $APP_HOME

USER app

ENTRYPOINT [ "/home/app/entrypoint.sh" ]