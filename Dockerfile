FROM python:3.9-alpine3.13
LABEL maintainer="alexdchiu@gmail.com"

ENV PYTHONUNBUFFERED 1

COPY ./app/requirements.txt /requirements.txt
COPY ./app /app

WORKDIR /app
EXPOSE 8000

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    # dependencies needed after the postgres driver is installed
    apk add --update --no-cache --virtual .tmp-deps \
    # set up virtual set of dependencies (temp dependencies) needed to install the driver
        build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r requirements.txt && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home app

ENV PATH="/py/bin:$PATH"

USER app

