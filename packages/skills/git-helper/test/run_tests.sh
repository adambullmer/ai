#!/bin/sh
# Simple test runner for git-helper

set -e

SCRIPT_PATH="./packages/skills/git-helper/scripts/git-helper.sh"

test_status() {
    echo "Running test: status"
    sh "$SCRIPT_PATH" status
}

test_diff() {
    echo "Running test: diff"
    sh "$SCRIPT_PATH" diff
}

test_commit() {
    echo "Running test: commit"
    # Create a temporary file to stage
    touch test_temp_file
    git add test_temp_file
    # Use -y to avoid confirmation in automated tests
    sh "$SCRIPT_PATH" commit "feat" "auth" "add login" "-y"
    # Cleanup: Revert the commit and remove the file
    git reset --soft HEAD~1 > /dev/null 2>&1
    git reset test_temp_file > /dev/null 2>&1
    rm test_temp_file
}

# Run tests
test_status
test_diff
test_commit

echo "All tests passed!"
