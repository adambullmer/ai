#!/bin/sh
# git-helper.sh - Standardized git operations for AI agents

set -e

COMMAND=$1
shift

# Emoji Mapping (based on adambullmer/semantic-commit-emoji)
get_emoji() {
    TYPE=$1
    case "$TYPE" in
        feat)     echo "✨" ;;
        fix)      echo "🐛" ;;
        docs)     echo "📝" ;;
        refactor) echo "♻️" ;;
        style)    echo "🎨" ;;
        test)     echo "🔬" ;;
        perf)     echo "⚡" ;;
        hotfix)   echo "🚑" ;;
        locale)   echo "🌐" ;;
        ci)       echo "👷" ;;
        chore)    echo "🔧" ;;
        types)    echo "🏷️" ;;
        *)        echo "📝" ;; # Default to docs
    esac
}

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
        FILENAME=$1
        RESPONSES=$2
        if [ -z "$RESPONSES" ]; then
            git add "$FILENAME"
        else
            # Sanitize RESPONSES: only allow y, n, s, q, a, d, j, J, g, /, e, ?, and spaces
            CLEAN_RESPONSES=$(printf "%s" "$RESPONSES" | tr -cd 'ynsqadjJg/e? ')
            if [ "$RESPONSES" != "$CLEAN_RESPONSES" ]; then
                echo "Error: Invalid characters in responses."
                exit 1
            fi
            # Pipe responses to git add -p
            # We use printf to ensure each character is followed by a newline
            printf "%s\n" $CLEAN_RESPONSES | git add -p "$FILENAME"
        fi
        ;;
    diff-staged)
        git diff --staged "$@"
        ;;
    commit)
        # Initialize variables
        TYPE=""
        DESCRIPTION=""
        SKIP_CONFIRM=0

        # Parse arguments
        for arg in "$@"; do
            case "$arg" in
                -y|--yes)
                    SKIP_CONFIRM=1
                    ;;
                *)
                    if [ -z "$TYPE" ]; then
                        TYPE="$arg"
                    elif [ -z "$DESCRIPTION" ]; then
                        DESCRIPTION="$arg"
                    fi
                    ;;
            esac
        done

        if [ -z "$TYPE" ] || [ -z "$DESCRIPTION" ]; then
            echo "Usage: git-helper commit <type> <description> [--yes]"
            exit 1
        fi

        EMOJI=$(get_emoji "$TYPE")
        MESSAGE="$EMOJI $TYPE: $DESCRIPTION"

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
