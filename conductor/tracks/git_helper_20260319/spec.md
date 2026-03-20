# Track Git Helper Specification

## Overview
Implement a foundational interactive skill, `git-helper`, within the `packages/skills/` directory. This skill will provide common git operations (status, diff, commit) in a format optimized for agent use, adhering to the project's security and quality standards.

## User Stories
- As an AI agent, I want a standardized way to check the repository status.
- As an AI agent, I want to see differences in files before committing.
- As a user, I want the agent to ask for my confirmation before performing any git commit or push.

## Functional Requirements
- **Status:** Display `git status --short`.
- **Diff:** Display `git diff` with optional file path.
- **Commit:** Perform `git commit -m "<message>"` ONLY after explicit user confirmation.
- **Portability:** The skill logic must be a POSIX-compliant shell script.
- **Metadata:** Include a `package.json` and a `SKILL.md` entrypoint.

## Security Considerations
- **Human-in-the-Loop:** All destructive or external operations (commit, push) must pause for user approval.
- **No Secrets:** Ensure the script does not inadvertently log environment variables or secrets.
- **Input Validation:** Sanitize commit messages to prevent shell injection.
