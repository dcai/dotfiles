#!/bin/bash

GIST_TOKEN=$(kv get "GITHUB_GIST")

if [ -z "$GIST_TOKEN" ]; then
    FILENAME=$(basename $0)
    echo "${FILENAME}: GITHUB_GIST not set"
    exit 1
fi

API_VERSION="2022-11-28"
CONTENT_TYPE="application/vnd.github+json"

curl_call() {
    METHOD=$1
    URL=$2
    BODY=$3
    curl -s -L \
        -X "$METHOD" \
        -H "Accept: ${CONTENT_TYPE}" \
        -H "Authorization: Bearer ${GIST_TOKEN}" \
        -H "X-GitHub-Api-Version: ${API_VERSION}" \
        "$URL" --data "$BODY"

}
list_gist() {
    curl_call GET https://api.github.com/gists
}
update_gist() {
    GIST_ID=$1
    FILENAME=$2
    FILE_CONTENT=$3
    JSON_STRING=$(jq -n \
        --arg filename "$FILENAME" \
        --arg content "$FILE_CONTENT" \
        '{files: {$filename: {content: $content}}}')

    curl_call PATCH "https://api.github.com/gists/${GIST_ID}" "$JSON_STRING"
}

print_and_run_cmd() {
    cmd=$1
    echo "==> $cmd"
    eval "$cmd"
}

# list_gist
value=$(<"${HOME}/.tmux.conf")
update_gist "3824286" "tmux.conf-3.x" "${value}"
update_gist "1274526" "setup-macos.bash" "$(<"$HOME/.bin/setup-macos.bash")"
update_gist "2885623" "config" "$(<"$HOME/.config/git/config")"
update_gist "2667196" ".vimrc" "$(<"$HOME/.vim/mini-rc.vim")"
