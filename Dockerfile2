# We use a Docker multi-stage build here in order that we only take the compiled native Spring Boot App from the first build container
FROM oraclelinux:7

# Add Spring Boot Native app spring-boot-graal to Container
COPY media-starter/target/app app

RUN ls -l /app
RUN pwd
RUN ls

# Fire up our Spring Boot Native app by default
CMD [ "sh", "-c", "./app" ]