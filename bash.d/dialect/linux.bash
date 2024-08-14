# Linux
export JAVA_HOME='/usr/lib/jvm/java-8-oracle'
export HTTPROOT="/var/www"
export PATH=$PATH:"$JAVA_HOME/bin"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
#export XMODIFIERS="@im=ibus"
#export GTK_IM_MODULE="ibus"
#export QT_IM_MODULE="ibus"
#export XIM=ibus
# -h Human readable size
# -G Don't print group names
# -p Append / to dir
# -F Append */=>@| to entries
# -A List all except . and ..
alias ls='ls -hF --color'
alias ll='ls -lhpF --color'
alias lll='ls -lhpFA --color'
alias open='xdg-open'
alias makepkg="makepkg --skipinteg"
# Add an "alert" alias for long running commands.  Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias xclip='xclip -selection clipboard'

#alias fixaudio="alsactl -f /var/lib/alsa/asound.state store"
#fixaudio() {
#sudo alsactl -f /var/lib/alsa/asound.state store
#}

turnoffs() {
  #xset -dpms          # Disable DPMS
  #xset +dpms          # Enable DPMS
  #xset s off          # Disable screen blanking
  #xset s 150          # Blank the screen after 150 seconds
  #xset dpms 300 600 900       # Set standby, suspend, & off times (in seconds)
  #xset dpms force standby     # Immediately go into standby mode
  #xset dpms force suspend     # Immediately go into suspend mode
  #xset dpms force off     # Immediately turn off the monitor
  #xset -q             # Query current settings

  #setterm -blank 10           # Blank the screen in 10 minutes
  #setterm -powersave on       # Put the monitor into VESA power saving mode
  #setterm -powerdown 20       # Set the VESA powerdown to 20 minutes
  xset dpms force off -display :0
}

rv() {
  #ffmpeg -r 30 -f alsa -i default -f v4l2 -s 1280x1024 -i /dev/video0 out.avi > /dev/null 2> /dev/null &
  #ffmpeg -r 30 -f alsa -i default -f v4l2 -i /dev/video0 out.avi > /dev/null 2> /dev/null &
  ffmpeg -f alsa -i default -f v4l2 -i /dev/video0 -vcodec libx264 -preset ultrafast -qp 0 -acodec copy -bufsize 400336k out.mkv >/dev/null 2>/dev/null &

}

# linuxbrew: begin
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
ZPATH="$HOME/.linuxbrew/etc/profile.d/z.sh"
[ -f $ZPATH ] && source "$ZPATH"
# linuxbrew: end
