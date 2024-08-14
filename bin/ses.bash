#!/bin/bash

[ "${AWS_ACCESS_KEY_ID}" ] ||
    {
        echo "Exiting, aws secret key wasn't set"
        exit 1
    }
[ "${AWS_SECRET_ACCESS_KEY}" ] ||
    {
        echo "Exiting, aws access key wasn't set"
        exit 2
    }

SUBJECT=${1:-'Test Mail'}
FROM="amazon-ses@tux.im"
TO=${2:-'heydcai@gmail.com'}
MESSAGE=${3:-'Awesome Email'}

date=$(gdate -R)
#date=$(date +"%a, %d %b %Y %H:%M:%S %Z")
priv_key="$AWS_ACCESS_KEY_ID"
access_key="$AWS_SECRET_ACCESS_KEY"
# linux base64 bin needs `-w 0` to disable wrapping
signature="$(echo -n "$date" |
    openssl dgst -sha256 -hmac "$priv_key" -binary |
    gbase64 -w 0)"

auth_header="X-Amzn-Authorization: AWS3-HTTPS AWSAccessKeyId=$access_key, Algorithm=HmacSHA256, Signature=$signature"
endpoint="https://email.us-east-1.amazonaws.com/"

action="Action=SendEmail"
source="Source=$FROM"
to="Destination.ToAddresses.member.1=$TO"
subject="Message.Subject.Data=$SUBJECT"
message="Message.Body.Text.Data=$MESSAGE"

curl -v -X POST -H "Date: $date" -H "$auth_header" --data-urlencode "$message" --data-urlencode "$to" --data-urlencode "$source" --data-urlencode "$action" --data-urlencode "$subject" "$endpoint"
