## Start with a base image containing Java runtime
#FROM openjdk:17
#
## Add maintainer info
#LABEL maintainer = "Illary Huaylupo <illary@gmail.com>"
#
## The application's jar file
#ARG JAR_FILE
#
## Add the application's jar to the container
#COPY ${JAR_FILE} app.jar
#
## Unpackage jar file
#RUN mkdir -p target/dependency && (cd target/dependency; jar -xf /app.jar)
#
## execute the application
#ENTRYPOINT ["java","-jar","/app.jar"]

#### multi stage build

# stage 1
# Start with a base image containing Java runtime
#FROM openjdk:17 as build
#
## Add maintainer info
#LABEL maintainer = "Illary Huaylupo <illary@gmail.com>"
#
## The application's jar file
#ARG JAR_FILE
#
## Add the application's jar to the container
#COPY ${JAR_FILE} app.jar
#
## unpackage jar file
#RUN mkdir -p target/dependency && (cd target/dependency; jar -xf /app.jar)
#
## stage 2
## Same Java runtime
#FROM openjdk:17
#
## Add volume pointing to /tmp
#VOLUME /tmp
#
## Copy unpacked application to new container
#ARG DEPENDENCY=target/dependency
#COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
#COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
#COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
#
## execute the application
#ENTRYPOINT ["java", "-cp", "app:app/lib/*", "com.optimagrowth.licensing.LicensingServiceApplication"]

# Make layers Dockerfile

FROM openjdk:17 as build
WORKDIR application
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM openjdk:17
WORKDIR application

COPY --from=build application/dependencies/ ./
COPY --from=build application/spring-boot-loader/ ./
COPY --from=build application/snapshot-dependencies/ ./

COPY --from=build application/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.launch.JarLauncher"]