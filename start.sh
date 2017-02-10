#!/bin/sh
start="/app/start.sh"
if [ -f "$start" ];then
	chmod +x /app/start.sh
	/app/start.sh
fi
