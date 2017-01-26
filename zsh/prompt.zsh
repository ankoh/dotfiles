# Load vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' use-simple true
zstyle ':vcs_info:git*' max-exports 2
zstyle ':vcs_info:git*' formats ' %b' 'x%R'
zstyle ':vcs_info:git*' actionformats ' %b|%a' 'x%R'

# Git dirty indicator
git_dirty() {
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    command git diff --quiet --ignore-submodules HEAD &>/dev/null;
    if [[ $? -eq 1 ]]; then
        echo "✗"
    else
        echo "✔"
    fi
}

# Line on top of prompt
precmd() {
    vcs_info
    cmd_host="$(print -P "%f%m")"
    cmd_git="$(print -P "%F{241}$(git_dirty)%f$vcs_info_msg_0_")"
    cmd_pwd="$(print -P "%{%F{241}%}%~")"
    if [ $(git rev-parse --is-inside-work-tree &>/dev/null && echo 1) ]; then
        print -P "\n%K{234}${cmd_host}: [${cmd_git}] ${cmd_pwd} "
    else
        print -P "\n%K{234}${cmd_host}: ${cmd_pwd} "
    fi
}

# Prompt
export PROMPT='%F{241}■%f '
