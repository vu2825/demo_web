# ---------- Build stage ----------
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# copy trước pom để cache dependency
COPY pom.xml .
RUN mvn -q -e -DskipTests dependency:go-offline

# copy source và build WAR
COPY src ./src
RUN mvn -q -DskipTests=true clean package

# ---------- Run stage ----------
FROM tomcat:11.0.10-jdk17-temurin

# dọn app mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# copy WAR thành ROOT.war để app chạy ở "/"
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# entrypoint: đổi cổng 8080 -> $PORT (Render cấp)
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# optional: giới hạn RAM để an toàn trên Render Free
ENV JAVA_OPTS="-Xms256m -Xmx512m"

# expose mặc định (Render sẽ map cổng thực tế qua $PORT)
EXPOSE 8080

CMD ["/entrypoint.sh"]
