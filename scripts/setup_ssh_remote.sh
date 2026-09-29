#!/usr/bin/env bash

set -euo pipefail

usage() {
	cat <<'EOF'
Usage: scripts/setup_ssh_remote.sh <ssh-destination>

Copy the local SSH config and public keys to a remote machine. Private keys,
known_hosts, environment files, and all other SSH files are never copied.

Examples:
  ./scripts/setup_ssh_remote.sh alice@example.com
  ./scripts/setup_ssh_remote.sh my-ssh-alias
EOF
}

if [ "$#" -ne 1 ]; then
	usage >&2
	exit 2
fi

DESTINATION="$1"
LOCAL_SSH_DIR="${HOME}/.ssh"
SSH=(ssh -A)

if [ ! -d "${LOCAL_SSH_DIR}" ]; then
	echo "Error: ${LOCAL_SSH_DIR} does not exist." >&2
	exit 1
fi

SSH_FILES=()
if [ -f "${LOCAL_SSH_DIR}/config" ]; then
	SSH_FILES+=(config)
fi
shopt -s nullglob
for public_key in "${LOCAL_SSH_DIR}"/*.pub; do
	SSH_FILES+=("$(basename "${public_key}")")
done
shopt -u nullglob

if [ "${#SSH_FILES[@]}" -eq 0 ]; then
	echo "Error: no SSH config or public keys found in ${LOCAL_SSH_DIR}." >&2
	exit 1
fi

echo ">> Copying SSH config and ${#SSH_FILES[@]} public/config file(s) to ${DESTINATION}"
printf '   %s\n' "${SSH_FILES[@]}"

# Stream an explicit allowlist. Existing remote files not in the list are left
# untouched, and no local private key can enter the archive.
COPYFILE_DISABLE=1 tar -C "${LOCAL_SSH_DIR}" -cf - -- "${SSH_FILES[@]}" \
	| "${SSH[@]}" "${DESTINATION}" \
		'umask 077; mkdir -p ~/.ssh; chmod 700 ~/.ssh; tar -C ~/.ssh -xf -; chmod 600 ~/.ssh/config 2>/dev/null || true; find ~/.ssh -maxdepth 1 -type f -name "*.pub" -exec chmod 644 {} +'

if [ -f "${LOCAL_SSH_DIR}/config" ]; then
	# A local IdentityAgent usually points at a machine-specific socket. Removing
	# it lets remote SSH use the forwarded agent through its SSH_AUTH_SOCK.
	"${SSH[@]}" "${DESTINATION}" 'umask 077; awk "tolower(\$1) != \"identityagent\"" ~/.ssh/config > ~/.ssh/config.tmp; mv ~/.ssh/config.tmp ~/.ssh/config; chmod 600 ~/.ssh/config'
fi

"${SSH[@]}" "${DESTINATION}" 'test -S "${SSH_AUTH_SOCK:-}"' || {
	echo "Error: SSH agent forwarding is not available on ${DESTINATION}." >&2
	exit 1
}

echo ">> SSH config and public keys are ready on ${DESTINATION}"
