#!/bin/bash

ps -Ao pid,%cpu,%mem,user,command -m  | grep -v Application | grep -v "System/Library" | grep -v libexec | fzf
