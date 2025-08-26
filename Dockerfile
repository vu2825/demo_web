# ---------- Stage 1: Build WAR ----------
FROM maven:3.9.11-eclipse-temurin-21 AS builder
WORKDIR /app

# Tối ưu cache: tải deps trước
COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

# Copy source và build
COPY src ./src
RUN mvn clean package -DskipTests

# ---------- Stage 2: Tomcat runtime ----------
FROM tomcat:11.0-jdk24

# Xóa webapp mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR thành ROOT.war để chạy ở /
# (Đổi demo_web.war nếu bạn đặt finalName khác)
COPY --from=builder /app/target/demo_web.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

# (Tùy chọn) chạy user không phải root
# USER 1001

CMD ["catalina.sh", "run"]
