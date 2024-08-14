#!/bin/bash

if [[ $# -lt 1 ]]; then
    echo 'Run: git-fix-author.bash --author dcai --email d@tux.im'
    exit
fi

## START Parse arguments
POSITIONAL=()
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        --author)
            AUTHOR="$2"
            shift
            shift
            ;;
        --email)
            EMAIL="$2"
            shift
            shift
            ;;
        *)                     # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift              # past argument
            ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters
## END Parse arguments

FILTER="
  GIT_AUTHOR_NAME='${AUTHOR}'
  GIT_AUTHOR_EMAIL='${EMAIL}'
  GIT_COMMITTER_NAME='${AUTHOR}'
  GIT_COMMITTER_EMAIL='${EMAIL}'
"

read -p "Are you sure? (y/n) " -n 1 -r
if [[ $REPLY == 'y' ]]; then
    git filter-branch -f --env-filter "${FILTER}" HEAD
fi
