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

RUN mkdir -p /app/config

COPY ./standard/target /app

#COPY ./standard/discovery/discovery-example.toml /app/config/discovery.toml
#COPY ./standard/discovery/scheduler-example.json /app/config/scheduler.json

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
