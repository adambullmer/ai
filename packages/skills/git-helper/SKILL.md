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

1. **[Conventional Commits & Emojis Spec](instructions/commit-spec.md):** Rules for message structure, Types, and Emojis.

## Guidelines & Rules

Follow these rules to maintain a clean and auditable project history:
1. **Atomicity:** One logical change per commit. If a file has unrelated changes, separate your work by committing the desired changes first, or use `git apply --cached` with a patch file to stage specific lines.
2. **Analysis First:** Always run standard `git status --short` and `git diff` before staging.
3. **Classification:** Group files by their impact (e.g., all `docs` changes first, then `feat`).
4. **Validation:** Review staged changes with standard `git diff --staged` before committing.
5. **No Placeholders:** Never commit TODOs or commented-out code unless explicitly part of the task.

## Commands

### `stage`
Stage changes into the index (staging area).
- **Command:** `sh scripts/git-helper.sh stage <file1> [file2...]`

### `commit`
Record changes to the repository.
- **CRITICAL:** Use the `--yes` flag for autonomous execution to skip the confirmation prompt.
- **Process:** You MUST format the message yourself using the [Conventional Commits & Emojis Spec](instructions/commit-spec.md).
- **Command:** Use a HEREDOC to pass multiline messages (required for bodies and footers) safely:
  ```bash
  sh scripts/git-helper.sh commit "$(cat << 'EOF'
  <emoji> <type>[optional scope]: <description>

  <body>

  <footer>
  EOF
  )" --yes
  ```

## Standard Git Workflow

For operations that do not require special formatting or agent safety wrappers, use standard Git commands:
- **Analyze:** `git status --short` and `git diff`
- **Verify:** `git diff --staged`

## Workflow: Atomic Staging & Grouping

Follow the **Guidelines & Rules** defined above for every operation.

1.  **Analyze (Inventory):** Run standard `git status --short` and `git diff`.
2.  **Classify (Grouping):** Consult the Guidelines to group changes by type and priority.
3.  **Stage:** Use `sh scripts/git-helper.sh stage <file>` to move changes to the index. If you need to stage specific lines, create a patch file and use `git apply --cached`.
4.  **Verify:** Run standard `git diff --staged` to ensure the staging area contains ONLY the intended logical unit.
5.  **Commit:** Prepare the message using `instructions/commit-spec.md`, then run `sh scripts/git-helper.sh commit` using the HEREDOC format to handle the required multiline bodies.
6.  **Repeat:** Continue until all changes are committed.

## Security Considerations
- **Human-in-the-Loop:** All destructive or external operations (commit, push) must pause for user approval unless `--yes` is used.
- **No Secrets:** The script is designed to avoid logging sensitive information.
