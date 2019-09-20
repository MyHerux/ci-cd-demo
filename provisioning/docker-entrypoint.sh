#!/bin/bash

profile="${profile}"
project="${project}"

JAVA_OPT="${JAVA_OPT:=-Xmx2g}"

X_TEST_CONFIG="${X_TEST_CONFIG}"

config(){
    if [[ -z "${X_TEST_CONFIG}" ]]; then
        echo -e "\n\"X_TEST_CONFIG\"  can not be empty!\n"
    else
        sed -i "s#X_TEST_CONFIG#${X_TEST_CONFIG}#g" /opt/${project}/application.yml
    fi
}

config

exec java ${JAVA_OPT} -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+PrintGCDetails -Xloggc:./logs/gc-$(date +%F).log -Dfile.encoding=utf-8 -jar ${project}.jar --spring.config.location=application.yml --spring.profiles.active=${profile} ${@}
