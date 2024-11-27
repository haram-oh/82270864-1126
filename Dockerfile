# Stage 1: Build the application
FROM maven:3.8.7-openjdk-17 as builder

# Set working directory
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml ./
RUN mvn dependency:go-offline

# Copy the entire project and build
COPY . ./
RUN mvn clean package -DskipTests

# Stage 2: Create a lightweight image for running
FROM cepgbaseacr.azurecr.io/docker.io/openjdk:17-slim

# Set working directory
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
