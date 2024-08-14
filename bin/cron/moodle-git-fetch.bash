#!/bin/bash

GITLOG="/var/log/moodle/gitfetch.log"
TMPFILE="/tmp/moodlegitupdate.log"
SUBJECT="Moodle code"
EMAIL="moodlecode@tux.im"
FROMEMAIL="git@tux.im"

MOODLEDIRROOT="/srv/http/moodle"

date >>$GITLOG

cd "$MOODLEDIRROOT"
git fetch pi >>$TMPFILE 2>&1

for mver in {23..26}; do
    MOODLEPATH="$MOODLEDIRROOT${mver}"
    GITBRANCH="MOODLE_${mver}_STABLE"
    cd $MOODLEPATH
    git checkout -q "$GITBRANCH"
    git fetch -q pi
    git rebase "pi/${GITBRANCH}" >>$TMPFILE 2>&1
done

cat -v $TMPFILE | mail -r "${FROMEMAIL}" -s "$SUBJECT" $EMAIL

rm -f $TMPFILE
