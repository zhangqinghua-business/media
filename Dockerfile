FROM maven:3.3.9-jdk-8-alpine AS maven
USER root

COPY ./   /tmp/code

RUN cd /tmp/code && ls

RUN cd /tmp/code && mvn clean package -Dmaven.test.skip=true -Dmaven.javadoc.skip=true

# 该镜像需要依赖的基础镜像
FROM fabric8/java-alpine-openjdk11-jre

# 将上一个容器的jar文件复制到此容器下面
COPY --from=maven /tmp/code/talkai-chat/chat-starter/target/*.jar    /app/app.jar
# ADD talkai-chat/chat-starter/target/talkai.jar /app/app.jar

# 调整时区
RUN rm -f /etc/localtime && ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# JVM启动参数

# 默认配置文件
ENV MYSQL_HOST ""
ENV MYSQL_PORT ""
ENV MYSQL_DATABASE ""
ENV MYSQL_USERNAME ""
ENV MYSQL_PASSWORD ""

ENV REDIS_HOST ""
ENV REDIS_PORT ""
ENV REDIS_DATABASE 0
ENV REDIS_PASSWORD ""

EXPOSE      8071

# 指定docker容器启动时运行jar包
# -XX:+UseContainerSupport -XX:MaxRAMPercentage=90.0 探测容器内存大小，使用内存不能超过容器的90%
# -Djava.security.egd=file:/dev/./urandom 修复容器Bug
# ${JAVA_OPTS} Java的一些运行参数
ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=90.0", "-Djava.security.egd=file:/dev/./urandom", "-Xmx256m", "-jar", "app/app.jar", "--spring.datasource.url=jdbc:mysql://${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE}?useSSL=false&serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=utf-8&allowMultiQueries=true&autoReconnect=true&useCompression=true&zeroDateTimeBehavior=CONVERT_TO_NULL", "--spring.datasource.username=${MYSQL_USERNAME}", "--spring.datasource.password=${MYSQL_PASSWORD}", "--spring.redis.host=${REDIS_HOST}", "--spring.redis.port=${REDIS_PORT}", "--spring.redis.database=${REDIS_DATABASE}", "--spring.redis.password=${REDIS_PASSWORD}"]