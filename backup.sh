#!/bin/bash

DEST="$HOME/backups"
KEEP=5

usage() {
    cat <<EOF

    Usage: $(basename "$0") [-d DEST] [-k KEEP] SOURCE

    create a compressed, timestamped backup of a directory.

    Options:
    -d DEST     Backup destination (default: ~/backups)
    -k KEEP     How many backups to keep (default: 5)
    -h          Display this help message

EOF
}

die() {
    local message="$1"
    local exit_code="${2:-1}"

    printf 'Error: %s\n' "$message" >&2
    exit "$exit_code"

}

main() {
    local option="${1:-}"

    if [[ "$option" == "-h" ]]; then
        usage
        return 0
    fi
}

main "$@"