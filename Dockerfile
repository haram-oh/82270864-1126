# Use the specified base image (OpenJDK 17)
FROM cepgbaseacr.azurecr.io/docker.io/openjdk:17-slim

# Set working directory in the container
WORKDIR /app

# Install Maven
RUN apt-get update && apt-get install -y maven

# Copy the pom.xml file to the container
COPY pom.xml ./

# Download dependencies (this helps to cache dependencies in Docker layer)
RUN mvn dependency:go-offline

# Copy the whole project into the container
COPY src ./src

# Expose the port the app runs on
EXPOSE 8080

# Run the application using Maven
CMD ["mvn", "spring-boot:run"]
