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
This file is the "brain" of the package. It contains:
*   **Purpose:** Clear description of what the skill/prompt does.
*   **Instructions:** Detailed guidance for the agent on how to use the package.
*   **Command Map:** (For skills) Mapping of intents to specific shell scripts in `scripts/`.
*   **Context Requirements:** Any files or state the agent needs to provide.

### 4.2 Portable Logic (`scripts/`)
Logic is implemented as modular shell scripts (`.sh`).
*   **Input/Output:** Scripts should prefer standard I/O (stdin/stdout) or simple file-based communication.
*   **Environment:** Assume a standard Unix-like environment (bash/zsh).

### 4.3 Versioning & Distribution
*   **Workspaces:** Managed via `npm`/`pnpm` workspaces in the root `package.json`.
*   **Publishing:** Each package can be published independently to a registry (e.g., npm) or consumed directly via git submodules/references.

## 5. Success Criteria
*   An agent (e.g., Gemini CLI) can discover and "load" a skill by reading its `SKILL.md`.
*   A user can copy a package into their own environment and have it "just work" with minimal setup.
*   New categories or packages can be added without breaking existing ones.
