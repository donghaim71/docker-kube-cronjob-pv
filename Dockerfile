FROM adoptopenjdk/openjdk8
VOLUME /tmp
COPY build/libs/docker-test-0.0.1-SNAPSHOT.jar docker-test.jar
ENTRYPOINT ["java","-jar","-Dspring.profiles.active=local", "-Dapp.home=logs", "docker-test.jar"]