FROM openjdk:14-jdk

ARG JAR_PATH=target/spring-petclinic-2.3.0.BUILD-SNAPSHOT.jar
ARG PROJ_PATH=/usr/src/pet-clinic

COPY ${JAR_PATH} "$PROJ_PATH/main.jar"
WORKDIR ${PROJ_PATH}

EXPOSE 8080
CMD ["java", "-jar", "main.jar"]
