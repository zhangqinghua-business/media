FROM alpine:3.17.1

# 安装必要的工具（如curl）
RUN apk update && apk add --no-cache curl
