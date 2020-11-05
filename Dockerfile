FROM openjdk:14-jdk

ARG JAR_PATH=target/spring-petclinic-2.3.0.BUILD-SNAPSHOT.jar
ARG PROJ_PATH=/usr/src/pet-clinic
ARG MAIN_JAR=main.jar

COPY ${JAR_PATH} "$PROJ_PATH/$MAIN_JAR"
WORKDIR ${PROJ_PATH}

EXPOSE 8080
CMD ["java", "-jar", "${MAIN_JAR}"]
