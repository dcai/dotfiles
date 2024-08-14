#!/bin/bash
if [[ $# -lt 1 ]]; then
    echo "$0 \${commit-sha1} 'Apr 1 14:35:08 2024 +1000'"
    exit
fi
# http://stackoverflow.com/a/24105058/69938
# rewrite_commit_date(commit, date_string)
#
# !! Commit has to be on the current branch, and only on the current branch !!
#
# Usage example:
#
# 1. Set commit 0c935403 date to now:
#
#   rewrite_commit_date 0c935403
#
# 2. Set commit 0c935403 date to 'Dec 9 14:35:08 2017 +1100'
#
#   rewrite_commit_date 0c935403 'Dec 9 14:35:08 2017 +1100'
#
#date -R --date "$2"  &> /dev/null

commit="$1"
date_str="$2"

temp_branch="temp-rebasing-branch"
current_branch="$(git rev-parse --abbrev-ref HEAD)"

commitdate=$date_str
authordate=$date_str

git checkout -b "$temp_branch" "$commit"
GIT_COMMITTER_DATE="$commitdate" git commit --amend --date "$authordate"
git checkout "$current_branch"
git rebase "$commit" --onto "$temp_branch"
git branch -d "$temp_branch"
