#!/bin/bash

include() {
    [[ -f "$1" ]] && source "$1"
}

export DOTFILES=$HOME/.dotfiles
export SHELLCONF=$DOTFILES/shell

export TERM=xterm-256color

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export HISTFILE=~/.bash_history
export HISTSIZE=100000
export SAVEHIST=100000
export REPORTTIME=10
export EDITOR='vim'

export CMAKE_INCLUDE_PATH=$HOME/.local/include:$CMAKE_INCLUDE_PATH
export CMAKE_LIBRARY_PATH=$HOME/.local/lib:$CMAKE_LIBRARY_PATH
export CMAKE_PREFIX_PATH=$HOME/.local:$CMAKE_PREFIX_PATH
export CMAKE_INSTALL_PREFIX=$HOME/.local:$CMAKE_INSTALL_PREFIX

export LIBRARY_PATH=$HOME/.local/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GEM_HOME=$HOME/.gem
export NPM_PACKAGES=$HOME/.npm_packages
export PYENV_ROOT=$HOME/.pyenv
export NVM_DIR="$HOME/.nvm"
export VIRTUAL_ENV="$HOME/.venv"

export GPG_TTY=$(tty)

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.fluttersdk/bin:$PATH
export PATH=$HOME/.pub-cache/bin:$PATH
export PATH=$HOME/.fluttersdk/.pub-cache/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$GOBIN:$PATH
export PATH=$NPM_PACKAGES/bin:$PATH
export PATH=$GEM_HOME/bin:$PATH
export PATH=$PATH:~/.fzf/bin
export PATH=$PATH:~/.displayplacer
export PATH=$PYENV_ROOT/bin:$PATH
export PATH=$PATH:/opt/homebrew/opt/libpq/bin
export PATH=/opt/homebrew/opt/llvm/bin:$PATH
export PATH=/opt/homebrew/opt/openjdk/bin:$PATH

export PATH=$HOME/.yarn/bin:$PATH
export PATH=$HOME/.config/yarn/global/node_modules/.bin:$PATH

if command -v /opt/homebrew/bin/brew 1>/dev/null 2>&1; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

source "$HOME/.cargo/env"
source "$HOME/.venv/bin/activate"

if [[ "$OSTYPE" == "darwin"* ]]; then
    export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
fi

# Interactive shell?
if [ ! -z "$PS1" ]; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    if [ -n "$BASH_VERSION" ]; then
        include $HOME/.fzf/shell/key-bindings.bash
        include $HOME/.fzf/shell/completion.bash

        if [ "$(id -u)" -eq 0 ]; then
            PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1;31m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"
        else
            PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"
        fi

    elif [ -n "$ZSH_VERSION" ]; then
        bindkey "^A" vi-beginning-of-line

        include $HOME/.fzf/shell/key-bindings.zsh
        include $HOME/.fzf/shell/completion.zsh
    fi

    include $SHELLCONF/aliases.sh
    include $SHELLCONF/displays.sh
    include $SHELLCONF/functions.sh
fi

bindkey -e
. "$HOME/.cargo/env"
