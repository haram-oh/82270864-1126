# 1. 베이스 이미지 설정
FROM cepgbaseacr.azurecr.io/docker.io/openjdk:17-slim

# 2. 작업 디렉토리 설정
WORKDIR /app

# 3. 필요한 파일을 Docker 이미지로 복사
# 예시: 프로젝트의 모든 파일을 Docker 이미지로 복사
COPY . .

# 4. 애플리케이션 빌드 및 실행
# 예시: Maven을 사용하여 Java 프로젝트를 빌드하는 명령어
RUN apt-get update && apt-get install -y maven
RUN mvn clean install

# 5. 애플리케이션 실행
CMD ["java", "-jar", "target/myapp.jar"]
