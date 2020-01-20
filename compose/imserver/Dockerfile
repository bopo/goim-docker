FROM alpine:3.11

COPY ./standard/supervisor /etc/supervisor
COPY ./standard/supervisor.sh /supervisor.sh
COPY ./standard/entrypoint.sh /entrypoint.sh

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

RUN apk add --update supervisor

RUN sed -i 's/\r//' /entrypoint.sh
RUN sed -i 's/\r//' /supervisor.sh

RUN chmod +x /entrypoint.sh
RUN chmod +x /supervisor.sh

COPY ./standard/target /app/target

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]