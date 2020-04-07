#!/bin/bash

# Fix ssh-agent
fixssh() {
    eval $(tmux show-env | sed -n 's/^\(SSH_[^=]*\)=\(.*\)/export \1="\2"/p')
}

# SSH on a host with forwarded SSH agent
function fwdssh() {
    set -x
    ssh-add -L | grep "$1" | ssh -i /dev/stdin "${@:2}"
    set +x
}

# Extract archives - use: extract <file>
# Credits to http://dotfiles.org/~pseup/.bashrc
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) rar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.xz) tar xJf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find fat
function find-fat-things() {
    du -ahx / | sort -rh | head -100
}

# Find llvm component
function llvm-grep() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        printf "Usage: llvm-grep <llvm-config> <symbol>\n"
        return 1;
    fi
    for lib in $($1 --libfiles); do
        printf "[ RUNNING ] %s" "${lib}"
        local symbols=$(nm -gC ${lib} | grep "$2" | grep -v " U ")
        if [ ! -z "${symbols}" ]; then
            printf "\r[  SYMBOL ] %s\n" "${lib}"
            printf "${symbols}\n"
        else 
            printf "\r[   EMPTY ] %s\n" "${lib}"
        fi
    done
}
