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

create_backup() {
    local source="$1"
    local dest="$2"
    local folder_name
    local parent_dir
    local timestamp
    local archive
    local archive_path

    source="$(realpath "$source")" || return 1
    folder_name="$(basename "$source")"
    parent_dir="$(dirname "$source")"
    timestamp="$(date +%Y%m%d-%H%M%S)" || return 1

    if ! mkdr -p "$dest"; then
         printf 'Error: cannot create destination: %s\n' "$dest" >&2
         return 1
    fi

    archive="${folder_name}-${timestamp}.tar.gz"
    archive_path="${dest%/}/${archive}"

    if ! tar czf "$archive_path" -c "$parent_dir" "$folder_name"; then
        printf 'Error: backup creation failed: %s\n' "$archive" >&2
        rm -f -- "$archive_path"
        return 1
    fi

    printf 'backup created successfuly: %s\n' "$archive"
}
main() {
    # local option="${1:-}"

    # if [[ "$option" == "-h" ]]; then
    #     usage
    #     return 0
    # fi
    local option
    local SOURCE

    while getopts ":d:k:h" option; do 
        case "$option" in
            d) DEST="$OPTARG" ;;
            k) KEEP="$OPTARG" ;;
            h) usage; exit 0 ;;
            :) die "option -$OPTARG reqyuries a value" 2  ;;
            \?) die "unknown option: -$OPTARG" 2 ;;
        esac
    done

    shift "$((OPTIND - 1))"

    if [[ "$#" -ne 1 ]]; then
        die "just one SOURCE directory expected" 2
    fi

    SOURCE="$1"

    if [[ ! -d "$SOURCE" ]]; then 
        die "SOURCE is not an existing directory: $SOURCE" 2
    fi

    if [[ ! "$KEEP" =~ ^[1-9][0-9]*$ ]]; then 
        die "KEEP must be a positive whole number" 2
    fi

    # printf 'SOURCE=%s\n' "$SOURCE"
    # printf 'DEST=%s\n' "$DEST"
    # printf 'KEEP=%s\n' "$KEEP"

    if ! create_backup "$SOURCE" "$DEST"; then
    die "Backup failed" 1
    fi

    return 0            
}

main "$@"