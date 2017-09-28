#!/bin/bash
set -e -u -o pipefail

if [[ "${1:-}" = "debug" ]]; then
    set -x
    RM_TASK_ID="$2"
else
    RM_TASK_ID="$1"
fi

read -p "Delete Task $RM_TASK_ID?" REPLY

if [[ "$REPLY" != "Y" ]]; then
    exit 0
fi

DIR="${BASH_SOURCE%/*}"
source "$DIR/config.sh"
source "$DIR/common.sh"

login

curl -k -b "$COOKIE_FILE" "$NAS_ENTRY/webapi/DownloadStation/task.cgi?api=SYNO.DownloadStation.Task&version=1&method=delete&id=$RM_TASK_ID" 2>/dev/null

