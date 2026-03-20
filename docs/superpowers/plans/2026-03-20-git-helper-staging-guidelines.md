# Git Helper Staging Guidelines Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enhance `git-helper` with autonomous, non-interactive staging and atomic grouping guidelines.

**Architecture:** Update the `git-helper.sh` script to support piped input for `git add -p` and enhance `SKILL.md` with detailed workflows.

**Tech Stack:** POSIX Shell, Git

---

### Task 1: Update `scripts/git-helper.sh` to support non-interactive staging

**Files:**
- Modify: `packages/skills/git-helper/scripts/git-helper.sh`

- [ ] **Step 1: Implement `stage` command with non-interactive support**
  Modify the `case "$COMMAND" in` block to handle `stage`.
  ```sh
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
  ```

- [ ] **Step 2: Implement `diff-staged` command**
  Add `diff-staged` to the `case` block.
  ```sh
    diff-staged)
        git diff --staged "$@"
        ;;
  ```

- [ ] **Step 3: Update `commit` command to handle `--yes` correctly**
  Replace the `commit)` block with the following logic that properly handles flags and positional arguments.
  ```sh
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
  ```

- [ ] **Step 4: Commit script changes**
  ```bash
  git add packages/skills/git-helper/scripts/git-helper.sh
  git commit -m "feat(git-helper): add non-interactive stage and diff-staged commands"
  ```

---

### Task 2: Update `SKILL.md` with detailed guidelines

**Files:**
- Modify: `packages/skills/git-helper/SKILL.md`

- [ ] **Step 1: Replace "Agentic Guidelines" with "Workflow: Atomic Staging & Grouping"**
  Include the step-by-step autonomous workflow from the design spec.

- [ ] **Step 2: Update "Commands" section**
  Add `stage` and `diff-staged` to the list of available commands.

- [ ] **Step 3: Commit documentation changes**
  ```bash
  git add packages/skills/git-helper/SKILL.md
  git commit -m "docs(git-helper): add detailed atomic staging workflow to SKILL.md"
  ```

---

### Task 3: Update `README.md`

**Files:**
- Modify: `packages/skills/git-helper/README.md`

- [ ] **Step 1: Sync README with SKILL.md**
  Update the "Usage" and "Agentic Guidelines" sections to reflect the new commands and workflow.

- [ ] **Step 2: Commit README changes**
  ```bash
  git add packages/skills/git-helper/README.md
  git commit -m "docs(git-helper): update README with new commands and guidelines"
  ```

---

### Task 4: Verify with tests

**Files:**
- Modify: `packages/skills/git-helper/test/run_tests.sh`

- [ ] **Step 1: Add tests for `stage` (untracked and hunks)**
  Append the following test functions to `run_tests.sh`.
  ```sh
  test_stage_untracked() {
      echo "Running test: stage (untracked)"
      touch untracked_file
      sh "$SCRIPT_PATH" stage untracked_file
      git status --short | grep -q "^A  untracked_file"
      git reset HEAD untracked_file > /dev/null
      rm untracked_file
  }

  test_stage_hunks() {
      echo "Running test: stage (hunks)"
      # Create a 10-line file
      printf "line1\nline2\nline3\nline4\nline5\nline6\nline7\nline8\nline9\nline10\n" > hunk_file
      git add hunk_file
      git commit -m "base" --quiet
      # Modify line 1 and line 10
      printf "line1 mod\nline2\nline3\nline4\nline5\nline6\nline7\nline8\nline9\nline10 mod\n" > hunk_file
      # Hunk 1 (line1 mod), Hunk 2 (line10 mod)
      # Responses: y (stage 1st), n (skip 2nd), q (quit)
      sh "$SCRIPT_PATH" stage hunk_file "y n q"
      git diff --staged hunk_file | grep -q "+line1 mod"
      if git diff --staged hunk_file | grep -q "+line10 mod"; then
          echo "Error: Hunk 2 should not be staged"
          exit 1
      fi
      git reset --hard HEAD~1 --quiet
      rm hunk_file
  }

  test_commit_yes() {
      echo "Running test: commit --yes"
      touch test_yes_file
      git add test_yes_file
      # This should not hang or prompt
      sh "$SCRIPT_PATH" commit "feat" "test yes" "--yes"
      git log -1 --pretty=%s | grep -q "feat: test yes"
      git reset --soft HEAD~1 --quiet
      git reset test_yes_file --quiet
      rm test_yes_file
  }
  ```

- [ ] **Step 2: Update the execution loop in `run_tests.sh`**
  Add the new tests to the list of called functions.
  ```sh
  # Run tests
  test_status
  test_diff
  test_commit
  test_stage_untracked
  test_stage_hunks
  test_commit_yes
  ```

- [ ] **Step 3: Run all tests and verify**
  Run: `sh packages/skills/git-helper/test/run_tests.sh`
  Expected: All tests pass.

- [ ] **Step 4: Commit test changes**
  ```bash
  git add packages/skills/git-helper/test/run_tests.sh
  git commit -m "test(git-helper): add tests for new staging and commit functionality"
  ```
