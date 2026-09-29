#!/bin/bash

function hyperdshell() {
    set -x
    docker run \
        --platform linux/amd64 \
        -it --rm \
        docker.repo.local.sfdc.net/sfci/gec/hyper-db-emu/hyper-db/hyperd:release-cdp-2025.80.0 \
        /opt/hyper/bin/hyperd shell --log_config=
}

function byohcerts() {
    CDP_CONTROL_POD="$(kubectl get pods --no-headers --namespace cdp -o 'custom-columns=:metadata.name' | grep cdp-control | head -n 1)"
    echo "-------------------------------------------"
    echo "CDP_CONTROL_POD=${CDP_CONTROL_POD}"

    mkdir -p /tmp/byoh
    rm -f /tmp/byoh/client.pem
    rm -f /tmp/byoh/client-key.pem
    rm -f /tmp/byoh/cacerts.pem


    echo "Fetching Client Public Key"
    kubectl cp -n cdp $CDP_CONTROL_POD:/etc/identity/client/certificates/client.pem /tmp/byoh/client.pem

    echo "Fetching Client Private Key"
    kubectl cp -n cdp $CDP_CONTROL_POD:/etc/identity/client/keys/client-key.pem /tmp/byoh/client-key.pem

    echo "Fetching CA Certificates"
    kubectl cp -n cdp $CDP_CONTROL_POD:/etc/identity/ca/cacerts.pem /tmp/byoh/cacerts.pem
}


function hypercerts() {
    CDP_CONTROL_POD="$(kubectl get pods --no-headers --namespace hyperdb -o 'custom-columns=:metadata.name' | grep hyper | head -n 1)"
    echo "-------------------------------------------"
    echo "CDP_CONTROL_POD=${CDP_CONTROL_POD}"

    mkdir -p /tmp/hypermtls
    rm -f /tmp/hypermtls/client.pem
    rm -f /tmp/hypermtls/client-key.pem
    rm -f /tmp/hypermtls/cacerts.pem


    echo "Fetching Client Public Key"
    kubectl cp -n hyperdb $CDP_CONTROL_POD:/etc/identity/client/certificates/client.pem /tmp/hypermtls/client.pem

    echo "Fetching Client Private Key"
    kubectl cp -n hyperdb $CDP_CONTROL_POD:/etc/identity/client/keys/client-key.pem /tmp/hypermtls/client-key.pem

    echo "Fetching CA Certificates"
    kubectl cp -n hyperdb $CDP_CONTROL_POD:/etc/identity/ca/cacerts.pem /tmp/hypermtls/cacerts.pem
}

# Stash known hosts
function stash_known() {
    cp ~/.ssh/known_hosts ~/.ssh/known_hosts_tmp
}
# Pop known hosts
function pop_known() {
    cp ~/.ssh/known_hosts_tmp ~/.ssh/known_hosts
}

# Do while the return code is 0
function repeat() {
    while [ $? -eq 0 ]; do eval "$(history | tail -2 | head -n 1 | cut -c8-999)"; done
}
# Refresh this pane from the agent socket captured by the latest tmux client.
fixssh() {
    if [ -z "${TMUX:-}" ]; then
        echo "fixssh: not running inside tmux" >&2
        return 1
    fi

    local socket
    socket="$(tmux show-environment SSH_AUTH_SOCK 2>/dev/null)" || {
        echo "fixssh: tmux has no SSH_AUTH_SOCK; reconnect with agent forwarding" >&2
        return 1
    }
    socket="${socket#SSH_AUTH_SOCK=}"
    if [ -z "${socket}" ] || [ ! -S "${socket}" ]; then
        echo "fixssh: tmux SSH_AUTH_SOCK is not a live socket: ${socket:-<empty>}" >&2
        return 1
    fi

    export SSH_AUTH_SOCK="${socket}"
    if ssh-add -l >/dev/null 2>&1; then
        echo "SSH agent refreshed: ${SSH_AUTH_SOCK}"
    else
        echo "fixssh: socket refreshed, but the agent has no available identities" >&2
        return 1
    fi
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
