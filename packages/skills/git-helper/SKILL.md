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
- **CRITICAL:** Use the `--yes` flag to bypass the CLI prompt, but you MUST request and receive explicit conversational approval from the user BEFORE executing this command. Present the affected files, the reasoning for the commit breakdown, and the drafted commit message for their review (do NOT print the raw `git diff`).
- **Process:** You MUST format the message yourself using the [Conventional Commits & Emojis Spec](instructions/commit-spec.md).
- **Authorship:** You MUST use the `--author` flag to append a Git Trailer identifying yourself natively.
- **Command:** Use a HEREDOC to pass multiline messages (required for bodies) safely:
  ```bash
  sh scripts/git-helper.sh commit "$(cat << 'EOF'
  <emoji> <type>[optional scope]: <description>

  <body>
  EOF
  )" --author "<Your Agent Name>" --yes
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
5.  **Review (Human-in-the-Loop):** Draft the commit message using `instructions/commit-spec.md`. Present the affected files, your reasoning for grouping them into this commit, and the drafted commit message to the user for explicit conversational approval. Do NOT print the raw `git diff` as it clutters the chat. You MUST wait for their confirmation before proceeding.
6.  **Commit:** After approval is given, run `sh scripts/git-helper.sh commit` using the HEREDOC format with the `--yes` flag.
7.  **Repeat:** Continue until all changes are committed.

## Security Considerations
- **Human-in-the-Loop:** All destructive or external operations (commit, push) must pause for user approval unless `--yes` is used.
- **No Secrets:** The script is designed to avoid logging sensitive information.
