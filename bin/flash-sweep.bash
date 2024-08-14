#!/bin/bash

SRCDIR="$HOME/Downloads/firmware"
SIDE=${1-"left"}
DESTDIR=${2-"/Volumes/NICENANO/"}
RESET_FW='settings_reset-nice_nano_v2-zmk.uf2'

FW=

if [[ $SIDE == "left" ]] || [[ $SIDE == "right" ]]; then
    FW="cradio_${SIDE}-nice_nano_v2-zmk.uf2"
fi

if [[ $SIDE == "reset" ]]; then
    FW=$RESET_FW
fi

if [[ -z $FW ]]; then
    echo "❌ No firmware found"
    exit 1
fi

cmd="cp $SRCDIR/$FW $DESTDIR"
echo "> $cmd"

read -p "⁉️  Are you sure? (y to confirm) " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

eval "$cmd"
echo "✅"
