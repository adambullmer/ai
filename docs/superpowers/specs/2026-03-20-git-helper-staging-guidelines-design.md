# Design Spec: Git Helper Staging Guidelines

## Goal
Enhance the `git-helper` skill with explicit guidelines and autonomous, non-interactive workflows for determining which files to stage, grouping them by commit type, and narrowing down to grouping hunks by logical changes.

## Proposed Changes

### 1. Update `SKILL.md`
Replace the existing "Agentic Guidelines" with a more detailed "Workflow: Atomic Staging & Grouping" section.

#### Workflow:
1. **Analyze (Inventory):** Run `sh scripts/git-helper.sh status` and `sh scripts/git-helper.sh diff` to understand all pending changes (tracked and untracked).
2. **Classify (Grouping by Type):** Mentally group modified/new files into Conventional Commit categories (`feat`, `fix`, `refactor`, etc.).
3. **Prioritize:** Decide which group to stage first (e.g., `fix` bugs before adding `feat` features).
4. **Interactive Staging (Hunk Grouping):**
    - For **untracked files**, use `sh scripts/git-helper.sh stage <file>`. This will perform a full `git add`.
    - For **tracked files**, use `sh scripts/git-helper.sh stage <file> "<responses>"`.
    - **Note for Agents:** `<responses>` is a space-separated string of characters (e.g., `y`, `n`, `s`, `q`).
    - Use `s` to split a hunk into smaller pieces if it contains multiple logical changes.
    - End the string with `q` to quit the interactive session after staging the desired hunks.
5. **Verify:** Run `sh scripts/git-helper.sh diff-staged` to ensure the staging area contains ONLY the intended logical unit.
6. **Commit:** Use `sh scripts/git-helper.sh commit <type> "<description>" --yes` to finalize the atomic unit. The `--yes` flag is REQUIRED for autonomous execution to skip the confirmation prompt.
7. **Repeat:** Continue until all changes are committed or stashed.

### 2. Update `scripts/git-helper.sh`
- **`stage` command:**
  - If only one argument is provided: run `git add "$1"`.
  - If two arguments are provided: run `printf "%s\n" $2 | git add -p "$1"`. (Ensures each character is on a new line for the pipe).
- **`diff-staged` command:** `git diff --staged "$@"` to view what's currently staged.
- **`commit` command:** Ensure it accepts `--yes` or `-y` to skip the interactive `read -r` prompt.

### 3. Update `README.md`
- Synchronize with the new `SKILL.md` workflow.

## Success Criteria
- The agent can clearly articulate the groups of changes before staging.
- Commits are truly atomic, even when multiple logical changes exist in the same file.
- The `git-helper` script provides a consistent, non-interactive interface for the entire workflow.

## Security Considerations
- The `stage` command must use `printf` safely to avoid shell injection through the responses string.
- Input validation for the `<responses>` string (only allow `y n s q a d j J g / e ?` and spaces).
