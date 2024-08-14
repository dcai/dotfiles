#!/bin/bash

SRCDIR="$HOME/Dropbox/etc"
STAGINGDIR=/tmp/staging
XDGDIR="${STAGINGDIR}/.config"
mkdir -p "$XDGDIR"

cd "$STAGINGDIR"

cp -r "$SRCDIR/bash.d" .bash.d
cp -r "$SRCDIR/vim" .vim
cp -r "$SRCDIR/tmux.conf" .tmux.conf
cp -r "$SRCDIR/git" "$XDGDIR/git"
ln -s .bash.d/bashrc .bashrc

tar czvf /tmp/dot_files.tar.gz .bash.d .vim .tmux.conf .config
