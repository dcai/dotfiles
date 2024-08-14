#!/bin/bash
F='/tmp/ncdudata.Z'
ncdu -1xo- "${1-.}" | gzip >"$F"
zcat "$F" | ncdu --confirm-quit -f-
