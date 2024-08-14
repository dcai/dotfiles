#!/bin/sh

DIR=$1
BRANCH=${2-'main'}

cd "$DIR" || exit 1
if [ -n "$(git status --porcelain)" ]; then
    git add .
    TT=$(date +"%Y-%m-%d")
    git commit -am "$TT update"
    git pull -r -q
    git push origin "$BRANCH" -u
fi
