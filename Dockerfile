# ==== Stage 1: Build WAR bằng Maven ====
FROM maven:3.9.8-eclipse-temurin-21 AS build
WORKDIR /app

# Cache deps trước để build nhanh hơn
COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

# Copy source và build
COPY src ./src
RUN mvn -q -DskipTests clean package

# ==== Stage 2: Run với Tomcat ====
# Khuyến nghị dùng JDK 21 cho ổn định (khớp stage build)
FROM tomcat:11.0.10-jdk21-temurin

# Xóa app mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR thành ROOT.war để chạy ở "/"
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Entrypoint: chỉnh cổng Tomcat = $PORT của Render
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Tùy chọn: giới hạn RAM cho gói Free
ENV JAVA_OPTS="-Xms256m -Xmx512m"

# Metadata
EXPOSE 8080

CMD ["/entrypoint.sh"]
