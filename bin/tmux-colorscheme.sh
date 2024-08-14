#!/bin/sh

tmux set-option status-style "bg=#f35b04,fg=white"
tmux set-option status-left "#[bg=#f7b801,fg=black,dim][#S]#[default] " # this is tmux session name
tmux set-option status-right "#[bg=#f7b801,fg=black] %d %h #[bg=#f35b04,fg=white] %H:%M:%S #[default]"
