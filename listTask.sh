#!/bin/bash
set -e -u -o pipefail

function show_help () {
    cat <<-EOF
        ${BASH_SOURCE%} [-d] [-h | -s | -p]
            -d, --debug     debug mode
            -h, --help      show help
            [-s,--show-all-task || -p,--show-percent]
EOF
}

for arg in "$@"
do
    if [[ "$arg" = "--debug" ]] || [[ "$arg" = "-d" ]]; then
        set -x
    fi
    if [ "$arg" = "--help" ] || [ "$arg" = "-h" ]; then
        show_help
        exit 0
    fi
    if [ "$arg" = "--show-all-task" ] || [ "$arg" = "-s" ]; then
        SHOW_MODE="show-all"
    fi
    if [ "$arg" = "--show-percent" ] || [ "$arg" = "-p" ]; then
        SHOW_MODE="show-percent"
    fi
done

DIR="${BASH_SOURCE%/*}"
source "$DIR/config.sh"
source "$DIR/common.sh"

login

if [ "${SHOW_MODE:-}" = "show-all" ]; then
    JQ=".data.tasks[] | [{id: .id, title: .title, status: .status, size: .size, downloaded: .additional.transfer.size_downloaded}] | sort_by(.title)  | .[] | \"\(.id)\t\(.title)\t\(.status)\""
elif [ "${SHOW_MODE:-}" = "show-percent" ]; then
    JQ=".data.tasks[] | [{id: .id, title: .title, status: .status, size: .size, downloaded: .additional.transfer.size_downloaded}] | sort_by(.title) | .[] |  select(.size != 0) | [.]  | .[] | \"\(.id)\t\(.title)\t\(.status)\t\((.downloaded / .size) * 100)%\""
else
    show_help
    echo "argument missing"
    exit 1
fi

curl -k -b "$COOKIE_FILE" \
    "$NAS_ENTRY/webapi/DownloadStation/task.cgi?api=SYNO.DownloadStation.Task&version=1&method=list&additional=detail,transfer" 2>/dev/null | \
    jq -r "$JQ" | column -s "	" -t

