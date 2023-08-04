FROM jthambly/graalvm-mvn:latest AS maven

RUN mvn -v
RUN java -version

COPY ./   /tmp/code

RUN cd /tmp/code && ls

RUN cd /tmp/code && mvn clean package -Dmaven.test.skip=true -Dmaven.javadoc.skip=true



# 该镜像需要依赖的基础镜像
FROM jthambly/graalvm-mvn:latest

# 将上一个容器的jar文件复制到此容器下面
COPY --from=maven /tmp/code/media-start/target/*.jar    /app/app.jar

# 调整时区
RUN rm -f /etc/localtime && ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

EXPOSE      8080

# 指定docker容器启动时运行jar包
# -XX:+UseContainerSupport -XX:MaxRAMPercentage=90.0 探测容器内存大小，使用内存不能超过容器的90%
# -Djava.security.egd=file:/dev/./urandom 修复容器Bug
# ${JAVA_OPTS} Java的一些运行参数
ENTRYPOINT ["java", "-jar", "/app/app.jar"]