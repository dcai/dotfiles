#!/bin/bash
RESERVED='master\|develop'
PREFIX='LRN-*'

while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        --prefix)
            PREFIX="$2"
            shift
            shift
            ;;
        *) ;;

    esac
done

BRANCHES=$(git branch --no-color --list "${PREFIX}*" | grep -v "${RESERVED}" | xargs)

read -r -a branchesArray <<<"$BRANCHES"
for b in "${branchesArray[@]}"; do
    echo "$b"
done
read -p "Are you sure? (y/n) " -n 1 -r

echo $BRANCHES
if [[ $REPLY == 'y' ]]; then
    echo "$BRANCHES" | xargs git branch -D
fi
