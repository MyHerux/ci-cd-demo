
FROM java:openjdk-8-jdk
ARG project=ci-cd-demo
ARG profile=prod

ENV PATH=.:$PATH

WORKDIR /opt/ci-cd-demo


COPY ./target/ci-cd-demo.jar                 /opt/ci-cd-demo/ci-cd-demo.jar
COPY ./target/classes/application.yml        /opt/ci-cd-demo/application.yml
COPY ./provisioning/docker-entrypoint.sh     /opt/ci-cd-demo/docker-entrypoint.sh

EXPOSE 8080
VOLUME /opt/ci-cd-demo/logs
VOLUME /opt/ci-cd-demo/data

ENTRYPOINT ["docker-entrypoint.sh"]
CMD [""]
