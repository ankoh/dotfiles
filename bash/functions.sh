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

# Dump clang record layouts
function dump-record-layout() {
    clang++ -std=c++14 -Xclang -fdump-record-layouts $1
}

# Clean old kernels
function clean-kernels () {
    # Patterns
    local current_kernel="$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')"
    local kernel_pkg="linux-(image|headers|ubuntu-modules|restricted-modules)"
    local meta_pkg="${kernel_pkg}-(generic|i386|server|common|rt|xen|ec2)"

    # Gather
    local to_keep="$(dpkg -l | egrep ${kernel_pkg} | egrep "${current_kernel}|${meta_pkg}" | awk '{print $2}')"
    local to_remove="$(dpkg -l | egrep ${kernel_pkg} | egrep -v "${current_kernel}|${meta_pkg}" | awk '{print $2}')"
    printf "KEEP:\n%s\n\nREMOVE:\n%s\n" "${to_keep}" "${to_remove}"

    # Ask if sane
    printf "\nAre you sure? ([yY]|[nN])\n"
    read sane
    if [[ ! ${sane} =~ ^[Yy]$ ]]; then
        return 1;
    fi

    # Purge kernels
    sudo apt-get purge $(echo ${to_remove})
}

# Find llvm component
function llvm-grep() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        printf "Usage: llvm-component <version> <symbol>\n"
        return 1;
    fi
    for lib in $(llvm-config-$1 --libfiles); do
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

# Recompile hyper
function rchyper() {
    local debug=0;
    local cpus=`getconf _NPROCESSORS_ONLN`
    if [ ! -z "$1" ]; then
        cd ../dbcore && DEBUG=1 make -j${cpus} \
            && cd ../hyper && DEBUG=1 make -j${cpus}
    else
        cd ../dbcore && make -j${cpus} \
            && cd ../hyper && make -j${cpus}
    fi
}
