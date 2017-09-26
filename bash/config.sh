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
export PS1="\n\h [\w]\n$ "

# CMAKE paths
export CMAKE_INCLUDE_PATH=$HOME/.local/include:$CMAKE_INCLUDE_PATH
export CMAKE_LIBRARY_PATH=$HOME/.local/lib:$CMAKE_LIBRARY_PATH
export CMAKE_PREFIX_PATH=$HOME/.local:$CMAKE_PREFIX_PATH
export CMAKE_INSTALL_PREFIX=$HOME/.local:$CMAKE_INSTALL_PREFIX

# Specific paths
export LIBRARY_PATH=$HOME/.local/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export GOPATH=$HOME/go
export GEM_HOME=$HOME/.gem
export NPM_CONIFG_PREFIX=$HOME/.npm_global

# Paths
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$DOTFILES/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH
export PATH=$GEM_HOME/bin:$PATH

# Bash completions
include () {
    [[ -f "$1" ]] && source "$1"
}
include /usr/share/bash-completion/bash_completion
include /usr/local/etc/bash_completion
