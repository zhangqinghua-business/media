FROM maven:3.3.9-jdk-8-alpine AS maven
USER root

COPY ./   /tmp/code

RUN cd /tmp/code && ls

RUN cd /tmp/code && mvn clean package -Dmaven.test.skip=true -Dmaven.javadoc.skip=true