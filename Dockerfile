
# Simple Dockerfile adding Maven and GraalVM Native Image compiler to the standard
# https://github.com/graalvm/container/pkgs/container/graalvm-ce image
#FROM ghcr.io/graalvm/graalvm-ce:ol7-java11-21.2.0
#FROM appvance/graalvm-11
FROM softinstigate/graalvm-maven
 
ADD . /build
WORKDIR /build
 
# For SDKMAN to work we need unzip & zip
#RUN yum install -y unzip zip
 
#RUN \
    # Install GraalVM Native Image
    #gu install native-image;
# RUN  chmod 777 ./mvnw
RUN  export JAVA_HOME=/usr/lib/graalvm-ce-java11-21.1.0/
RUN  export PATH=$PATH:$JAVA_HOME/bin
RUN  mvn -version
#RUN  ../mvnw -version
 
RUN native-image --version
 
#RUN  mvn -B clean package -P native --no-transfer-progress
#RUN  mvn clean package -P native --no-transfer-progress
