# Rrint available colors and their numbers
function colours() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}m colour${i}"
        if (( $i % 5 == 0 )); then
            printf "\n"
        else
            printf "\t"
        fi
    done
}

# Create a new directory and enter it
function md() {
    mkdir -p "$@" && cd "$@"
}


# History
function hist() {
    history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}

# Find shorthand
function f() {
    find . -name "$1"
}

# Take this repo and copy it to somewhere else minus the .git stuff.
function gitexport(){
    mkdir -p "$1"
    git archive master | tar -x -C "$1"
}

# Get gzipped size
function gz() {
    echo "orig size    (bytes): "
    cat "$1" | wc -c
    echo "gzipped size (bytes): "
    gzip -c "$1" | wc -c
}

# All the dig info
function digga() {
    dig +nocmd "$1" any +multiline +noall +answer
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
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Generate a random password
function rndpw() {
    date +%s | sha256sum | base64 | head -c ${1:-30} ; echo
}

# Docker cleanup
function docker-cleanup() {
   docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
   docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

# Docker reset
function docker-reset() {
   docker rm -vf $(docker ps -a -q) 2>/dev/null
   docker rmi -f $(docker images -q) 2>/dev/null
}

# Find fat
function find-fat-things() {
    du -ahx / | sort -rh | head -100
}

# Slim fat
# E.g.:
# find $CONFLUENCE_INSTALL/logs -name 'catalina.*.log' -mtime +1w -print0 | xargs -0 rm -f
function slim-fat-things() {
    find $1 -name $2 -mtime $3 -print0 | xargs -0 rm -f
}
