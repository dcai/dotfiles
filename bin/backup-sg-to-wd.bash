#!/bin/bash

## this is the 2t seagate drive
SRC=(
    '/Volumes/SG3TB/Media/'
)

## this is the 4t red wd drive
DEST="/Volumes/JUPITER/Media/"

run_rsync() {
    STRING="/usr/bin/rsync -a --progress --stats --human-readable --delete \"$1\" \"$2\""
    echo $STRING
    eval $STRING
}

if [ -n "$TMUX" ]; then
    if [ -d "$DEST" ]; then
        for ((i = 0; i < ${#SRC[@]}; i++)); do
            if [ -d "$DEST" ]; then
                echo "=> ${SRC[$i]}"
                run_rsync "${SRC[$i]}" "${DEST}"
            else
                echo "=> source: ${SRC[$i]} not available"
            fi
        done
    else
        echo "=> $DEST not available"
    fi
else
    echo 'ERROR: better run this in tmux'
    exit 1
fi
