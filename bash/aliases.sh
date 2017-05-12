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

alias l="ls -lah ${colorflag}"
alias la="ls -AF ${colorflag}"
alias ll="ls -lFh ${colorflag}"
alias lld="ls -l | grep ^d"
alias rmf="rm -rf"

alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h -c'

alias flushdns="dscacheutil -flushcache"

alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

alias trimcopy="tr -d '\n' | pbcopy"

alias fs="stat -f \"%z bytes\""

for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="lwp-request -m '$method'"
done

alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 10'"
