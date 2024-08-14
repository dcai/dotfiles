#! /bin/sh

LANG=ja_JP /usr/local/bin/7z x -y "$1" | sed -n 's/^Extracting //p' | sed '1!G;h;$!d' | xargs convmv -f shift-jis -t utf8 --notest
