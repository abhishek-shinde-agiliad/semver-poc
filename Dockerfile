#
# BUILD STAGE
#
FROM maven:3.6.0-jdk-11-slim AS build 

ARG VERSION
ENV VERSION=${VERSION}

ARG DATE_TIMESTAMP
ENV DATE_TIMESTAMP=${DATE_TIMESTAMP}

ARG SHA_KEY
ENV SHA_KEY=${SHA_KEY}

COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app  
RUN mvn -f /usr/src/app/pom.xml -DVERSION=$${VERSION}-DDATE_TIMESTAMP=$DATE_TIMESTAMP -DSHA_KEY=${SHA_KEY} clean package

#
# PACKAGE STAGE
#
FROM openjdk:11-jre-slim 
COPY --from=build /usr/src/app/target/demo*.jar /usr/app/demo*.jar  
EXPOSE 8080  
CMD ["java","-jar","/usr/app/demo*.jar"]  