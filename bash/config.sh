# Language
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Settings
export HISTFILE=~/.bash_history
export HISTSIZE=10000
export SAVEHIST=10000
export REPORTTIME=10
export EDITOR='vim'

# Prompt
if [ "`id -u`" -eq 0 ]; then
    PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1;31m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"
else
    PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"
fi

# CMAKE paths
export CMAKE_INCLUDE_PATH=$HOME/.local/include:$CMAKE_INCLUDE_PATH
export CMAKE_LIBRARY_PATH=$HOME/.local/lib:$CMAKE_LIBRARY_PATH
export CMAKE_PREFIX_PATH=$HOME/.local:$CMAKE_PREFIX_PATH
export CMAKE_INSTALL_PREFIX=$HOME/.local:$CMAKE_INSTALL_PREFIX

# Specific paths
export LIBRARY_PATH=$HOME/.local/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GEM_HOME=$HOME/.gem
export NPM_PACKAGES=$HOME/.npm_packages
export NODE_PATH=$NPM_PACKAGES/lib/node_modules:$NODE_PATH
export RUST_SRC_PATH="$(~/.cargo/bin/rustc --print sysroot)/lib/rustlib/src/rust/src"

# Paths
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.fluttersdk/bin:$PATH
export PATH=$HOME/.pub-cache/bin:$PATH
export PATH=$DOTFILES/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$GOBIN:$PATH
export PATH=$NPM_PACKAGES/bin:$PATH
export PATH=$GEM_HOME/bin:$PATH
export PATH=$PATH:~/.fzf/bin

# FZF
source ~/.fzf/shell/key-bindings.bash
source ~/.fzf/shell/completion.bash

# Bash completions
include () {
    [[ -f "$1" ]] && source "$1"
}
include /usr/share/bash-completion/bash_completion
include /usr/local/etc/bash_completion
