#!/bin/bash

PHPBIN=/usr/bin/php
TOEMAIL=moodle@tux.im
FROM=moodlecron@tux.im
TMPFILE=/tmp/moodle_cron_output.log
SUBJECT="Moodle Cron"

for moodleversion in {23..26}; do
    MOODLECRON="/srv/http/moodle${moodleversion}/admin/cli/cron.php"
    MOODLEUPGRADE="/srv/http/moodle${moodleversion}/admin/cli/upgrade.php"
    LOG="/var/log/moodle/cron_moodle_${moodleversion}.log"
    if [[ -f $MOODLECRON ]]; then
        echo "##Moodle ${moodleversion} Upgrade##" &>>$TMPFILE
        $PHPBIN $MOODLEUPGRADE --non-interactive --allow-unstable &>>$TMPFILE
        echo "##Moodle ${moodleversion} Cron##" &>>$TMPFILE
        $PHPBIN $MOODLECRON &>>$TMPFILE
    fi
done

cat -v $TMPFILE | mail -r "${FROM}" -s "$SUBJECT" $TOEMAIL
rm -f $TMPFILE

exit 0
