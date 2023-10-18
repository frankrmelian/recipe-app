FROM python:3.9-alpine3.13
LABEL maintainer="cskillzs"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt

COPY ./app /app
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

WORKDIR /app

EXPOSE 8000

ARG DEV=false

RUN python -m venv /py && /py/bin/python -m pip install --upgrade pip && /py/bin/pip install -r /tmp/requirements.txt && \
     if [ $DEV = "true"]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
     fi && \
      rm -rf /tmp && \
    adduser \
       --disabled-password \ 
       --no-create-home \
       Django-User


ENV PATH="/py/bin:$PATH"


USER  Django-User