FROM oracle/graalvm-ce:20.0.0-java11

COPY ./   /workplaces

RUN cd media-starter && mvn -Pnative native:compile