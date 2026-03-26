#!/bin/sh
# git-helper.sh - Standardized git operations for AI agents

set -e

COMMAND=$1
shift

case "$COMMAND" in
    stage)
        if [ "$#" -eq 0 ]; then
            echo "Error: FILE_PATH is required for stage command."
            exit 1
        fi
        git add "$@"
        ;;
    commit)
        # Initialize variables
        MESSAGE=""
        SKIP_CONFIRM=0

        # Parse arguments
        while [ $# -gt 0 ]; do
            case "$1" in
                -y|--yes)
                    SKIP_CONFIRM=1
                    shift
                    ;;
                *)
                    if [ -z "$MESSAGE" ]; then
                        MESSAGE="$1"
                    fi
                    shift
                    ;;
            esac
        done

        if [ -z "$MESSAGE" ]; then
            echo "Usage: git-helper commit <message> [--yes]"
            exit 1
        fi

        echo "Prepared commit message:"
        echo "------------------------"
        echo "$MESSAGE"
        echo "------------------------"

        if [ "$SKIP_CONFIRM" -eq 0 ]; then
            printf "Do you want to proceed with this commit? (y/N): "
            read -r CONFIRM
            if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
                echo "Commit cancelled."
                exit 1
            fi
        fi

        git commit -m "$MESSAGE"
        ;;
    *)
        echo "Usage: sh scripts/git-helper.sh <stage|commit> [args]"
        exit 1
        ;;
esac
