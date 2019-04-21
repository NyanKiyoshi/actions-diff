#!/bin/bash

test $# -gt 1 || {
    echo "Usage: $0 <path> command ..." >&2
    exit 1
}

set -e

VENV_NAME=${VENV_DIR:=venv}
VENV_PATH="${GITHUB_WORKSPACE:-$HOME}/${VENV_NAME}"

if ! [ -e "${VENV_PATH}" ]; then
    python -m venv "${VENV_PATH}"
fi

source "${VENV_PATH}/bin/activate"
target_file="$1"

shift

test "${target_file}" == - && {
    exec $*
}

test -f "${target_file}" || {
    echo "${target_file} no such file or invalid file" >&2
    exit 1
}

sh -c "$*" | {
    diff "${target_file}" - \
    || {
        echo diff
        echo 'Error: the file is out of date' >&2
        exit 1
    }
}
