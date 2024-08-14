#!/bin/bash
F=/tmp/gdu.Z
gdu -o- "$1" | gzip >"$F"
zcat "$F" | gdu -f-
