#!/bin/bash
set -e -u -o pipefail

DIR="${BASH_SOURCE%/*}"
source "$DIR/config.sh"
source "$DIR/common.sh"

echo "Run $1" | tee -a "$LOG_FILE"

login
    
MAGNET_URI="$(echo $1)"

curl -X POST -k -b "$COOKIE_FILE" --data-urlencode "api=SYNO.DownloadStation.Task" --data-urlencode "version=1" \
    --data-urlencode "method=create" --data-urlencode "uri=$MAGNET_URI" "$NAS_ENTRY/webapi/DownloadStation/task.cgi" | tee -a "$LOG_FILE"
