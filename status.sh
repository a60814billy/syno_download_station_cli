#!/bin/bash
set -e -u -o pipefail

if [[ "${1:-}" = "debug" ]]; then
    set -x
fi

DIR="${BASH_SOURCE%/*}"
source "$DIR/config.sh"
source "$DIR/common.sh"

login

curl -k -b "$COOKIE_FILE" "$NAS_ENTRY/webapi/DownloadStation/statistic.cgi?api=SYNO.DownloadStation.Statistic&version=1&method=getinfo" 2>/dev/null | jq -r '.data | "DL: \(.speed_download / 1024) Kbytes/s\nUP: \(.speed_upload) bytes/s"'
