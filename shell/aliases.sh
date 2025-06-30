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

if [ -d $HOME/JDK/ ]; then
    alias onejdk='set -x;export JAVA_HOME=$HOME/JDK;export PATH=$JAVA_HOME/bin:$PATH;set +x'
else
    alias onejdk='echo "Install OneJDK here: $HOME/JDK/"'
fi

alias lg="git log --graph --abbrev-commit --decorate --format=format:'%C(normal)%h%C(reset) %C(dim white)- %an (%ar) -%C(reset) %C(normal)%s%C(reset) %C(bold normal)%d%C(reset)' --all"
