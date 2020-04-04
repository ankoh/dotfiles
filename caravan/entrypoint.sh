#!/bin/bash

SSH_DIR="/home/caravan/.ssh"
AUTHORIZED_KEYS="${SSH_DIR}/authorized_keys"

echo "[ RUN ] Configure ${AUTHORIZED_KEYS}"
mkdir -p ${SSH_DIR}
echo "${CARAVAN_PUBLIC_KEY}" > ${AUTHORIZED_KEYS}
chown -R caravan:caravan ${SSH_DIR}
chmod 700 ${SSH_DIR}
chmod 600 ${AUTHORIZED_KEYS}
echo "[ OK  ] Configure ${AUTHORIZED_KEYS}"
echo "${CARAVAN_PUBLIC_KEY}"

echo kernel.perf_event_paranoid=1 > /etc/sysctl.conf

exec "$@"
