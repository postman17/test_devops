FROM python:3.7-alpine
ENV PYTHONUNBUFFERED 1

RUN mkdir /code
WORKDIR /code

RUN apk update && \
    apk add --virtual build-deps gcc python3-dev musl-dev && \
    apk add postgresql-dev postgresql-client

RUN apk add --no-cache jpeg-dev zlib-dev
RUN apk add --update bash && rm -rf /var/cache/apk/*

ADD requirements.txt ./code/requirements.txt

RUN pip3 install -r ./code/requirements.txt

ADD ./firstdev/ /code/
ADD docker/dev/entrypoint.sh ./code/entrypoint.sh

RUN chmod +x ./code/entrypoint.sh
ENTRYPOINT ["./code/entrypoint.sh"]
