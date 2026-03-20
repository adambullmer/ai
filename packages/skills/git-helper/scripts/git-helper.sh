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
    commit)
        # Handle arguments: commit <type> <scope> <description> [-y|--yes]
        TYPE=$1
        SCOPE=$2
        DESCRIPTION=$3
        FORCE_YES=$4

        EMOJI=$(get_emoji "$TYPE")
        MESSAGE="$EMOJI $TYPE($SCOPE): $DESCRIPTION"

        echo "Prepared commit message:"
        echo "------------------------"
        echo "$MESSAGE"
        echo "------------------------"

        # Check for confirmation unless -y is passed
        if [ "$FORCE_YES" != "-y" ] && [ "$FORCE_YES" != "--yes" ]; then
            printf "Do you want to proceed with this commit? (y/N): "
            # In a shell script context, we expect the user (or agent) to handle this
            # but for automated tests, we use the -y flag.
            read -r CONFIRM
            if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
                echo "Commit cancelled."
                exit 1
            fi
        fi

        git commit -m "$MESSAGE"
        ;;
    *)
        echo "Usage: sh scripts/git-helper.sh <status|diff|commit> [args]"
        exit 1
        ;;
esac
