#!/bin/bash

GITLOG="/tmp/gitfetch.log"
TMPFILE="/tmp/moodlegitupdate.log"

GITROOT="/home/dcai/.local/var/git"
MOODLEDIRROOT="$GITROOT/moodle.git"

date >>$GITLOG

cd "$GITROOT"
if [ ! -d "$MOODLEDIRROOT" ]; then
    git clone --mirror git@github.com:dcai/moodle.git
fi

cd "$MOODLEDIRROOT"

if ! git config remote.upstream.url >/dev/null; then
    git remote add upstream git@github.com:moodle/moodle.git
fi

git fetch upstream -q

git push origin -q
