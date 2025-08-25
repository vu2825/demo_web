#!/bin/sh
set -e

# Render cung cấp biến PORT. Nếu không có (chạy local) thì dùng 8080
PORT_ENV="${PORT:-8080}"

# Đổi cổng Connector HTTP trong server.xml => $PORT_ENV
sed -ri "s/port=\"8080\"/port=\"${PORT_ENV}\"/g" /usr/local/tomcat/conf/server.xml

# Chạy Tomcat ở foreground
exec catalina.sh run
