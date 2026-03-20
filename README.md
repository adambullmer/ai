# AI Monorepo

A community-driven, platform-agnostic collection of AI skills, themes, and prompts. This repository is organized as a monorepo of standalone, versioned packages designed to be usable by any general agent (Gemini, Cursor, Claude, Copilot, etc.).

## 🚀 Structure

The repository uses a category-first organization:

- `packages/skills/`: Interactive capabilities (e.g., git helpers, search tools).
- `packages/themes/`: UI/UX customizations for AI interfaces (e.g., Gemini CLI themes).
- `packages/prompts/`: Specialized prompt collections and templates.
- `packages/tools/`: Shared utilities and CLI wrappers.

## 🛠️ Getting Started

This repository uses **Yarn Berry (v4)** with **Corepack** for package management.

### Prerequisites

Enable Corepack to ensure the correct Yarn version is used:
```bash
corepack enable
```

### Installation

```bash
yarn install
```

## 🏗️ Creating a New Package

Each package should follow the standard structure defined in the [Design Specification](docs/superpowers/specs/2026-03-19-ai-monorepo-structure-design.md):

1. **Entrypoint:** A `<TYPE>.md` file (e.g., `SKILL.md`, `THEME.md`) with YAML frontmatter.
2. **Logic:** Portable shell scripts in `scripts/` (if applicable).
3. **Metadata:** A `package.json` for versioning and a `README.md` for documentation.

## 🛡️ Security

- **Human-in-the-Loop:** Agents should never execute scripts from this repo without explicit user confirmation.
- **Sandboxing:** We recommend running skills and tools within a [DevContainer](.devcontainer/) or isolated environment.
- **No Secrets:** Never commit API keys or credentials. Use environment variables.

## 🤝 Contributing

Contributions are welcome! Please ensure all scripts are POSIX-compliant and pass `shellcheck`. New packages should include a `package.json` and follow the established directory structure.

## 📜 License

Each package within the `packages/` directory may have its own license. See individual package directories for details. The root repository is licensed under the MIT License.
