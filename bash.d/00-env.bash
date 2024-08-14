# If not running interactively, don't do anything

case $- in
*i*) ;;
*) return ;;
esac

shopt -s nocaseglob

# fonts conf: $XDG_CONFIG_HOME/fontconfig/fonts.conf
export CFLAGS="-Wall"
export GOPATH="$HOME/go"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
#export LSCOLORS=DxGxcxdxCxegedabagacad
#export GPG_TTY=`tty`
export DISPLAY=localhost:0.0
export TIME_STYLE=long-iso
export HISTCONTROL=ignoreboth
export HISTFILESIZE=5000
export HISTSIZE=5000
export HISTIGNORE="ls:ll:cd"
export MAILCHECK=0
export PAGER=less
export LESS='-RainMw'
export LESSOPEN='|pygmentize %s'
export VISUAL=vim
export EDITOR="$VISUAL"
export CVS_RSH=ssh
export SCREENRC="$HOME/.screenrc"
export SBT_OPTS="-XX:+CMSClassUnloadingEnabled"
export JAVA_OPT="-Xrs -Xms1280m -Xmx5120m -XX:MaxPermSize=1280m -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv6Addresses=false -Djava.net.preferIPv4Stack=true -Djava.awt.headless=true -XX:MaxGCPauseMillis=500 -XX:NewRatio=3 -XX:GCTimeRatio=16 -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:CMSInitiatingOccupancyFraction=70"

# system path
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH"
# .local
PATH="$HOME/.local/bin:$PATH"
# .local/share
PATH="$HOME/.local/share/bin:$PATH"
# node
PATH="$HOME/.npm-packages/bin:$PATH"
# python
PATH="$HOME/Library/Python/3.6/bin:$HOME/Library/Python/3.6/bin:$HOME/Library/Python/2.7/bin:$PATH"
# dropbox
PATH="$HOME/Dropbox/bin:$PATH"
# php composer
PATH="$HOME/.composer/vendor/bin:$PATH"
# fzf
PATH="$HOME/.fzf/bin:$PATH"
# ruby
if which ruby >/dev/null && which gem >/dev/null; then
  PATH="$(ruby -r rubygems -e "puts Gem.user_dir")/bin:$PATH"
fi
# go
PATH="$GOPATH/bin:$PATH"
