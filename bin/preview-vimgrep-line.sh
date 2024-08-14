#!/bin/bash

# companion script for `./cr`
AWK_BIN='gawk'

FILEPATH=$(echo "$1" | ${AWK_BIN} -F: '{print $1}')
LINE=$(echo "$1" | ${AWK_BIN} -F: '{print $2}')
BEGIN=$((LINE - 10))
if [[ $BEGIN -lt 0 ]]; then
    BEGIN=0
fi
cmd="bat --theme zenburn -n --color=always --line-range $BEGIN:$((LINE + 10)) $FILEPATH"
# echo "$cmd"
eval "$cmd"
