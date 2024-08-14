#!/bin/bash

me=$(basename "$0")
if [[ -z $1 ]] || [[ -z $2 ]]; then
    echo "Usage:"
    echo "    ${me} \"pdffilepassword\" INFILE"
    exit 1
fi
PDFPASSWORD=$1
INFILE=$2
OUTFILE=${3:-"$INFILE-decrypted.pdf"}
qpdf --password="$PDFPASSWORD" --decrypt "$INFILE" "$OUTFILE"
echo "=> Decrypted: $OUTFILE"
