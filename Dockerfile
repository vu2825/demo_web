# ===== Stage 1: Build WAR =====
FROM maven:3.9.8-eclipse-temurin-21 AS build
WORKDIR /app

# Cache deps để build nhanh
COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

# Copy source và build
COPY src ./src
RUN mvn -q -DskipTests clean package

# ===== Stage 2: Run Tomcat =====
FROM tomcat:11.0-jdk21-temurin

# Dọn webapp mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR thành ROOT.war để chạy tại "/"
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Entrypoint: set Tomcat port = $PORT của Render
COPY docker/entrypoint.sh /entrypoint.sh

# Phòng lỗi CRLF nếu bạn commit từ Windows
RUN sed -i 's/\r$//' /entrypoint.sh && chmod +x /entrypoint.sh

# Giới hạn RAM cho gói Free (tuỳ chọn)
ENV JAVA_OPTS="-Xms256m -Xmx512m"

EXPOSE 8080
CMD ["/entrypoint.sh"]
