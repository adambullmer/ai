# Conventional Commits Specification & Emojis

Follow this specification for all commit messages. Combine the appropriate emoji with the Conventional Commits structure.

1. **Structure:** 
   ```text
   <emoji> <type>[optional scope]: <description>

   <body>

   <footer>
   ```
2. **Breaking Changes:** INDICATE by a `!` after the type/scope (e.g., `✨ feat!: upgrade api version`) or as a footer.
3. **Description:** Use the imperative, present tense: "change" not "changed" nor "changes".
4. **Body:** Always provide a detailed body summarizing the "why" and "how" of the changes. Separate it from the description by a single blank line.
5. **Footer:** Always include a footer identifying yourself as the author (e.g., `Author: <Your Agent Name>`).
4. **Types and Emojis:**
   - ✨ **feat**: (NEW feature)
   - 🐛 **fix**: (Bug fix)
   - 📝 **docs**: (Documentation only)
   - ♻️ **refactor**: (Refactoring production code)
   - 🎨 **style**: (Formatting, missing semi-colons, etc; no code change)
   - 🔬 **test**: (Adding missing tests, refactoring tests)
   - ⚡ **perf**: (Performance improvements)
   - 🚑 **hotfix**: (Critical urgent fix)
   - 🌐 **locale**: (Translation and localization)
   - 👷 **ci**: (CI/CD scripts configuration)
   - 🔧 **chore**: (Updating build tasks, package configurations, etc; no production code change)
   - 🏷️ **types**: (Type definitions)

**Usage Example:**
```text
✨ feat(auth): add new authentication flow

- Implemented JWT token generation and validation
- Added login and registration endpoints
- Updated database schema for user tracking

Author: Antigravity
```
