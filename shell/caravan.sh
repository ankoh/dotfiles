function setup_caravan() {
    if [ -z "$1" ]; then
        echo "Usage: setup_caravan <name>"
        return
    fi
    docker run -d \
        --name "$1" \
        -v "$(pwd):/home/kohn/volume:delegated" \
        -p 22 \
        ankoh/caravan:latest
}

function enter_caravan() {
    if [ -z "$1" ]; then
        echo "Usage: enter_caravan <name>"
        return
    fi
    CARAVAN_PORT=$(docker inspect --format '{{ (index (index .NetworkSettings.Ports "22/tcp") 0).HostPort }}' "$1")
    ssh -i ~/.ssh/caravan/caravan -p ${CARAVAN_PORT} localhost
}

function destroy_caravan() {
    if [ -z "$1" ]; then
        echo "Usage: destroy_caravan <name>"
        return
    fi
    docker stop "$1" || true
    docker rm -vf "$1" || true
}

