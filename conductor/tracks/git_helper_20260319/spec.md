# Track Git Helper Specification

## Overview
Implement a foundational interactive skill, `git-helper`, within the `packages/skills/` directory. This skill will provide common git operations (status, diff, commit) and agentic guidelines for creating high-quality, atomic, conventional commits with emojis.

## User Stories
- As an AI agent, I want a standardized way to check the repository status.
- As an AI agent, I want to see differences in files before committing.
- As an AI agent, I want to follow a structured process for planning and executing atomic commits.
- As a user, I want the agent to use conventional commits with emojis.
- As a user, I want the agent to ask for my confirmation before performing any git commit or push.

## Functional Requirements
- **Status:** Display `git status --short`.
- **Diff:** Display `git diff` with optional file path.
- **Commit Helper:** (New) Logic for generating conventional commits with emojis.
- **Agentic Guidelines:** (New) A set of rules for agents to plan, categorize, stage, and commit changes in minimal atomic groups.
- **Portability:** The skill logic must be a POSIX-compliant shell script.
- **Metadata:** Include a `package.json` and a `SKILL.md` entrypoint.

## Commit Format
The skill will enforce or suggest the following format:
`<emoji> <type>: <description>`

Commit types and emojis (based on `adambullmer/semantic-commit-emoji`):
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

## Security Considerations
- **Human-in-the-Loop:** All destructive or external operations (commit, push) must pause for user approval.
- **No Secrets:** Ensure the script does not inadvertently log environment variables or secrets.
- **Input Validation:** Sanitize commit messages to prevent shell injection.
