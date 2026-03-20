# Design Doc: AI Monorepo Structure

**Status:** Draft
**Date:** 2026-03-19
**Author:** Gemini CLI

## 1. Purpose
The goal is to create a community-accessible monorepo for AI skills, themes, and prompts. These assets should be platform-agnostic, usable by various agents (Gemini, Cursor, Claude, Copilot, etc.), and organized as standalone, versioned packages.

## 2. Goals & Constraints
*   **Platform-Agnostic:** Assets must work across different AI agents.
*   **Versioned Packages:** Each asset (skill, theme, prompt) is a standalone, versionable package.
*   **Community-Ready:** Clear structure for discovery and contribution.
*   **Minimalist Core:** Initial implementation focuses on Markdown and Shell scripts for maximum portability.
*   **Standard Entrypoint:** Each package includes a standard `SKILL.md` (or `PROMPT.md`, `THEME.md`) as the primary agent-readable interface.

## 3. Architecture

### 3.1 Root Directory Layout
The repository uses a category-first organization within a `packages/` directory.

```text
ai/
├── packages/              # All versioned, standalone packages
│   ├── skills/            # Interactive capabilities (e.g., git-helper, web-search)
│   ├── themes/            # UI/UX customizations (e.g., syntax highlighting, CLI themes)
│   ├── prompts/           # Specialized prompt collections (e.g., system, persona)
│   └── tools/             # Shared utilities (e.g., parsers, CLI wrappers)
├── docs/                  # Global documentation and specs
├── .github/               # CI/CD for automated testing and publishing
├── package.json           # Monorepo configuration (workspaces)
└── README.md              # Community-facing entry point
```

### 3.2 Individual Package Structure
Each package is self-contained and follows a consistent internal layout.

```text
packages/<category>/<package-name>/
├── <TYPE>.md           # Standard AI Entrypoint (e.g., SKILL.md, PROMPT.md)
├── scripts/            # Shell scripts for logic/capabilities
├── templates/          # Supporting prompt markdown components
├── package.json        # Versioning, metadata, and scripts
├── README.md           # Human-facing documentation (usage, setup)
└── LICENSE             # Package-specific license
```

## 4. Components

### 4.1 AI-Readable Entrypoint (`SKILL.md`, etc.)
This file is the "brain" of the package. It MUST include a YAML frontmatter block for structured metadata.

```markdown
---
name: git-helper
version: 1.0.0
type: skill
description: Summarizes git status and proposes commit messages.
inputs:
  - name: repo_path
    description: Absolute path to the git repository.
    required: true
commands:
  - intent: summarize_changes
    script: scripts/summarize.sh
    arguments: ["{{repo_path}}"]
---

# Git Helper
...
```

### 4.2 Portable Logic (`scripts/`)
Logic is implemented as modular shell scripts (`.sh`).
*   **Standards:** Scripts MUST be POSIX-compliant and pass `shellcheck`.
*   **Runtime:** The repository provides a standard `.devcontainer` configuration to ensure a consistent execution environment across Linux, macOS, and Windows (via WSL/Docker).

### 4.3 Versioning & Distribution
*   **Workspaces:** Managed via `npm`/`pnpm` workspaces.
*   **Release Management:** Uses [Changesets](https://github.com/changesets/changesets) for automated versioning and changelog generation across independent packages.

## 5. Security & Safety

### 5.1 Script Execution Policy
To mitigate risks of arbitrary code execution:
*   **Human-in-the-Loop:** Agents MUST NOT execute scripts without explicit user confirmation.
*   **Sandboxing:** Execution is recommended within a DevContainer or isolated environment.
*   **Verified Contributors:** Contributions from new community members undergo mandatory manual review before being marked as "Verified."

### 5.2 Secrets & Credentials
*   **No Hardcoded Secrets:** Scripts MUST NOT contain or store API keys or credentials.
*   **Environment Variables:** All sensitive data must be passed via environment variables, managed by the host agent/environment.

## 6. Success Criteria
*   An agent (e.g., Gemini CLI) can programmatically parse the `SKILL.md` frontmatter.
*   Scripts are verified as POSIX-compliant, ensuring broad portability.
*   The security policy provides a clear framework for safe community contributions.
