FROM maven:latest as builder

WORKDIR /app

COPY . .

RUN mvn clean install -DskipTests

FROM openjdk:8-jre

WORKDIR /app

COPY --from=builder /app/target/shopping-cart-0.0.1-SNAPSHOT.jar .

EXPOSE 8070

CMD ["java", "-jar", "shopping-cart-0.0.1-SNAPSHOT.jar"]