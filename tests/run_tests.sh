#!/bin/bash

HERE=$(cd $(dirname $0) && pwd)
SUITE_PATH="${HERE}/suite"
ENTRY_POINT_PATH="${HERE}/../entrypoint.sh"

test -d "${SUITE_PATH}" \
    || git clone --depth=5 --branch=master git@github.com:kward/shunit2.git "${SUITE_PATH}" \
    || exit $?

entrypoint() {
    "${ENTRY_POINT_PATH}" $*
}

file() {
    echo "${HERE}/files/$1"
}

testUpToDateFile() {
    results=$(
        entrypoint $(file latest.json) cat $(file latest.json) \
            >/dev/null \
            2>&1
    )

    assertTrue 'The test should have passed' $?
    assertTrue 'Stderr should not output anything on success' "[ -z ${results} ]"
}

testOutOfDateFile() {
    results=$(
        entrypoint $(file outdated.json) cat $(file latest.json) \
            2>/dev/null
    )

    assertFalse 'The comparison should have failed' $?
    assertEquals 'Stdout should have output the correct diff' \
        '4c4,5
<     "2"
---
>     "2",
>     "3"' \
    "${results}"
}

testNoInputFile() {
    results=$(entrypoint - echo hello)
    assertTrue 'The command should have passed' $?
    assertEquals 'Stderr should have output the correct diff' hello "${results}"
}

testInvalidFile() {
    results=$(entrypoint /bad/abc cmd 2>&1)
    assertFalse 'The command should not have passed' $?
    assertEquals 'It should have print an error' \
        '/bad/abc no such file or invalid file' \
         "${results}"
}

testInvalidUsage() {
    results=$(entrypoint /bad/abc 2>&1)
    assertFalse 'The command should not have passed' $?
    assertEquals 'It should have print an error' \
        'Usage: entrypoint.sh <path> command ...' \
         "${results}"
}

. "${SUITE_PATH}/shunit2"
