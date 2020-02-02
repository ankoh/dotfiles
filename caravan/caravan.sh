#!/bin/bash

CARAVAN_DIR=~/.caravan
CARAVAN_PRIVATE_KEY=${CARAVAN_DIR}/caravan
CARAVAN_PUBLIC_KEY=${CARAVAN_DIR}/caravan.pub

function caravan_keygen() {
    mkdir -p ${CARAVAN_DIR}
    ssh-keygen -t ed25519 -f ${CARAVAN_PRIVATE_KEY} -N ""
}

function caravan_run() {
    if [ -z "$1" ]; then
        echo "Usage: caravan_run <name>"
        return
    fi
    CARAVAN_MOUNT="$(pwd)"
    CARAVAN_PUB="$(cat ${CARAVAN_PUBLIC_KEY})"
    echo "Create caravan image"
    CARAVAN_IMAGE=$( \
        docker run -d -p 22 --name "$1" \
            -v "${CARAVAN_MOUNT}:/home/caravan/mount:delegated" \
            -e CARAVAN_PUBLIC_KEY="${CARAVAN_PUB}" \
            ankoh/caravan:latest \
    )
    echo "Setup SSH forwarding"
    git -C ~/.ssh archive --format tar HEAD | docker cp - ${CARAVAN_IMAGE}:/home/caravan/.ssh/
    docker exec --user root -it ${CARAVAN_IMAGE} chown -R caravan:caravan /home/caravan/.ssh
}

function caravan_exec() {
    if [ -z "$1" ]; then
        echo "Usage: caravan_exec <name>"
        return
    fi
    CARAVAN_PORT=$(docker inspect --format '{{ (index (index .NetworkSettings.Ports "22/tcp") 0).HostPort }}' "$1")
    ssh-add ${CARAVAN_PRIVATE_KEY}
    ssh -A \
        -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -i ${CARAVAN_PRIVATE_KEY} \
        -p ${CARAVAN_PORT} \
        caravan@127.0.0.1
}

function caravan_rm() {
    if [ -z "$1" ]; then
        echo "Usage: caravan_rm <name>"
        return
    fi
    docker stop "$1" || true
    docker rm -vf "$1" || true
}

function caravan_start() {
    if [ -z "$1" ]; then
        echo "Usage: caravan_start <name>"
        return
    fi
    docker start "$1" || true
}

function caravan_stop() {
    if [ -z "$1" ]; then
        echo "Usage: caravan_stop <name>"
        return
    fi
    docker stop "$1" || true
}
