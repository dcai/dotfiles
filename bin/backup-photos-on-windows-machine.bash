#!/bin/bash

## this is the seagate 2t hard drive
SRC=(
    '/mnt/h/Media/'
)

# backup the files to 4t wd red backup disk
DEST="/mnt/j/Media/"

run_rsync() {
    STRING="/usr/bin/rsync -aP --stats --human-readable --delete \"$1\" \"$2\""
    echo $STRING
    # eval $STRING
}

if [ -n "$TMUX" ]; then
    if [ -d "$DEST" ]; then
        for ((i = 0; i < ${#SRC[@]}; i++)); do
            if [ -d "$DEST" ]; then
                echo "=> ${SRC[$i]}"
                run_rsync "${SRC}" "${DEST}"
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
