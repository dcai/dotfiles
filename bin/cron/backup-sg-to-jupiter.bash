#!/bin/bash
DEST="/Volumes/JUPITER"
FLIST=(
    '/Volumes/2TSTOR/Media'
    # '/Users/dcai/Music/iTunes'
)
ARGV='-av'

if [[ $# -gt 0 ]]; then
    # silence output when more than 0 arg provided
    # P stands for --progress --partial
    ARGV='-aP'
fi

run_rsync() {
    STRING="/usr/bin/rsync -aP --stats --human-readable --delete \"$1\" \"$2\""
    echo $STRING
    eval $STRING
}

if [ -d "$DEST" ]; then
    for ((i = 0; i < ${#FLIST[@]}; i++)); do
        echo "=> ${FLIST[$i]}"
        run_rsync "${FLIST[$i]}" "$DEST"
    done
else
    echo "=> $DEST not available"
fi
