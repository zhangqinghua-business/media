FROM alpine:3.17.1

# 拉取制品
COPY target/mygraalvmplanet mygraalvmplanet

ENTRYPOINT ["/mygraalvmplanet"]