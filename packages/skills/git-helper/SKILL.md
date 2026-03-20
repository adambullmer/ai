# Skill: Git Helper

Standardized git operations for AI agents with human-in-the-loop safety and agentic guidelines for atomic, conventional commits.

## Commands

### `status`
Display the current state of the working directory and the staging area.
- **Command:** `sh scripts/git-helper.sh status`

### `diff`
Show changes between the working directory and the index.
- **Command:** `sh scripts/git-helper.sh diff [file_path]`

### `commit`
Record changes to the repository using conventional commit format with emojis.
- **CRITICAL:** This command requires explicit user confirmation before execution.
- **Format:** `<emoji> <type>: <description>`
- **Command:** `sh scripts/git-helper.sh commit "type" "description"`

## Agentic Guidelines: Atomic Commits

Agents MUST follow these steps to ensure high-quality, auditable project history:

1.  **Analyze & Plan:** Read the current state of the workspace (`git status` and `git diff`). Group related changes into minimal, atomic, logical units.
2.  **Categorize:** For each group, identify the conventional commit type and emoji:
    - `✨ feat`: New feature
    - `🐛 fix`: Bug fix
    - `📝 docs`: Documentation only
    - `♻️ refactor`: Code change that neither fixes a bug nor adds a feature
    - `🎨 style`: Formatting, missing semicolons, etc.
    - `🔬 test`: Adding missing tests
    - `⚡ perf`: Performance improvement
    - `🚑 hotfix`: Critical bug fix
    - `🌐 locale`: Internationalization and localization
    - `👷 ci`: CI related changes
    - `🔧 chore`: Maintenance tasks
    - `🏷️ types`: Type definitions
3.  **Stage Incrementally:** Stage ONLY the files or hunks relevant to the current atomic unit.
4.  **Execute Commit:** Use the `commit` command with the appropriate type and description.
5.  **Verify & Repeat:** Confirm the commit was successful and repeat the process for the next group of changes until all work is committed.

## Security Considerations
- **Human-in-the-Loop:** All destructive or external operations (commit, push) must pause for user approval.
- **No Secrets:** The script is designed to avoid logging sensitive information.
