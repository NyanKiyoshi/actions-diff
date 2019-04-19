#!/bin/bash

test $# -gt 1 || {
    echo "Usage: $0 <path> command ..." >&2
    exit 1
}

set -e

VENV_NAME=${VENV_DIR:=venv}

if ! [ -e "${GITHUB_WORKSPACE}/${VENV_NAME}" ]; then
    python -m venv "${GITHUB_WORKSPACE}/${VENV_NAME}"
fi

source "${GITHUB_WORKSPACE}/${VENV_NAME}/bin/activate"
target_file="$1"

shift

diff=`sh -c "$*" | diff "${target_file}" -` || exit $?
test -z "$diff" || {
    echo diff >&2
    echo 'Error: the file is out of date'
    exit 1
}
