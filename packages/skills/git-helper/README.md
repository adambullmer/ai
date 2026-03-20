# Git Helper Skill

Standardized git operations for AI agents with human-in-the-loop safety and agentic guidelines for high-quality, atomic, conventional commits.

## Overview

The `git-helper` skill provides a consistent interface for AI agents to interact with a Git repository. It enforces conventional commit standards and encourages atomic commits, ensuring a clean and auditable project history.

## Installation

This skill is part of the AI monorepo. To use it, ensure your agent has access to the `packages/skills/git-helper/` directory.

## Commands

### `status`
Display the current state of the working directory and the staging area.
```bash
sh scripts/git-helper.sh status
```

### `diff`
Show changes between the working directory and the index.
```bash
sh scripts/git-helper.sh diff [file_path]
```

### `commit`
Record changes to the repository using conventional commit format with emojis.
- **Format:** `<emoji> <type>(<scope>): <description>`
- **Command:** `sh scripts/git-helper.sh commit "type" "scope" "description"`

#### Supported Types & Emojis
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

## Agentic Guidelines: Atomic Commits

Agents MUST follow these steps to ensure high-quality, auditable project history:

1.  **Analyze & Plan:** Read the current state of the workspace (`git status` and `git diff`). Group related changes into minimal, atomic, logical units.
2.  **Categorize:** For each group, identify the appropriate conventional commit type and emoji from the list above.
3.  **Stage Incrementally:** Stage ONLY the files or hunks relevant to the current atomic unit.
4.  **Execute Commit:** Use the `commit` command with the appropriate type, scope, and description.
5.  **Verify & Repeat:** Confirm the commit was successful and repeat the process for the next group of changes until all work is committed.

## Security Considerations

- **Human-in-the-Loop:** All destructive or external operations (commit, push) MUST pause for user approval. The `commit` command will prompt for confirmation unless a force flag is provided.
- **No Secrets:** The script avoids logging sensitive information. Always use environment variables for credentials and never commit them.
- **Input Validation:** Commit messages are processed as arguments to avoid shell injection.
