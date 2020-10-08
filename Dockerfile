FROM openjdk:14-jdk

COPY ./target/*.jar /usr/src/pet-clinic/
WORKDIR /usr/src/pet-clinic

