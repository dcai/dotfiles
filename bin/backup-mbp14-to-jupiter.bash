#!/bin/bash
SRC=(
    "$HOME/Desktop"
    "$HOME/Downloads"
    "$HOME/Documents"
    "$HOME/Pictures"
    "$HOME/Music"
    "$HOME/Dropbox"
    "$HOME/src"
)

# RSMV="rsync -ahW --progress --stats --remove-sent-files"
# RSCP="rsync -ahWu --progress"
DEST='/Volumes/JUPITER/backups/duck/'

RSCP() {
    # CMD="rsync --exclude 'node_modules' -a --no-perms --no-owner --no-group --progress --stats --human-readable --delete '$1' '$2'"
    CMD="rsync --exclude 'node_modules' -a --size-only --progress --stats --human-readable --delete '$1' '$2'"
    echo "$CMD"
    eval "$CMD"
}

if [ -d "$DEST" ]; then
    for ((i = 0; i < ${#SRC[@]}; i++)); do
        if [ -d "${SRC[$i]}" ]; then
            RSCP "${SRC[$i]}" "${DEST}"
        fi
    done
else
    date
    echo "=> $DEST not available"
fi

# if [ -n "$TMUX" ]; then
#     if [ -d "$DEST" ]; then
#         for ((i = 0; i < ${#SRC[@]}; i++)); do
#             RSCP "${SRC[$i]}" "${DEST}"
#         done
#     else
#         echo "=> $DEST not available"
#     fi
# else
#     echo 'ERROR: better run this in tmux'
#     exit 1
# fi
# RSCP "$HOME/.local" "${DEST}/local"
