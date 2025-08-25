#!/bin/sh
set -e

# Render đặt biến PORT; nếu không có thì dùng 8080
PORT_ENV="${PORT:-8080}"

# Thay port trong server.xml để Tomcat nghe đúng cổng do Render cấp
sed -ri "s/port=\"8080\"/port=\"${PORT_ENV}\"/g" /usr/local/tomcat/conf/server.xml

# Chạy Tomcat ở foreground để container không thoát
exec catalina.sh run
