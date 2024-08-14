#!/bin/bash
EMAIL="ecds_9@kindle.cn"
SUBJECT="kindle document"

# if mutt and postfix working
# echo -n | mutt -a "$1" -s "$1" -e "my_hdr From:d@tux.im" -- ecds_9@kindle.cn

[ "${MAILGUN_KEY}" ] ||
    {
        echo "Exiting, mailgun key wasn't set" 1>&2
        exit 1
    }
[ "${MAILGUN_API_BASE_URL}" ] ||
    {
        echo "Exiting, mailgun api base wasn't set" 1>&2
        exit 2
    }

# mailgun "email subject" "sendto@email.tld" "email content"
curl --user "api:${MAILGUN_KEY}" \
    "${MAILGUN_API_BASE_URL}/messages" \
    -F from="${MAILGUN_POSTMASTER}" \
    -F to="${EMAIL}" \
    -F subject="${SUBJECT}" \
    -F text="${SUBJECT}" \
    -F attachment="@${1}"
