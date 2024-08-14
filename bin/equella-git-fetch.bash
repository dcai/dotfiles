#!/bin/bash

GITLOG="/var/log/equella/cron-update.log"
LOGFILE="/tmp/equellacodeupdate.log"
HTMLFILE="/tmp/equellacodeupdate.html"
EMAILADDR="equellacode@tux.im"
FROMEMAILADDR="git@tux.im"
SUBJECT="EQUELLA code"

EQSRC=/var/equella-source/
EQTESTSRC=/home/dcai/src/equella-automated-tests

cd "$EQTESTSRC"
git fetch upstream -q -p

cd "$EQSRC"
git fetch upstream -q -p &>$LOGFILE

if [[ -s $LOGFILE ]]; then
    echo -n &>>$LOGFILE
    date "+%d/%m/%Y %H:%M" &>>$GITLOG
    echo "##################" &>>$LOGFILE
    echo "" &>>$LOGFILE
    cd "$EQSRC"
    git diff master upstream/master &>>$LOGFILE
    echo "" &>>$LOGFILE
    echo "##################" &>>$LOGFILE
    if which mutt &>/dev/null; then
        echo '<html><head></head><body><pre style="font-size: 12px">' >"${HTMLFILE}"
        cat -v $LOGFILE >>"${HTMLFILE}"
        echo "</pre></body></html>" >>"${HTMLFILE}"
        cat -v "${HTMLFILE}" | /usr/bin/mutt -e 'set content_type="text/html"' -e "my_hdr From:${FROMEMAILADDR}" "${EMAILADDR}" -s "$SUBJECT"
        rm $HTMLFILE
    else
        cat -v $LOGFILE | mail -r "${FROMEMAILADDR}" -s "$SUBJECT" "${EMAILADDR}"
    fi
fi

#rm -f $LOGFILE
