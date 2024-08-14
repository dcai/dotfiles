#!/bin/bash

pid=$(lsof -i "tcp:$1" -sTCP:LISTEN | sed 1d | fzf -m | awk '{print $2}')

if [ "x$pid" != "x" ]; then
    kill -9 ${pid}
fi
