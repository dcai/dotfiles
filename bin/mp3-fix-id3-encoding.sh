#!/bin/bash

ENCODING="${MP3_ENCODING:-gbk}"

if which mid3iconv >/dev/null; then
    if [[ $1 == '-x' ]]; then
        CMD="xargs -0 mid3iconv --encoding=${ENCODING} -d"
    else
        printf "> dry-run, if charset is correct, add -x\n"
        CMD="xargs -0 mid3iconv --dry-run --encoding=${ENCODING} -d"
    fi

    find . -iname "*.mp3" -print0 | eval $CMD

    printf "\n\n===========\n\n"
    printf "> $CMD"
else
    printf "ERROR: please install mutagen\n"
    printf "> pip3 install --user --upgrade mutagen\n"
fi
