#!/bin/bash

AUTHORIZED_KEYS="/home/caravan/.ssh/authorized_keys"

echo "[ RUN ] Configure ${AUTHORIZED_KEYS}"
mkdir -p /home/caravan/.ssh
echo "${CARAVAN_PUBLIC_KEY}" > ${AUTHORIZED_KEYS}
chown caravan:caravan ${AUTHORIZED_KEYS}
chmod 600 ${AUTHORIZED_KEYS}
echo "[ OK  ] Configure ${AUTHORIZED_KEYS}"

echo "${CARAVAN_PUBLIC_KEY}"

exec "$@"
