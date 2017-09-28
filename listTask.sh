#!/bin/bash
set -e -u -o pipefail

if [[ "${1:-}" = "debug" ]]; then
    set -x
fi

DIR="${BASH_SOURCE%/*}"
source "$DIR/config.sh"
source "$DIR/common.sh"

login

curl -k -b "$COOKIE_FILE" "$NAS_ENTRY/webapi/DownloadStation/task.cgi?api=SYNO.DownloadStation.Task&version=1&method=list&additional=detail,transfer" 2>/dev/null | jq -r '.data.tasks[] | [{id: .id, title: .title, status: .status, size: .size, downloaded: .additional.transfer.size_downloaded}] | sort_by(.title) | .[] |  select(.size != 0) | [.]  | .[] | "\(.id)\t\(.title)\t\(.status)\t\((.downloaded / .size) * 100)%"' | column -s "	" -t
