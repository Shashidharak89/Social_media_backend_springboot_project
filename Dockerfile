# Use the official Maven image to build the application
# This image has Maven and JDK 17 pre-installed
FROM maven:3.8.7-eclipse-temurin-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml ./
RUN mvn dependency:go-offline -B

# Copy the project files and build the application
COPY src ./src
RUN mvn clean package -DskipTests

# Use a lightweight JDK image for the final build
FROM eclipse-temurin:17-jdk-jammy

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/myFirstProject-0.0.1-SNAPSHOT.jar app.jar

# Expose the port that the Spring Boot application will run on
EXPOSE 8080

# Set environment variables for MongoDB URI and Port
ENV MONGODB_URI=<YOUR_MONGODB_URI>
ENV PORT=8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
