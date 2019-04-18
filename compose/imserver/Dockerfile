FROM alpine:3.9

COPY ./standard/supervisor /etc/supervisor
COPY ./standard/supervisor.sh /supervisor.sh
COPY ./standard/entrypoint.sh /entrypoint.sh

RUN echo 'http://mirrors.aliyun.com/alpine/v3.9/main/' > /etc/apk/repositories
RUN echo 'http://mirrors.aliyun.com/alpine/v3.9/community/' >> /etc/apk/repositories

RUN apk add --update supervisor

RUN sed -i 's/\r//' /entrypoint.sh
RUN sed -i 's/\r//' /supervisor.sh

RUN chmod +x /entrypoint.sh
RUN chmod +x /supervisor.sh

COPY ./standard/target /app/target

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]