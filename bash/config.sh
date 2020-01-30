include () {
    [[ -f "$1" ]] && source "$1"
}

# Terminal
export TERM=xterm-256color

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

# Paths
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
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

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Shell-specific config
if [ -n "$BASH_VERSION" ]; then
source $BASHCONF/config.bash
else
source $BASHCONF/config.zsh
fi
