alias reload!='source ~/.bashrc'

alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

if ls --color >/dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else
    colorflag="-G"
fi

alias ll='ls -lh $colorflag'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h -c'

alias todo='nvim ${HOME}/.dotfiles/todo.md'

if [ -d $HOME/JDK/8 ]; then
    alias onejdk8='set -x;export JAVA_HOME=$HOME/JDK/8;export PATH=$JAVA_HOME/bin:$PATH;set +x'
else
    alias onejdk8='echo "Install OneJDK here: $HOME/JDK/8"'
fi

if [ -d $HOME/JDK/17 ]; then
    alias onejdk17='set -x;export JAVA_HOME=$HOME/JDK/17;export PATH=$JAVA_HOME/bin:$PATH;set +x'
else
    alias onejdk17='echo "Install OneJDK here: $HOME/JDK/17"'
fi

alias lg="git log --graph --abbrev-commit --decorate --format=format:'%C(normal)%h%C(reset) %C(dim white)- %an (%ar) -%C(reset) %C(normal)%s%C(reset) %C(bold normal)%d%C(reset)' --all"
