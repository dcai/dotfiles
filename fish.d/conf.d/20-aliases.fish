if type -q gdate
    set BINDATE (which gdate)
else
    set BINDATE /bin/date
end

if type -q gls
    set BINLS (which gls)" --color --time-style long-iso"
else
    set BINLS /bin/ls
end

if type -q gsed
    set BINSED (which gsed)
else
    set BINSED sed
end

alias ls="$BINLS -hF"
alias tree="tree -C -N -I node_modules -I .git"
# -A list all but not . and ..
# -l long format
# -h human readable
# -G no group name
# -p append "/" to directories
if type -q lsd
    alias ls="lsd"
    alias l="lsd -1"
    alias ll="lsd -lh --almost-all"
    alias lls="lsd -lh --almost-all --sizesort"
    alias llsr="lsd -lh --almost-all --sizesort --reverse"
    alias tree="lsd --tree -I node_modules -I .git -I dotbot"
else
    alias l="$BINLS -lhGp"
    alias ll="$BINLS -lhGpA"
    # list files and sort by size
    alias lls="ls -lahSr"
end

alias yt="yt-dlp --cookies $HOME/youtube-cookies.txt"
alias aria2c="aria2c --check-certificate=false"
alias cp="cp -r"
alias df="df -h"
alias diff='colordiff -u'
alias du='du -sh'
alias free='free -h'
alias grep='grep --color'
alias iftop="iftop -P -N -b -B"
alias less='less -R'
alias mv="mv -i"
alias netstat="netstat -ln -f inet"
alias pdate='date "+DATE: %Y-%m-%d%nTIME: %H:%M:%S"'
alias k='kubectl'
alias sed="$BINSED"
alias tmux='tmux -2'
alias ncdu='ncdu --confirm-quit'
# alias tig='git status &>/dev/null && vim +"Gllog"'

alias np=pnpm
alias nn=npm
alias ny=yarn

if type -q bat
    alias cat='bat --theme 1337 --style plain'
end

if type -q git-forgit
    alias forgit='git-forgit'
end

# emacs
#alias e="emacs -nw"
# alias e="emacs -nw -q -l ~/.emacs.d/init.el"
# alias ec='emacsclient -t'
# alias killemacs='emacsclient --eval "(kill-emacs)"'

# Navigation
function ..
    cd ..
end
function ...
    cd ../..
end
function ....
    cd ../../..
end
function .....
    cd ../../../..
end
function ......
    cd ../../../../..
end

# Utilities
# function grep     ; command grep --color=auto $argv ; end
# function rkt      ; racket -il xrepl $argv ; end

function httpdump
    sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E "Host\: .*|GET \/.*"
end

function mypublicip
    curl -s http://checkip.dyndns.com/ | sed 's/[^0-9\.]//g'
end

function localip
    ipconfig getifaddr en0
end

function lookbusy
    cat /dev/urandom | hexdump -C
end

function tunnel
    ssh -D 8080 -C -N $argv
end

function spellcheck
    set url 'https://www.google.com/complete/search?client=hp&hl=en&xhr=t'
    curl -H 'user-agent: Mozilla/5.0' -sSG --data-urlencode "q=$argv" "$url" \
        | jq -r .[1][][0] \
        | gsed 's#</\?b>#\*#g'
end
