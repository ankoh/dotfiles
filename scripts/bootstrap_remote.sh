#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

usage() {
	cat <<'EOF'
Usage: scripts/bootstrap_remote.sh <ssh-destination>

Clone or update these dotfiles on a remote machine and run `make install`.
The destination may include a user or be an alias from ~/.ssh/config.

Environment variables:
  DOTFILES_REPO  Repository to clone (default: https://github.com/ankoh/dotfiles.git)
  DOTFILES_REF   Branch or tag to install (default: master)
  DOTFILES_DIR   Remote install directory (default: $HOME/.dotfiles)
  SKIP_SSH_SETUP Set to 1 to skip copying SSH config and public keys

Examples:
  ./scripts/bootstrap_remote.sh alice@example.com
  ./scripts/bootstrap_remote.sh my-ssh-alias
EOF
}

if [ "$#" -ne 1 ]; then
	usage >&2
	exit 2
fi

DESTINATION="$1"
REPO_URL="${DOTFILES_REPO:-https://github.com/ankoh/dotfiles.git}"
REF="${DOTFILES_REF:-master}"
DIR="${DOTFILES_DIR:-\$HOME/.dotfiles}"
SSH=(ssh -A)

if [ "${SKIP_SSH_SETUP:-0}" != 1 ]; then
	"${SCRIPT_DIR}/setup_ssh_remote.sh" "${DESTINATION}"
fi

echo ">> Installing dotfiles on ${DESTINATION}"
echo "   repo: ${REPO_URL}"
echo "   ref:  ${REF}"
echo "   dir:  ${DIR}"

REMOTE_SCRIPT=".dotfiles-bootstrap-$$-${RANDOM}.sh"

cleanup() {
	"${SSH[@]}" "${DESTINATION}" "rm -f '${REMOTE_SCRIPT}'" >/dev/null 2>&1 || true
}
trap cleanup EXIT

# Upload first so the installation can run in a separate SSH session whose
# stdin is the terminal. Privilege escalation tools can then prompt normally.
{
	printf 'REPO_URL=%q\n' "${REPO_URL}"
	printf 'REF=%q\n' "${REF}"
	printf 'DIR=%q\n' "${DIR}"
	cat <<'REMOTE'
set -euo pipefail

DIR="${DIR/#\$HOME/$HOME}"
DIR="${DIR/#\~/$HOME}"

command -v git >/dev/null 2>&1 || { echo "error: git is not installed on this host" >&2; exit 1; }
command -v make >/dev/null 2>&1 || { echo "error: make is not installed on this host" >&2; exit 1; }

if [ -d "${DIR}/.git" ]; then
	echo ">> Updating dotfiles in ${DIR} to ${REF}"
	git -C "${DIR}" fetch --quiet origin "${REF}"
	git -C "${DIR}" reset --hard --quiet FETCH_HEAD
elif [ -e "${DIR}" ]; then
	echo "error: ${DIR} exists but is not a Git checkout" >&2
	exit 1
else
	echo ">> Cloning ${REPO_URL} into ${DIR}"
	git clone --branch "${REF}" "${REPO_URL}" "${DIR}"
fi

echo ">> Running make install"
make -C "${DIR}" install
REMOTE
} | "${SSH[@]}" "${DESTINATION}" "umask 077 && cat > '${REMOTE_SCRIPT}'"

"${SSH[@]}" -t "${DESTINATION}" "bash '${REMOTE_SCRIPT}'"

echo ">> Finished on ${DESTINATION}"
