FROM jthambly/graalvm-mvn:latest AS maven



COPY ./   /tmp/code

RUN cd /tmp/code && ls

RUN mvn -v
RUN java -version

RUN cd /tmp/code
RUN ls -l /tmp/code

RUN ls -l
RUN mvn clean package -Dmaven.test.skip=true -Dmaven.javadoc.skip=true