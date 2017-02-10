#!/bin/sh
if [ -f "/app/start.sh" ];then chmod -x /app/start.sh ; sh /app/start.sh;fi
exec /usr/sbin/nginx -c /etc/nginx/nginx.conf
