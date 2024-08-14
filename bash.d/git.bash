alias gm='git submodule'

git_commit_date() {
  commitdate=$1
  authordate=$1
  echo "Commit date: $commitdate"
  echo "Author date: $authordate"
  GIT_COMMITTER_DATE="$commitdate" git commit --date "$authordate"
}

git_fix_commit_date() {
  rewrite_commit_date $(git rev-parse HEAD) $(git log -1 --format=%ad)
}

git-update-dev-branch() {
  # git fetch <remote> <remoteBranch>:<localBranch>
  git fetch origin develop:develop
}

git_purge_branches() {
  git branch | xargs git branch -D
}

function parse_git_dirty() {
  [[ $(git status 2>/dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch() {
  git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

function git_clone_or_update() {
  local repo=$1
  local path=$2
  local branch=$3
  if [ -d $path ]; then
    echo '^^^^^ Updating' $repo
    cd $path
    git pull
  else
    echo '+++++ Cloning' $repo
    if [ -n $branch ]; then
      git clone $repo -b $branch $path
    else
      git clone $repo $path
    fi
  fi
}
