LAUNCHAGNETSDIR="$HOME/Library/LaunchAgents"
# Mac OS X
export HTTPROOT="$HOME/src/"
# export JAVA_HOME=`/usr/libexec/java_home`
# export PATH=$PATH:"/usr/local/bin":"$JAVA_HOME/bin":"/usr/local/share/aclocal":"/usr/libexec"

if type "gdate" &>/dev/null; then
  export OSX_DATE="/usr/local/bin/gdate"
else
  export OSX_DATE="/bin/date"
fi

if type "gls" &>/dev/null; then
  export OSX_LS="/usr/local/bin/gls --color --time-style long-iso"
else
  export OSX_LS="/bin/ls"
fi

if type "gsed" &>/dev/null; then
  export OSX_SED="/usr/local/bin/gsed"
else
  export OSX_SED="/usr/bin/sed"
fi

alias pdate="$OSX_DATE '+DATE: %Y-%m-%d%nTIME: %H:%M:%S'"
alias ls="$OSX_LS -hF"
alias ll="$OSX_LS -lhGp"
alias sed="$OSX_SED"

# -A list all but not . and ..
# -l long format
# -h human readable
# -G no group name
# -p append "/" to directories
alias lll="$OSX_LS -lhGpA"

macos_set_hostname() {
  if [[ $# -eq 0 ]]; then
    exit
  else
    scutil --set ComputerName "$1"
    scutil --set LocalHostName "$1"
    scutil --set HostName "$1"
  fi
}

_restart_launchctl() {
  local plist="$LAUNCHAGNETSDIR/$1"
  launchctl unload -w $plist
  launchctl load -w $plist
}

restart_pgbouncer() {
  _restart_launchctl "homebrew.mxcl.pgbouncer.plist"
}

restart_postgres() {
  _restart_launchctl "postgres.plist"
}

restart_httpd() {
  nginxplist="/System/Library/LaunchDaemons/homebrew.mxcl.nginx.plist"
  phpfpmplist="$HOME/Library/LaunchAgents/org.php.fpm.plist"
  sudo launchctl unload /System/Library/LaunchDaemons/homebrew.mxcl.nginx.plist
  sudo launchctl load /System/Library/LaunchDaemons/homebrew.mxcl.nginx.plist
  launchctl unload $phpfpmplist
  launchctl load $phpfpmplist
}
#source $(brew --prefix php-version)/php-version.sh && php-version 5

# brew
if [[ -f $(which brew) ]] && [[ "$SHELL" == $(which bash) ]]; then
  # homebrew bash commpletion
  #[[ -r /usr/local/etc/bash_completion ]] && source /usr/local/etc/bash_completion
  if [[ -f "$(brew --prefix)/etc/bash_completion" ]]; then
    . "$(brew --prefix)/etc/bash_completion"
  fi

  # NVM
  if type "nvm" &>/dev/null; then
    export NVM_DIR="$HOME/.nvm"
    source "$(brew --prefix nvm)/nvm.sh"
  fi
fi

if [[ -f "$(brew --prefix)/etc/profile.d/z.sh" ]]; then
  . $(brew --prefix)/etc/profile.d/z.sh
fi

#if which lunchy &>/dev/null; then
if [[ -f $(which lunchy) ]]; then
  LUNCHY_DIR=$(dirname $(gem which lunchy))/../extras
  LUNCHY_COMPLETION_FILE=$LUNCHY_DIR/lunchy-completion.bash
  if [ -f $LUNCHY_COMPLETION_FILE ]; then
    . $LUNCHY_COMPLETION_FILE
  fi
fi

#
# launchctl completion
# ====================
#
# Bash completion support for launchctl (mostly)
#
#
# Installation
# ------------
#
#  1. Install this file. Either:
#
#     a. Place it in a `bash-completion.d` folder:
#
#        * /etc/bash-completion.d
#        * /usr/local/etc/bash-completion.d
#        * ~/bash-completion.d
#
#     b. Or, copy it somewhere (e.g. ~/.launchctl-completion.sh) and put the following line in
#        your .bashrc:
#
#            source ~/.launchctl-completion.sh
#
#
#
# The Fine Print
# --------------
#
# Copyright (c) 2010 [Justin Hileman](http://justinhileman.com)
#
# Distributed under the [MIT License](http://creativecommons.org/licenses/MIT/)

__launchctl_list_labels() {
  launchctl list | awk 'NR>1 && $3 !~ /0x[0-9a-fA-F]+\.(anonymous|mach_init)/ {print $3}'
}

__launchctl_list_started() {
  launchctl list | awk 'NR>1 && $3 !~ /0x[0-9a-fA-F]+\.(anonymous|mach_init)/ && $1 !~ /-/ {print $3}'
}

__launchctl_list_stopped() {
  launchctl list | awk 'NR>1 && $3 !~ /0x[0-9a-fA-F]+\.(anonymous|mach_init)/ && $1 ~ /-/ {print $3}'
}
_launchctl() {
  COMPREPLY=()
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local prev="${COMP_WORDS[COMP_CWORD - 1]}"

  # Subcommand list
  local subcommands="load unload submit remove start stop list help"
  [[ ${COMP_CWORD} -eq 1 ]] && {
    COMPREPLY=($(compgen -W "${subcommands}" -- ${cur}))
    return
  }

  case "$prev" in
  remove | list)
    COMPREPLY=($(compgen -W "$(__launchctl_list_labels)" -- ${cur}))
    return
    ;;
  start)
    COMPREPLY=($(compgen -W "$(__launchctl_list_stopped)" -- ${cur}))
    return
    ;;
  stop)
    COMPREPLY=($(compgen -W "$(__launchctl_list_started)" -- ${cur}))
    return
    ;;
  load | unload)
    COMPREPLU=($(compgen -d $(pwd)))
    return
    ;;
  esac
}

complete -F _launchctl launchctl
