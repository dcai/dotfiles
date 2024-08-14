#!/bin/bash

MARKDOWN=markdown
MKD2HTML=mkd2html

FORCE="$1"
SYNTAX="$2"
EXTENSION="$3"
OUTPUTDIR="$4"
INPUT="$5"
CSSFILE="$6"
TMP1=/tmp/vimwiki1.tmp
TMP2=/tmp/vimwiki2.tmp

FORCEFLAG=

[[ $FORCE -eq 0 ]] || { FORCEFLAG="-f"; }
[[ $SYNTAX == "markdown" ]] || {
    echo "Error: Unsupported syntax"
    exit -2
}

OUTPUT="$OUTPUTDIR"/$(basename "$INPUT" .$EXTENSION).html

DIRNAME=$(dirname "$INPUT")
ROOT_PATH=./

COUNTER=0
while [ ! -f "${DIRNAME}/.root" ]; do
    DIRNAME=$(dirname "$DIRNAME")
    ROOT_PATH=${ROOT_PATH}../
    let COUNTER=COUNTER+1
done

sed -e 's#\[\[\(.*\)|\(.*\)\]\]#[\2](\1.html)#g' "$INPUT" >$TMP1
sed -e 's#\[\[\(.*\)\]\]#[\1](\1.html)#g' $TMP1 >$TMP2

TITLE=$(basename "$INPUT" .$EXTENSION)
CONTENT=$($MARKDOWN "${TMP2}" -T -f +toc,+links,+image)

HTML="<!DOCTYPE html><html><head><link href='${ROOT_PATH}style.css' rel='stylesheet'><title>${TITLE}</title></head><body>${CONTENT}</body></html>"

echo $HTML >"$OUTPUT"

rm -rf ${TMP1} ${TMP2}
