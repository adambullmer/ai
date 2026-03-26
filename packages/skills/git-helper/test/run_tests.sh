#!/bin/sh
# Simple test runner for git-helper

set -e

SCRIPT_PATH="./packages/skills/git-helper/scripts/git-helper.sh"

test_stage() {
    echo "Running test: stage"
    touch test_stage_file
    echo "line 1" > test_stage_file
    sh "$SCRIPT_PATH" stage test_stage_file
    # Verify staged
    if ! git diff --staged --name-only | grep -q "test_stage_file"; then
        echo "Error: test_stage_file not staged"
        exit 1
    fi
    # Cleanup
    git reset test_stage_file > /dev/null 2>&1
    rm test_stage_file
}

test_commit_inline() {
    echo "Running test: commit inline"
    touch test_temp_file
    git add test_temp_file
    sh "$SCRIPT_PATH" commit "✨ feat: add login" "-y"
    # Verify commit message
    if ! git log -1 --pretty=%B | grep -q "✨ feat: add login"; then
        echo "Error: commit message incorrect"
        exit 1
    fi
    # Cleanup
    git reset --soft HEAD~1 > /dev/null 2>&1
    git reset test_temp_file > /dev/null 2>&1
    rm test_temp_file
}

test_commit_heredoc() {
    echo "Running test: commit heredoc"
    touch test_temp_file_2
    git add test_temp_file_2
    
    sh "$SCRIPT_PATH" commit "$(cat << 'EOF'
✨ fix: multi line heredoc

body of the message
EOF
)" -y

    # Verify commit message
    if ! git log -1 --pretty=%B | grep -q "body of the message"; then
        echo "Error: commit message from heredoc incorrect"
        exit 1
    fi
    # Cleanup
    git reset --soft HEAD~1 > /dev/null 2>&1
    git reset test_temp_file_2 > /dev/null 2>&1
    rm test_temp_file_2
}

# Run tests
test_stage
test_commit_inline
test_commit_heredoc

echo "All tests passed!"
