# Design: Git-Helper Skill Refactor (Instruction-Heavy)

## 1. Problem Statement
The current `git-helper` skill contains formatting logic (emoji mappings) within a shell script and a monolithic instruction set in `SKILL.md`. This makes the skill harder to maintain, less transparent for the AI to follow, and complicates the script where the Git CLI is already sufficient.

## 2. Goals
- Modularize instructions into discrete specifications.
- Simplify the `git-helper.sh` shell script by offloading message formatting to the AI.
- Increase the AI's "contextual awareness" of Conventional Commits and atomic staging rules.

## 3. Architecture

### 3.1 File Structure
The refactoring will reorganize the `git-helper` directory:
```text
packages/skills/git-helper/
├── SKILL.md                 # Entry point, tool reference, and high-level workflow
├── instructions/            # Modular instructions for AI consumption
│   ├── spec.md              # Conventional Commits 1.0.0 Specification
│   ├── emojis.md            # Mapping for semantic emojis (transferred from script)
│   └── rules.md             # Decision-making logic for atomic staging
└── scripts/
    └── git-helper.sh        # Simplified wrapper for standard Git CLI commands
```

### 3.2 Data Flow
1. **Analyze:** AI runs `git-helper status` and `git-helper diff`.
2. **Contextualize:** AI consults `instructions/rules.md` to determine how to group changes.
3. **Format:** AI consults `instructions/spec.md` and `instructions/emojis.md` to prepare the commit message.
4. **Action:** AI invokes `git-helper commit "<full message>" --yes`.

## 4. Components

### 4.1 instructions/spec.md
Contains a concise version of the Conventional Commits 1.0.0 specification, emphasizing:
- The format: `<type>[optional scope]: <description>`
- The use of `!` for breaking changes.
- Footers for metadata.

### 4.2 instructions/emojis.md
Transfers the mapping from `git-helper.sh`:
- `feat` -> `✨`
- `fix` -> `🐛`
- `refactor` -> `♻️`
- `docs` -> `📝`
- `perf` -> `⚡`
- etc.

### 4.3 instructions/rules.md
Defines the AI's decision logic:
- Always prefer atomic commits.
- Don't stage unrelated files together.
- Use interactive staging (`add -p`) when multiple hunks in one file belong to different commit types.
- How to prioritize fixes over features.

### 4.4 git-helper.sh
Revised to:
- Remove `get_emoji()` and internal formatting logic.
- Accept a single message string for `commit`.
- Use standard `git` subcommands directly where possible.

## 5. Security & Safety
- Maintain the `--yes` requirement for autonomous commits to avoid accidental execution.
- Ensure the script still blocks or warns before destructive operations when used manually (though it's primarily for AI use).

## 6. Testing Strategy
- Update existing tests in `test/` to reflect the new `commit` command signature.
- Verify that the AI produces correctly formatted messages in a sandbox environment.
