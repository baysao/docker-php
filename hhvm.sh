#!/bin/sh
if [ -z "$HHVM_PORT" ];then HHVM_PORT=8001;fi
exec hhvm --mode server -vServer.Type=fastcgi -vServer.Port=$HHVM_PORT
