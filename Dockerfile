# ---------- Stage 1: Build WAR ----------
FROM maven:3.9.8-eclipse-temurin-21 AS builder
WORKDIR /app

# Tối ưu cache: tải deps trước
COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

# Copy source và build
COPY src ./src
RUN mvn clean package -DskipTests

# ---------- Stage 2: Tomcat runtime ----------
FROM tomcat:10.1-jdk21

# Xóa webapp mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR thành ROOT.war để chạy ở /
# (Đổi demo_web.war nếu bạn đặt finalName khác)
# WAR của bạn là demo.war (theo README)
COPY --from=builder /app/target/demo.war /usr/local/tomcat/webapps/demo.war

EXPOSE 8080

# (Tùy chọn) chạy user không phải root
# USER 1001

CMD ["catalina.sh", "run"]
