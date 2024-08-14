#!/bin/bash

# Your github username
github_user="dongsheng"
# The remote name of your github repo, it usually origin
github_remote_name="github"

### STOP CONFIG SINCE HERE! ###
github_diff_root="https://github.com/$github_user/moodle/compare/"

export BLUE="\033[1;34m"
export CLROFF="\033[0;0m"

function parse_git_branch() {
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"
}

function parse_git_branch_version() {
    parse_git_branch | sed -e 's/\(.*\)_\(.*\)$/\2/'
}
function parse_git_branch_prefix() {
    parse_git_branch | sed -e 's/\(.*\)_\(.*\)$/\1/'
}
function parse_issue_number() {
    parse_git_branch | sed -e 's/\(.*\)_\([A-Z]*\)\-\([0-9]*\)_\(.*\)/\2-\3/'
}

function status() {
    echo -e ":: $1 ::"
}

function process_msg() {
    echo -e "=> $1"
}

current_branch=$(parse_git_branch)
case "$1" in
    update)
        status "You were on branch ${current_branch}"
        declare -a remote_repos
        remote_repos=($(git remote | tr "\n" " "))
        #echo ${remote_repos[@]}
        git fetch upstream
        #for repo in ${remote_repos[@]}; do
        #echo "=> Updating $repo"
        #`git fetch "$repo" -q`
        #done
        process_msg "Saving stash"
        git stash save

        process_msg "Updating master"
        git checkout master
        git merge upstream/master

        process_msg "Updating 25 branch"
        git checkout MOODLE_25_STABLE
        git merge upstream/MOODLE_25_STABLE

        process_msg "Updating 24 branch"
        git checkout MOODLE_24_STABLE
        git merge upstream/MOODLE_24_STABLE

        process_msg "Updating 23 branch"
        git checkout MOODLE_23_STABLE
        git merge upstream/MOODLE_23_STABLE

        process_msg "Pushing master to github"
        git push $github_remote_name refs/remotes/upstream/master:master

        process_msg "Pushing 25 to github"
        git push $github_remote_name refs/remotes/upstream/MOODLE_25_STABLE:MOODLE_25_STABLE

        process_msg "Pushing 24 to github"
        git push $github_remote_name refs/remotes/upstream/MOODLE_24_STABLE:MOODLE_24_STABLE

        process_msg "Pushing 23 to github"
        git push $github_remote_name refs/remotes/upstream/MOODLE_23_STABLE:MOODLE_23_STABLE

        git checkout $current_branch

        git stash pop
        ;;
    push)
        if [[ -z $2 ]]; then
            echo "Please provide a remote name"
        else
            git fetch upstream
            git push $2 refs/remotes/upstream/master:master
            git push $2 refs/remotes/upstream/MOODLE_24_STABLE:MOODLE_24_STABLE
            git push $2 refs/remotes/upstream/MOODLE_23_STABLE:MOODLE_23_STABLE
            git push $2 refs/remotes/upstream/MOODLE_22_STABLE:MOODLE_22_STABLE
        fi
        ;;
    info)
        # My repo
        echo -e "Repo: [${BLUE}git://github.com:$github_user/moodle.git${CLROFF}]"

        # master branch name
        echo -e "[${BLUE}${current_branch}${CLROFF}]"
        if [ $(parse_git_branch_version) = "master" ]; then
            # master branch diff
            echo "${github_diff_root}master...$(parse_git_branch)"

            # 22 branch
            echo -e "[${BLUE}$(parse_git_branch_prefix)_22${CLROFF}]"
            echo "${github_diff_root}MOODLE_22_STABLE...$(parse_git_branch_prefix)_22"

            # 21 branch
            echo -e "[${BLUE}$(parse_git_branch_prefix)_21${CLROFF}]"
            echo "${github_diff_root}MOODLE_21_STABLE...$(parse_git_branch_prefix)_21"

            # 20 branch
            echo -e "[${BLUE}$(parse_git_branch_prefix)_20${CLROFF}]"
            echo "${github_diff_root}MOODLE_20_STABLE...$(parse_git_branch_prefix)_20"
        else
            echo "Please switch to the branch based on master to see info"
            echo -e "EOF"
        fi
        ;;
    top)
        status "Latest commit on ${BLUE}[$current_branch]${CLROFF}"
        git log --format=%H | head -1
        ;;
    create)
        git stash save
        git checkout -b "$2_$3_$4_master" upstream/master
        git checkout -b "$2_$3_$4_24" upstream/MOODLE_24_STABLE
        git checkout -b "$2_$3_$4_23" upstream/MOODLE_23_STABLE
        git checkout $current_branch
        git stash pop
        ;;
    issue)
        open "http://tracker.moodle.org/browse/$(parse_issue_number)"
        ;;
    credit)
        git log --format='%aN <%aE>' | awk '{arr[$0]++} END{for (i in arr){print arr[i], i;}}' | sort -rn | cut -d\  -f2-
        ;;
    *)
        #git status > /dev/null 2>&1
        git status &>/dev/null
        if [[ $? -eq 0 ]]; then
            status "You are on branch ${current_branch}"
        else
            echo "This is not moodle git repository"
        fi
        ;;
esac
