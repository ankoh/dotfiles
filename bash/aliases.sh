alias reload!='source ~/.bashrc'

alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else
    colorflag="-G"
fi

alias ll="ls -lFh ${colorflag}"

alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h -c'

alias lg="git log --graph --abbrev-commit --decorate --format=format:'%C(normal)%h%C(reset) %C(dim white)- %an (%ar) -%C(reset) %C(normal)%s%C(reset) %C(bold normal)%d%C(reset)' --all"
