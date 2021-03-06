FROM gradle:alpine as builder
USER root
ADD . /home/gradle/project
WORKDIR /home/gradle/project
RUN gradle --stacktrace assemble

FROM openjdk:8-jdk-alpine
COPY --from=0 /home/gradle/project/build/libs/app-0.0.1.jar /app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
