# Git Decision Rules for Agents

Follow these rules to maintain a clean and auditable project history:

1. **Atomicity:** One logical change per commit. If a file has unrelated changes, use interactive staging (`git-helper stage <file> "s"`) to split them.
2. **Analysis First:** Always run `git-helper status` and `git-helper diff` before staging.
3. **Classification:** Group files by their impact (e.g., all `docs` changes first, then `feat`).
4. **Validation:** Review staged changes with `git-helper diff-staged` before committing.
5. **No Placeholders:** Never commit TODOs or commented-out code unless explicitly part of the task.
