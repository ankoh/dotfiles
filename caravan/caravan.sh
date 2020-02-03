#!/bin/bash

CARAVAN_DIR=~/.caravan
CARAVAN_PRIVATE_KEY=${CARAVAN_DIR}/caravan
CARAVAN_PUBLIC_KEY=${CARAVAN_DIR}/caravan.pub

function caravan_keygen() {
    mkdir -p ${CARAVAN_DIR}
    ssh-keygen -t ed25519 -f ${CARAVAN_PRIVATE_KEY} -N ""
}

function caravan_run() {
    CARAVAN_MOUNT="$(pwd)"
    CARAVAN_PUB="$(cat ${CARAVAN_PUBLIC_KEY})"
    echo "Create caravan volume"
    docker volume create --name caravan
    echo "Create caravan image"
    CARAVAN_IMAGE=$( \
        docker run -d -p 22 --name caravan \
            -v "caravan:/home/caravan/volume" \
            -e CARAVAN_PUBLIC_KEY="${CARAVAN_PUB}" \
            ankoh/caravan:latest \
    )
    echo "Setup SSH forwarding"
    git -C ~/.ssh archive --format tar HEAD | docker cp - ${CARAVAN_IMAGE}:/home/caravan/.ssh/
    docker exec --user root -it ${CARAVAN_IMAGE} chown -R caravan:caravan /home/caravan/.ssh /home/caravan/volume
}

function caravan_enter() {
    CARAVAN_PORT=$(docker inspect --format '{{ (index (index .NetworkSettings.Ports "22/tcp") 0).HostPort }}' caravan)
    ssh-add ${CARAVAN_PRIVATE_KEY}
    ssh -A \
        -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -i ${CARAVAN_PRIVATE_KEY} \
        -p ${CARAVAN_PORT} \
        caravan@127.0.0.1
}

function caravan_rm() {
    docker stop caravan || true
    docker rm -vf caravan || true
}

function caravan_start() {
    docker start caravan || true
}

function caravan_stop() {
    docker stop caravan || true
}
