---
name: git-helper
version: 1.0.0
type: skill
description: Standardized git operations for AI agents with human-in-the-loop safety and agentic guidelines for atomic, conventional commits.
---

# Skill: Git Helper

Standardized git operations for AI agents with human-in-the-loop safety and agentic guidelines for atomic, conventional commits.

## Commands

### `status`
Display the current state of the working directory and the staging area.
- **Command:** `sh scripts/git-helper.sh status`

### `diff`
Show changes between the working directory and the index.
- **Command:** `sh scripts/git-helper.sh diff [file_path]`

### `stage`
Stage changes into the index (staging area).
- **For untracked files:** Performs a full `git add`.
  - **Command:** `sh scripts/git-helper.sh stage <file>`
- **For tracked files (Interactive Hunk Grouping):** Use a space-separated string of characters (e.g., `y`, `n`, `s`, `q`).
  - **Command:** `sh scripts/git-helper.sh stage <file> "<responses>"`
  - **Note for Agents:**
    - Use `s` to split a hunk into smaller pieces if it contains multiple logical changes.
    - End the string with `q` to quit the interactive session after staging the desired hunks.

### `diff-staged`
Show changes between the index and the last commit.
- **Command:** `sh scripts/git-helper.sh diff-staged`

### `commit`
Record changes to the repository using conventional commit format with emojis.
- **CRITICAL:** Use the `--yes` flag for autonomous execution to skip the confirmation prompt.
- **Format:** `<emoji> <type>: <description>`
- **Command:** `sh scripts/git-helper.sh commit <type> "<description>" --yes`

## Workflow: Atomic Staging & Grouping

Agents MUST follow these steps to ensure high-quality, auditable project history:

1.  **Analyze (Inventory):** Run `sh scripts/git-helper.sh status` and `sh scripts/git-helper.sh diff` to understand all pending changes (tracked and untracked).
2.  **Classify (Grouping by Type):** Mentally group modified/new files into Conventional Commit categories (`feat`, `fix`, `refactor`, etc.).
3.  **Prioritize:** Decide which group to stage first (e.g., fix bugs before adding `feat` features).
4.  **Interactive Staging (Hunk Grouping):**
    - For untracked files, use `sh scripts/git-helper.sh stage <file>`. This will perform a full `git add`.
    - For tracked files, use `sh scripts/git-helper.sh stage <file> "<responses>"`.
    - **Note for Agents:** `<responses>` is a space-separated string of characters (e.g., `y`, `n`, `s`, `q`).
    - Use `s` to split a hunk into smaller pieces if it contains multiple logical changes.
    - End the string with `q` to quit the interactive session after staging the desired hunks.
5.  **Verify:** Run `sh scripts/git-helper.sh diff-staged` to ensure the staging area contains ONLY the intended logical unit.
6.  **Commit:** Use `sh scripts/git-helper.sh commit <type> "<description>" --yes` to finalize the atomic unit. The `--yes` flag is REQUIRED for autonomous execution to skip the confirmation prompt.
7.  **Repeat:** Continue until all changes are committed or stashed.

## Security Considerations
- **Human-in-the-Loop:** All destructive or external operations (commit, push) must pause for user approval unless `--yes` is used.
- **No Secrets:** The script is designed to avoid logging sensitive information.
