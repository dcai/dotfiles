# alias ncdu="ncdu --confirm-quit"
alias curl="curl --insecure"
alias dl="aria2c --check-certificate=false"
alias aria2c="aria2c --check-certificate=false"
alias wget="wget --no-check-certificate"
# pip install --user pygments
alias json_pretty_print='python -mjson.tool | pygmentize -l javascript'
alias mv="mv -i"
alias cp="cp -r"
alias df='df -H'
alias du='du -sh'
alias diff='colordiff -u'
alias grep='grep --color'
alias free='free -h'
alias sss='goto'
alias ag="ag -U --noheading --ignore-dir 'vendor' --ignore-dir 'node_modules' --ignore 'bundle.js'"
alias iftop="iftop -P -N -b -B"
alias netstat="netstat -ln -f inet"
alias pdate='date "+DATE: %Y-%m-%d%nTIME: %H:%M:%S"'
alias pan="cd /Volumes/saturn/Baidu/百度云同步盘 && (date && du && du -sm)  >> ~/Desktop/pan.log && tail -n12 ~/Desktop/pan.log"
alias e="emacs -nw -q -l ~/.emacs.d/init.el"
alias ec='emacsclient -t'
alias killemacs='emacsclient --eval "(kill-emacs)"'

# use dots to go to parent directories
dots_cmd='..'
dots_path='./../'
# shellcheck disable=SC2034
for dots_counter in {1..5}; do
  eval "alias ${dots_cmd}='cd ${dots_path}'"
  dots_path="${dots_path}../"
  dots_cmd="${dots_cmd}."
done

curl-download() {
  curl -#vOL "$1"
}

goto() {
  if [[ $# -eq 1 ]]; then
    DIR=${HTTPROOT:-/Users/dcai/src}/$1
  elif [[ $# -eq 2 ]]; then
    if [[ "$1" == "api" ]]; then
      DIR="$HOME/salt-developer/code/api/$2"
    elif [[ "$1" == "site" ]]; then
      DIR="$HOME/salt-developer/code/site/$2"
    else
      DIR="$HOME/salt-developer/code/$1/$2"
    fi
  else
    DIR=$HTTPROOT
  fi

  if [[ -d $DIR ]]; then
    echo "Entering \"${DIR}\""
    cd "$DIR" || exit
  else
    echo "\"${DIR}\" doesn't exist"
  fi
}

send-test-mail() {
  swaks --auth --server smtp.mailgun.org \
    --au postmaster@tux.im --ap 2146e7ce5c7d04e4aca699d33d8b711e \
    --from send-test-mail-swaks@tux.im \
    --to d@tux.im \
    --h-Subject: "Hello" \
    --body 'Test email my awesome bash'
}

syncwiki() {
  s3cmd sync --delete-removed --exclude "push.sh" --exclude 'diary/*' --exclude 'templates/*' ~/.vimwiki_html/ s3://wiki.dongsheng.org/
}

pscheck() {
  ps aux | pgrep "$1" | grep -v grep
}

mounttc() {
  sudo echo -n
  if [[ -z $1 ]]; then
    SERVER="10.0.1.1"
  else
    SERVER="$1"
  fi
  if [[ -z $2 ]]; then
    SHARENAME="Data"
  else
    SHARENAME="$2"
  fi
  if [[ -z $3 ]]; then
    LOCALPATH="$HOME/smb/$3"
  else
    LOCALPATH="$3"
  fi
  if [ ! -d "$LOCALPATH" ]; then
    mkdir -p "$LOCALPATH"
  fi
  echo "Mounting //${SERVER}/${SHARENAME} to ${LOCALPATH}"
  OPT="username=dcai,password=cds,rw,noperm,uid=dcai,file_mode=0777,dir_mode=0777,sec=ntlm"
  # smbclient -L 10.0.1.1
  sudo mount -t cifs "//${SERVER}/${SHARENAME}" "${LOCALPATH}" -o "$OPT" >/dev/null 2>/dev/null
}

mountallsmb() {
  mounttc 10.0.1.1 Drive "$HOME/smb/tc"
  mounttc pi saturn "$HOME/smb/saturn"
  mounttc pi jupiter "$HOME/smb/jupiter"
  #mounttc 10.0.1.109 x "$HOME/smb/winxp";
}

postgres84() {
  SOCKDIR=/tmp/pg84
  if [[ ! -d $SOCKDIR ]]; then
    mkdir -p $SOCKDIR
  fi
  "$HOME/.local/opt/postgres84/bin/postgres" -D "$HOME/.local/opt/postgres84/data"
}

postgres94() {
  SOCKDIR=/tmp/pg94
  if [[ ! -d $SOCKDIR ]]; then
    mkdir -p $SOCKDIR
  fi
  "$HOME/.local/opt/postgres94/bin/postgres" -D "$HOME/.local/opt/postgres94/data"
}

psql94() {
  psql -h /tmp/pg94 -p 11111 -U dcai postgres
}

# shellcheck disable=SC2086
abs_path() {
  (cd "$(dirname $1)" &>/dev/null && printf "%s/%s" "$(pwd)" "${1##*/}")
}

# -P = --progress --partial
# -a for archive, which preserves ownership, permissions etc, eques -rlptgoD
# -r recursive
# -l copy symlinks as symlinks
# -p preserve permission
# -t preserve modified time
# -u skip files that are newer on the receiver
# -h human readable output
# --no-t prevent preserve modified time
# -O == --omit-dir-times
# -h, --human-readable        output numbers in a human-readable format
# -g preserve group
# -o preserve owner
# -D preserve devices and specials
# -W is for copying whole files only, without delta-xfer algorithm which should
#    reduce CPU load
# -v is for verbose, so I can see what's happening (optional)
# -z = --compress
#alias rscp='rsync -ahW --progress --stats --no-p --no-o --no-g --omit-dir-times'
#alias rscp='rsync -ahW --progress --stats --no-compress'
#alias rsmv='rsync -ahW --progress --stats --remove-sent-files'

moodlepurge() {
  /usr/bin/php /var/www/moodle/admin/cli/purge_caches.php
}
