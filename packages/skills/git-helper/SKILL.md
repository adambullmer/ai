---
name: git-helper
version: 2.0.0
type: skill
description: Standardized git operations for AI agents with modular instructions for conventional, atomic commits.
---

# Skill: Git Helper

Standardized git operations for AI agents with human-in-the-loop safety and agentic guidelines for atomic, conventional commits.

## Instructions

To ensure high-quality project history, you MUST follow these modular instructions:

1. **[Conventional Commits Spec](instructions/spec.md):** Rules for message structure and types.
2. **[Semantic Emoji Mapping](instructions/emojis.md):** Mapping commit types to visual emojis.
3. **[Atomic Staging Rules](instructions/rules.md):** Decision logic for grouping changes and staging.

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
Record changes to the repository.
- **CRITICAL:** Use the `--yes` flag for autonomous execution to skip the confirmation prompt.
- **Process:** You MUST format the message yourself using the [Spec](instructions/spec.md) and [Emoji Mapping](instructions/emojis.md).
- **Format:** `<emoji> <type>: <description>`
- **Command:** `sh scripts/git-helper.sh commit "<formatted_message>" --yes`

## Workflow: Atomic Staging & Grouping

Follow the [Atomic Staging Rules](instructions/rules.md) for every operation.

1.  **Analyze (Inventory):** Run `sh scripts/git-helper.sh status` and `sh scripts/git-helper.sh diff`.
2.  **Classify (Grouping):** Consult `instructions/rules.md` to group changes by type and priority.
3.  **Stage:** Use `sh scripts/git-helper.sh stage` to move changes to the index.
4.  **Verify:** Run `sh scripts/git-helper.sh diff-staged` to ensure the staging area contains ONLY the intended logical unit.
5.  **Commit:** Prepare the message using `instructions/spec.md` and `instructions/emojis.md`, then run `sh scripts/git-helper.sh commit "<message>" --yes`.
6.  **Repeat:** Continue until all changes are committed.

## Security Considerations
- **Human-in-the-Loop:** All destructive or external operations (commit, push) must pause for user approval unless `--yes` is used.
- **No Secrets:** The script is designed to avoid logging sensitive information.
