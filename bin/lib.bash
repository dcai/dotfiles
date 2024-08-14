#!/bin/bash

export CLROFF="\033[0;0m"

export BLUE="\033[1;34m"
export GRAY="\033[1;30m"
export GREEN='\033[0;32m'
export BLACK='\033[0;30m'
export RED='\033[0;31m'
export YELLOW='\033[0;33m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export WHITE='\033[0;37m'

random_port() {
    echo $((3001 + RANDOM % 6999))
}

# Generate a random hexadecimal color code
random_hex_color() {
    local hex_chars="0123456789ABCDEF"
    local color="#"
    for i in {1..6}; do
        color+="${hex_chars:$((RANDOM % ${#hex_chars})):1}"
    done
    echo "$color"
}

print_cmd() {
    if [[ -z "$COLORON" ]]; then
        echo -e "> $1"
    else
        echo -e "${GREEN}> ${GRAY}$1${CLROFF}"
    fi
}

# example:
#   > print_and_run_cmd "git status"
print_and_run_cmd() {
    cmd=$1
    print_cmd "$cmd"
    eval "$cmd"
}

hr() {
    printf '%b' "${GRAY}"
    # https://stackoverflow.com/a/5349842
    # printf '=%.0s' {1..80}
    printf '─%.0s' {1..80}
    printf '%b' "${CLROFF}\n"
}

print_and_run_tmux_split() {
    cmd=$1
    print_cmd "$cmd"
    tmux split-window "${cmd}"
}

print_and_run_tmux_new_window() {
    cmd=$1
    print_cmd "$cmd"
    tmux neww "${cmd}"
}

msg() {
    if [[ -z "$COLORON" ]]; then
        echo "$1"
    else
        echo -e "${YELLOW}# ${CLROFF}$1"
    fi
}

find_project_root() {
    current_dir=$(pwd)
    while [[ "$current_dir" != "/" ]]; do
        # Check if given file exists
        if [[ -f "$current_dir/$1" ]]; then
            echo "$current_dir"
            exit
        fi
        # Move to the parent directory
        current_dir=$(dirname "$current_dir")
    done

}
