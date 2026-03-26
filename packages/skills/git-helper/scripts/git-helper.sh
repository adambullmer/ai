#!/bin/sh
# git-helper.sh - Standardized git operations for AI agents

set -e

COMMAND=$1
shift

case "$COMMAND" in
    status)
        git status --short
        ;;
    diff)
        FILE_PATH=$1
        if [ -n "$FILE_PATH" ]; then
            git diff "$FILE_PATH"
        else
            git diff
        fi
        ;;
    stage)
        FILE_PATH=$1
        RESPONSES=$2
        if [ -z "$FILE_PATH" ]; then
            echo "Error: FILE_PATH is required for stage command."
            exit 1
        fi
        if [ -z "$RESPONSES" ]; then
            git add "$FILE_PATH"
        else
            # Sanitize RESPONSES: only allow y, n, s, q, a, d, j, J, g, /, e, ?, and spaces
            CLEAN_RESPONSES=$(printf "%s" "$RESPONSES" | tr -cd 'ynsqadjJg/e? ')
            if [ "$RESPONSES" != "$CLEAN_RESPONSES" ]; then
                echo "Error: Invalid characters in responses."
                exit 1
            fi
            # Pipe responses to git add -p
            # Use printf to send each character on a new line to git add -p
            # shellcheck disable=SC2086
            printf "%s\n" $CLEAN_RESPONSES | git add -p "$FILE_PATH"
        fi
        ;;
    diff-staged)
        git diff --staged "$@"
        ;;
    commit)
        # Initialize variables
        MESSAGE=""
        SKIP_CONFIRM=0

        # Parse arguments
        for arg in "$@"; do
            case "$arg" in
                -y|--yes)
                    SKIP_CONFIRM=1
                    ;;
                *)
                    if [ -z "$MESSAGE" ]; then
                        MESSAGE="$arg"
                    fi
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
        echo "Usage: sh scripts/git-helper.sh <status|diff|stage|diff-staged|commit> [args]"
        exit 1
        ;;
esac
