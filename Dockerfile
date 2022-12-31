FROM python:3
LABEL maintainer="alexdchiu@gmail.com"

ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt /requirements.txt
COPY ./back_end/logs /logs

WORKDIR /logs
