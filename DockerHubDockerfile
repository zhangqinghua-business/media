# 该镜像需要依赖的基础镜像
FROM fabric8/java-alpine-openjdk11-jre

# 安装必要的工具（如curl）
COPY media-start/target/media.jar /app

ENTRYPOINT ["java -jar media.jar"]