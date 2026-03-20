# Tech Stack

## Architecture
- **Structure:** Category-first monorepo organized by package type (`skills`, `themes`, `prompts`, `tools`).
- **Management:** [Yarn Berry (v4)](https://yarnpkg.com/) workspaces with Corepack for version consistency.

## Languages & Formats
- **Logic:** [POSIX-compliant shell scripts](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html) for maximum portability across Unix-like systems.
- **Content:** Markdown (`.md`) with YAML frontmatter for prompts, skills, and documentation.
- **Metadata:** JSON (`.json`) for package definitions and configuration.
- **Themes:** JSON-based theme formats (e.g., Gemini CLI extension format).

## Quality & Tooling
- **Static Analysis:** [Shellcheck](https://www.shellcheck.net/) for validating all shell scripts.
- **Standardization:** EditorConfig for consistent whitespace and indentation across the codebase.
- **Isolation:** [DevContainers](https://containers.dev/) for secure, isolated testing and development.

## AI Agnosticism
- **Platform-Independent:** Packages are designed to be callable by any agent with access to a shell or Markdown interpreter.
- **Modular Interfacing:** Each package defines its own input/output contract within its entrypoint.
