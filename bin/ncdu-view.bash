#!/bin/bash
F='/tmp/ncdudata.Z'
zcat "$F" | ncdu --confirm-quit -f-
