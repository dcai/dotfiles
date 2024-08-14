#!/bin/bash

INFILE=$1
FILENAME=$(basename "$INFILE")

if [[ -z $1 ]]; then
    mkdir small
    mogrify -monitor -path small/ -resize 60x60% ./*.jpg
    exit 0
fi

mogrify -monitor -write "small-$FILENAME" -resize 60x60% "$INFILE"
