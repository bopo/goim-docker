FROM alpine:3.11
ENV PYTHONUNBUFFERED 1

COPY ./compose/django/standard/supervisor /etc/supervisor
COPY ./compose/django/standard/supervisor.sh /supervisor.sh
COPY ./compose/django/standard/entrypoint.sh /entrypoint.sh
COPY ./project/app/requirements.txt /requirements.txt

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

RUN apk add --update supervisor py3-lxml libevent py3-pillow py3-psycopg2 python3-dev python3 py3-gevent
# RUN pip3 install -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com --upgrade pip setuptools wheel pipenv
RUN pip3 install -r /requirements.txt
RUN rm -rf /requirements.txt

RUN sed -i 's/\r//' /entrypoint.sh
RUN sed -i 's/\r//' /supervisor.sh

RUN chmod +x /entrypoint.sh
RUN chmod +x /supervisor.sh

RUN mkdir /app

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
