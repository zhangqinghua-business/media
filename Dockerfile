FROM jthambly/graalvm-mvn:latest

RUN mvn -v
RUN java -version

COPY ./   /tmp/code

RUN cd /tmp/code && ls

RUN cd /tmp/code && mvn clean package -Dmaven.test.skip=true -Dmaven.javadoc.skip=true