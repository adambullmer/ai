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
    # Test diff-staged
    sh "$SCRIPT_PATH" diff-staged | grep -q "test_stage_file"
    # Cleanup
    git reset test_stage_file > /dev/null 2>&1
    rm test_stage_file
}

test_stage_hunks() {
    echo "Running test: stage (hunks)"
    # Create a file that already exists in git (mocking it)
    # Actually, we can use an existing file or just create/add/commit then modify
    touch test_hunk_file
    echo "line 1" > test_hunk_file
    git add test_hunk_file
    git commit -m "chore: initial" --no-gpg-sign
    
    echo "line 2" >> test_hunk_file
    echo "line 3" >> test_hunk_file
    
    # Stage only first logical change (simulated by 'y')
    # Since it's only one hunk, 'y' will stage it all.
    # 'n' would stage nothing.
    sh "$SCRIPT_PATH" stage test_hunk_file "y"
    
    if ! git diff --staged --name-only | grep -q "test_hunk_file"; then
        echo "Error: test_hunk_file not staged with hunks"
        exit 1
    fi
    
    # Cleanup
    git reset --soft HEAD~1
    git reset test_hunk_file > /dev/null 2>&1
    rm test_hunk_file
}

test_commit() {
    echo "Running test: commit"
    # Create a temporary file to stage
    touch test_temp_file
    git add test_temp_file
    # Use -y to avoid confirmation in automated tests
    sh "$SCRIPT_PATH" commit "feat" "add login" "-y"
    # Cleanup: Revert the commit and remove the file
    git reset --soft HEAD~1 > /dev/null 2>&1
    git reset test_temp_file > /dev/null 2>&1
    rm test_temp_file
}

# Run tests
test_status
test_diff
test_stage
test_stage_hunks
test_commit

echo "All tests passed!"
