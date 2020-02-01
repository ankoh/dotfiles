#!/bin/bash

CARAVAN_DIR=~/.caravan
CARAVAN_PRIVATE_KEY=${CARAVAN_DIR}/caravan
CARAVAN_PUBLIC_KEY=${CARAVAN_DIR}/caravan.pub

function caravan_keygen() {
    mkdir -p ${CARAVAN_DIR}
    ssh-keygen -t ed25519 -f ${CARAVAN_PRIVATE_KEY} -N ""
}

function caravan_setup() {
    if [ -z "$1" ]; then
        echo "Usage: caravan_setup <name>"
        return
    fi
    CARAVAN_MOUNT="$(pwd)"
    CARAVAN_PUB="$(cat ${CARAVAN_PUBLIC_KEY})"
    docker run -d -p 22 --name "$1" \
        -v "${CARAVAN_MOUNT}:/home/kohn/mount:delegated" \
        -e CARAVAN_PUBLIC_KEY="${CARAVAN_PUB}"
        ankoh/caravan:latest
}

function caravan_enter() {
    if [ -z "$1" ]; then
        echo "Usage: caravan_enter <name>"
        return
    fi
    CARAVAN_PORT=$(docker inspect --format '{{ (index (index .NetworkSettings.Ports "22/tcp") 0).HostPort }}' "$1")
    ssh -i ${CARAVAN_PRIVATE_KEY} -p ${CARAVAN_PORT} 127.0.0.1
}

function caravan_destroy() {
    if [ -z "$1" ]; then
        echo "Usage: caravan_destroy <name>"
        return
    fi
    docker stop "$1" || true
    docker rm -vf "$1" || true
}

function caravan_stop() {
    if [ -z "$1" ]; then
        echo "Usage: caravan_stop <name>"
        return
    fi
    docker stop "$1" || true
}

function caravan_start() {
    if [ -z "$1" ]; then
        echo "Usage: caravan_start <name>"
        return
    fi
    docker start "$1" || true
}
