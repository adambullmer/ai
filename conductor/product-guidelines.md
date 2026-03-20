# Product Guidelines

## Prose & Communication
- **Tone:** Professional, direct, and concise, similar to a high-quality CLI manual.
- **Language:** Clear and accessible English, avoiding unnecessary jargon.
- **Documentation:** Every package must include a `README.md` that clearly explains its purpose, usage, and security considerations.

## Branding & Aesthetics
- **Visuals:** For themes, prioritize readability, high contrast, and accessibility.
- **Icons:** Use standardized icons or emojis consistently across packages.
- **Formatting:** Adhere to Markdown best practices for all documentation and prompt templates.

## User Experience (UX)
- **Interactive Prompts:** Design prompts to be clear and guided, minimizing the risk of agent error.
- **Errors:** Provide helpful, actionable error messages for all scripts and tools.
- **Inputs:** Validate all user inputs and agent outputs to ensure safe execution.

## Quality Standards
- **Compatibility:** All shell scripts must be POSIX-compliant to ensure they run on any Unix-like system.
- **Testing:** New packages are encouraged to include tests or a verification protocol.
- **Code Style:** Follow the project's selected style guides and pass `shellcheck` for all scripts.

## Security First
- **Visibility:** All scripts that perform potentially destructive or external actions (like git commits or API calls) MUST require explicit user confirmation.
- **Privacy:** Never log or output sensitive information (API keys, secrets).
- **Environment:** Encourage the use of isolated environments (DevContainers) for testing new skills.
