#!/bin/bash
ARG=${1-"fzf"}
cmd='tmux capture-pane -pJ -S - | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -r | uniq'

if [[ $ARG == 'fzf' ]]; then
    cmd="$cmd | fzf | pbcopy"
fi

eval "$cmd"
