# Track Git Helper Staging Guidelines Specification

## Goal
Enhance the `git-helper` skill with explicit guidelines and autonomous, non-interactive workflows for determining which files to stage, grouping them by commit type, and narrowing down to grouping hunks by logical changes.

## Functional Requirements
- **`stage` command:**
  - If one argument: `git add "$1"`.
  - If two arguments: `printf "%s\n" $2 | git add -p "$1"`.
- **`diff-staged` command:** `git diff --staged "$@"` to view what's currently staged.
- **`commit` command:** Support `--yes` or `-y` to skip confirmation.
- **Guidelines:** Update `SKILL.md` and `README.md` with "Workflow: Atomic Staging & Grouping".

## Security Considerations
- Use `printf` safely for the `<responses>` string.
- Input validation for `<responses>` (only allow `y n s q a d j J g / e ?` and spaces).
