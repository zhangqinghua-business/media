FROM jthambly/graalvm-mvn:latest

RUN mvn -v
RUN java -version