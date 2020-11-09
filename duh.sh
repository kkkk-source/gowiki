#!/bin/bash
# duh is a stupid wrapper. It wraps docker's stop command providing 
# a high-level usage for that. duh only needs the container name 
# instead the CONTAINER ID to know which image to stop.

usage () {
    echo "usage:  duh COMMAND CONTAINER"
    echo
    echo "COMMAND:"
    echo "  stop  Stop the Docker Hub for images."
    echo
}

stop () {
    while IFS=" " read -r id img
    do
        if [ $img = "$1" ]; then
            docker stop $id
            exit $?
        fi
    done < <(docker ps --format "{{.ID}} {{.Image}}")
    echo
    echo duh: could not find ["$1"] docker image.
    exit 1
}

main () {
    if [ $# -lt 2 ]; then
        usage; exit 1
    fi

    case "$1" in
        stop)
            stop "$2"
            ;;
        *)
            usage; exit 1
            ;;
    esac
    exit 0
}

main "$@"
