FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt update && apt install -y tzdata util-linux golang-github-dnstap-golang-dnstap-cli

ADD entrypoint.sh /entrypoint.sh

RUN chmod u+x /entrypoint.sh

ENTRYPOINT /entrypoint.sh

ENV SYSLOG_SERVER=
ENV SYSLOG_SERVER_PORT=514

EXPOSE 6000

