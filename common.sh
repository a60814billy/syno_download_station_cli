#!/bin/bash

set -e -u -o pipefail

DIR="${BASH_SOURCE%/*}"
source "$DIR/config.sh"

function login () {
    if [[ "$(find $(dirname $COOKIE_FILE) -depth 1 -mmin -120 -and -name '.syno.cookie' | wc -l)" -eq 0 ]]; then
        # delete previos cookie file
        if [ -f "$COOKIE_FILE" ]; then
            rm "$COOKIE_FILE"
        fi
        curl -k -c "$COOKIE_FILE" "$NAS_ENTRY/webapi/auth.cgi?api=SYNO.API.Auth&version=2&method=login&account=$USERNAME&passwd=$PASSWORD&session=DownloadStation" 2>/dev/null | tee -a "$LOG_FILE"
    fi 
}
