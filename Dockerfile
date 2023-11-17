FROM amazoncorretto:17-alpine-jdk AS build

WORKDIR /build

COPY . .
RUN apk add maven && mvn clean && mvn package

FROM amazoncorretto:17-alpine-jdk
VOLUME /app

COPY --from=build /build/target/fileservice-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]