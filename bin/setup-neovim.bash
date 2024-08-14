#!/bin/bash

. lib.bash

VENV="$HOME/.local/share/nvim/venv"
BIN="$VENV/bin/python3"

if command -v brew &> /dev/null; then
    msg "brew install"
    print_and_run_cmd 'brew install gh tree-sitter luajit lua-language-server stylua typescript typescript-language-server'
fi
msg "npm install"
print_and_run_cmd 'npm i -g neovim'
msg "virtualenv creating env $VENV"
print_and_run_cmd "virtualenv $VENV"
msg "pip version"
print_and_run_cmd "${BIN} -m pip --version"
msg "pip install"
print_and_run_cmd "${BIN} -m pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org  --upgrade pynvim pip"
