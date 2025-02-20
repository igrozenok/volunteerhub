FROM eclipse-temurin:21-jdk
WORKDIR /volunteerhub
COPY . .
RUN ./mvnw package -DskipTests
CMD ["java", "-jar", "target/volunteerhub-0.0.1-SNAPSHOT.jar"]
