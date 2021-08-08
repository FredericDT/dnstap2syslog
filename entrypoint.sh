#!/bin/bash

set -e

if [ -z "${SYSLOG_SERVER}" ]
then
        echo "SYSLOG_SERVER Must set"
        exit 1
fi

SYSLOG_SERVER_PORT="${SYSLOG_SERVER_PORT:=514}"

dnstap -l 0.0.0.0:6000 | logger --udp --skip-empty --server ${SYSLOG_SERVER} --port ${SYSLOG_SERVER_PORT} --rfc5424 --tag DNS --priority user.info 
