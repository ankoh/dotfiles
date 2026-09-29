#!/usr/bin/env bash

set -euo pipefail

usage() {
	cat <<'EOF'
Usage: scripts/setup_opencode_remote.sh <ssh-destination>

Install the local OpenCode version on a remote machine and copy its credentials.
The destination may include a user or be an alias from ~/.ssh/config.

Environment variables:
  OPENCODE_VERSION      Version to install (default: local version)
  OPENCODE_AUTH_FILE    Local auth file to copy
  OPENCODE_CA_FILE      Local CA bundle to copy when present
  OPENCODE_CONFIG_FILE  Optional remote-safe config file to copy
  AISUITE_PROVIDER_FILE Local AI Suite provider wrapper
  AISUITE_MANAGER       Local AI Suite manager executable
  OPENCODE_SKIP_MODEL_CHECK=1 to skip the remote model request

Examples:
  ./scripts/setup_opencode_remote.sh alice@example.com
  OPENCODE_CONFIG_FILE=./remote-opencode.json ./scripts/setup_opencode_remote.sh my-ssh-alias
EOF
}

if [ "$#" -ne 1 ]; then
	usage >&2
	exit 2
fi

DESTINATION="$1"
LOCAL_AUTH="${OPENCODE_AUTH_FILE:-${HOME}/.local/share/opencode/auth.json}"
LOCAL_CA="${OPENCODE_CA_FILE:-${HOME}/.aisuite/conf/npm-sfdc-certs.pem}"
LOCAL_CONFIG="${OPENCODE_CONFIG_FILE:-}"
LOCAL_AISUITE_PROVIDER="${AISUITE_PROVIDER_FILE:-${HOME}/.config/opencode/plugins/aisuite_provider.js}"
LOCAL_AISUITE_MANAGER="${AISUITE_MANAGER:-${HOME}/.aisuite/bin/manager}"
VERSION="${OPENCODE_VERSION:-}"

if [ ! -f "${LOCAL_AUTH}" ]; then
	echo "Error: ${LOCAL_AUTH} not found. Run 'opencode auth login' locally first." >&2
	exit 1
fi

command -v python3 >/dev/null 2>&1 || {
	echo "Error: python3 is required to validate the credential file." >&2
	exit 1
}
python3 -c 'import json, sys; value=json.load(open(sys.argv[1])); assert isinstance(value, dict) and value' "${LOCAL_AUTH}" || {
	echo "Error: ${LOCAL_AUTH} is not a valid, non-empty OpenCode credential file." >&2
	exit 1
}

USES_AISUITE="$(python3 -c 'import json, sys; value=json.load(open(sys.argv[1])); print(int("aisuite" in value or "llmgw" in value))' "${LOCAL_AUTH}")"
if [ "${USES_AISUITE}" = 1 ]; then
	if [ ! -f "${LOCAL_AISUITE_PROVIDER}" ] || [ ! -x "${LOCAL_AISUITE_MANAGER}" ]; then
		echo "Error: AI Suite credentials require its provider and credential manager." >&2
		echo "       Missing ${LOCAL_AISUITE_PROVIDER} or ${LOCAL_AISUITE_MANAGER}." >&2
		exit 1
	fi

	PROVIDER_ENTRY="$(python3 -c 'import pathlib, re, sys, urllib.parse; text=pathlib.Path(sys.argv[1]).read_text(); match=re.search(r"^import llmgw from \"file://([^\"]+)\"", text, re.MULTILINE); match or sys.exit("could not locate the AI Suite provider package"); print(urllib.parse.unquote(match.group(1)))' "${LOCAL_AISUITE_PROVIDER}")"
	PROVIDER_ROOT="$(python3 -c 'import pathlib, sys; path=pathlib.Path(sys.argv[1]).resolve(); print(next((parent for parent in path.parents if (parent / "package.json").is_file()), ""))' "${PROVIDER_ENTRY}")"
	if [ -z "${PROVIDER_ROOT}" ]; then
		echo "Error: could not locate the AI Suite provider package root." >&2
		exit 1
	fi
	PROVIDER_ENTRY_REL="$(python3 -c 'import os, sys; print(os.path.relpath(sys.argv[1], sys.argv[2]))' "${PROVIDER_ENTRY}" "${PROVIDER_ROOT}")"
	GATEWAY_KEY="$("${LOCAL_AISUITE_MANAGER}" gateway-key)"
	if [ -z "${GATEWAY_KEY}" ] || [[ "${GATEWAY_KEY}" == *$'\n'* ]] || [[ "${GATEWAY_KEY}" == *$'\r'* ]]; then
		echo "Error: AI Suite did not return a valid gateway key." >&2
		exit 1
	fi
fi

if [ -n "${LOCAL_CONFIG}" ]; then
	python3 -c 'import json, sys; value=json.load(open(sys.argv[1])); assert isinstance(value, dict)' "${LOCAL_CONFIG}" || {
		echo "Error: ${LOCAL_CONFIG} is not a valid OpenCode JSON config." >&2
		exit 1
	}
fi

if [ -z "${VERSION}" ]; then
	if command -v opencode >/dev/null 2>&1; then
		LOCAL_OPENCODE="$(command -v opencode)"
	elif [ -x "${HOME}/.opencode/bin/opencode" ]; then
		LOCAL_OPENCODE="${HOME}/.opencode/bin/opencode"
	else
		echo "Error: OpenCode is not installed locally, so its version cannot be determined." >&2
		exit 1
	fi
	VERSION="$("${LOCAL_OPENCODE}" --version)"
fi

echo ">> Installing OpenCode ${VERSION} on ${DESTINATION}"
ssh "${DESTINATION}" 'bash -s' -- "${VERSION}" <<'REMOTE'
set -euo pipefail

VERSION="$1"
command -v curl >/dev/null 2>&1 || { echo "error: curl is not installed on this host" >&2; exit 1; }

curl -fsSL https://opencode.ai/install \
	| PATH="${HOME}/.opencode/bin:${PATH}" bash -s -- --version "${VERSION}"

OPENCODE_BIN="${HOME}/.opencode/bin/opencode"
if [ ! -x "${OPENCODE_BIN}" ]; then
	echo "error: OpenCode installer did not create ${OPENCODE_BIN}" >&2
	exit 1
fi

# A launcher is more reliable than shell RC edits and applies the optional CA
# bundle to non-interactive invocations as well as login shells.
mkdir -p "${HOME}/.local/bin"
cat > "${HOME}/.local/bin/opencode" <<'LAUNCHER'
#!/bin/sh
CA_FILE="${HOME}/.config/opencode/sfdc-certs.pem"
if [ -f "${CA_FILE}" ]; then
	export NODE_EXTRA_CA_CERTS="${CA_FILE}"
fi
exec "${HOME}/.opencode/bin/opencode" "$@"
LAUNCHER
chmod 755 "${HOME}/.local/bin/opencode"
REMOTE

echo ">> Copying OpenCode credentials"
< "${LOCAL_AUTH}" ssh "${DESTINATION}" \
	'umask 077; mkdir -p ~/.local/share/opencode; chmod 700 ~/.local/share/opencode; cat > ~/.local/share/opencode/auth.json; chmod 600 ~/.local/share/opencode/auth.json'

if [ -f "${LOCAL_CA}" ]; then
	echo ">> Copying CA bundle"
	< "${LOCAL_CA}" ssh "${DESTINATION}" \
		'umask 022; mkdir -p ~/.config/opencode; cat > ~/.config/opencode/sfdc-certs.pem; chmod 644 ~/.config/opencode/sfdc-certs.pem'
fi

if [ "${USES_AISUITE}" = 1 ]; then
	echo ">> Installing portable AI Suite provider"
	tar -C "${PROVIDER_ROOT}" -cf - . | ssh "${DESTINATION}" \
		'rm -rf ~/.config/opencode/aisuite-provider; mkdir -p ~/.config/opencode/aisuite-provider; tar -C ~/.config/opencode/aisuite-provider -xf -'

	LOCAL_AISUITE_PROVIDER="${LOCAL_AISUITE_PROVIDER}" PROVIDER_ENTRY_REL="${PROVIDER_ENTRY_REL}" python3 <<'PY' | ssh "${DESTINATION}" \
		'umask 022; mkdir -p ~/.config/opencode/plugins; cat > ~/.config/opencode/plugins/aisuite_provider.js; chmod 644 ~/.config/opencode/plugins/aisuite_provider.js'
import os
import pathlib
import re

path = pathlib.Path(os.environ["LOCAL_AISUITE_PROVIDER"])
text = path.read_text()
entry = "../aisuite-provider/" + os.environ["PROVIDER_ENTRY_REL"]
text, imports = re.subn(
    r'^import llmgw from ["\']file://[^"\']+["\']$',
    f'import llmgw from "{entry}"',
    text,
    count=1,
    flags=re.MULTILINE,
)
options = 'const options = {"credentialCommand":["/bin/sh","-c","cat \\\"$HOME/.config/opencode/aisuite-gateway-key\\\""]}'
text, declarations = re.subn(r"^const options = .*$", options, text, count=1, flags=re.MULTILINE)
if imports != 1 or declarations != 1:
    raise SystemExit("could not make the AI Suite provider portable")
print(text, end="")
PY
	printf '%s\n' "${GATEWAY_KEY}" | ssh "${DESTINATION}" \
		'umask 077; mkdir -p ~/.config/opencode; cat > ~/.config/opencode/aisuite-gateway-key; chmod 600 ~/.config/opencode/aisuite-gateway-key'
	unset GATEWAY_KEY
fi

if [ -n "${LOCAL_CONFIG}" ]; then
	echo ">> Copying remote-safe OpenCode config"
	< "${LOCAL_CONFIG}" ssh "${DESTINATION}" \
		'umask 077; mkdir -p ~/.config/opencode; chmod 700 ~/.config/opencode; cat > ~/.config/opencode/opencode.json; chmod 600 ~/.config/opencode/opencode.json'
fi

echo ">> Verifying remote OpenCode installation and credentials"
REMOTE_VERSION="$(ssh "${DESTINATION}" '~/.local/bin/opencode --version')"
ssh "${DESTINATION}" '~/.local/bin/opencode auth list'

if [ "${OPENCODE_SKIP_MODEL_CHECK:-0}" != 1 ]; then
	echo ">> Verifying a remote OpenCode model request"
	ssh "${DESTINATION}" 'bash -s' <<'REMOTE'
set -euo pipefail
OUTPUT="$(~/.local/bin/opencode run --format json "Reply with exactly OK." 2>&1)" || {
	printf '%s\n' "${OUTPUT}" >&2
	exit 1
}
if ! printf '%s\n' "${OUTPUT}" | grep -q '"type":"text"'; then
	printf '%s\n' "${OUTPUT}" >&2
	echo "Error: OpenCode completed without a text response." >&2
	exit 1
fi
REMOTE
fi

echo ">> OpenCode ${REMOTE_VERSION} is ready on ${DESTINATION}"
