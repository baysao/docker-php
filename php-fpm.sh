#!/bin/sh
service php7.0-fpm start
startscript=/usr/share/nginx/www/start.sh
if [ -f $startscript ];then chmod +x $startscript; sh $startscript;fi
