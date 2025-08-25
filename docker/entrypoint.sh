#!/bin/sh
set -e

# Render cấp biến môi trường PORT; local thì dùng 8080
PORT_ENV="${PORT:-8080}"

# Đổi cổng HTTP connector trong server.xml thành $PORT_ENV
# (mặc định là 8080)
sed -ri "s/port=\"8080\"/port=\"${PORT_ENV}\"/g" /usr/local/tomcat/conf/server.xml

# Chạy Tomcat ở foreground
exec catalina.sh run
