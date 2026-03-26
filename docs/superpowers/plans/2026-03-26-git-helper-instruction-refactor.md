# Git-Helper Skill Refactor Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refactor the `git-helper` skill to be instruction-heavy, moving logic from scripts to modular markdown files.

**Architecture:** Split instructions into `spec.md`, `emojis.md`, and `rules.md` within an `instructions/` directory. Simplify `git-helper.sh` to be a thin wrapper around the Git CLI.

**Tech Stack:** Shell (sh), Markdown

---

### Task 1: Initialize Instruction Directory
**Files:**
- Create: `packages/skills/git-helper/instructions/spec.md`

- [ ] **Step 1: Create the directory and spec.md**
```bash
mkdir -p packages/skills/git-helper/instructions
```
- [ ] **Step 2: Write spec.md with Conventional Commits 1.0.0 rules**
```markdown
# Conventional Commits 1.0.0 Specification

Follow this specification for all commit messages:

1. **Structure:** `<type>[optional scope]: <description>`
2. **Types:**
   - `feat`: (NEW feature)
   - `fix`: (Bug fix)
   - `docs`: (Documentation only)
   - `style`: (Formatting, missing semi-colons, etc; no code change)
   - `refactor`: (Refactoring production code)
   - `test`: (Adding missing tests, refactoring tests)
   - `chore`: (Updating build tasks, package manager configs, etc; no production code change)
3. **Breaking Changes:** INDICATE by a `!` after the type/scope (e.g., `feat!: upgrade api version`) or as a footer.
4. **Description:** Use the imperative, present tense: "change" not "changed" nor "changes".
```
- [ ] **Step 3: Commit**
```bash
git add packages/skills/git-helper/instructions/spec.md
git commit -m "docs: add conventional commits spec"
```

### Task 2: Port Emoji Mapping to Instructions
**Files:**
- Create: `packages/skills/git-helper/instructions/emojis.md`

- [ ] **Step 1: Create emojis.md with semantic mappings**
```markdown
# Semantic Commit Emojis

Map the commit type to the corresponding emoji:

- `feat`: ✨
- `fix`: 🐛
- `docs`: 📝
- `refactor`: ♻️
- `style`: 🎨
- `test`: 🔬
- `perf`: ⚡
- `hotfix`: 🚑
- `locale`: 🌐
- `ci`: 👷
- `chore`: 🔧
- `types`: 🏷️

**Usage:** Place the emoji at the very beginning of the commit message followed by a space.
*Example:* `✨ feat: add new authentication flow`
```
- [ ] **Step 2: Commit**
```bash
git add packages/skills/git-helper/instructions/emojis.md
git commit -m "docs: add semantic emoji mapping"
```

### Task 3: Define Atomic Staging Rules
**Files:**
- Create: `packages/skills/git-helper/instructions/rules.md`

- [ ] **Step 1: Create rules.md with agentic guidelines**
```markdown
# Git Decision Rules for Agents

Follow these rules to maintain a clean and auditable project history:

1. **Atomicity:** One logical change per commit. If a file has unrelated changes, use interactive staging (`git-helper stage <file> "s"`) to split them.
2. **Analysis First:** Always run `git-helper status` and `git-helper diff` before staging.
3. **Classification:** Group files by their impact (e.g., all `docs` changes first, then `feat`).
4. **Validation:** Review staged changes with `git-helper diff-staged` before committing.
5. **No Placeholders:** Never commit TODOs or commented-out code unless explicitly part of the task.
```
- [ ] **Step 2: Commit**
```bash
git add packages/skills/git-helper/instructions/rules.md
git commit -m "docs: add atomic staging rules"
```

### Task 4: Simplify Shell Script
**Files:**
- Modify: `packages/skills/git-helper/scripts/git-helper.sh`

- [ ] **Step 1: Remove get_emoji function and update commit command**
Remove lines 9-27 (`get_emoji` function) and simplify the `commit` logic to just accept a final message.
- [ ] **Step 2: Implement the changes in git-helper.sh**
(Replace `get_emoji` usage with direct message argument handling)
- [ ] **Step 3: Commit**
```bash
git add packages/skills/git-helper/scripts/git-helper.sh
git commit -m "refactor: simplify shell script by offloading emoji logic"
```

### Task 5: Update Main Skill Entry Point
**Files:**
- Modify: `packages/skills/git-helper/SKILL.md`

- [ ] **Step 1: Update SKILL.md to reflect new CLI and link to instruction files**
Highlight that the AI must use the instructions in `instructions/` to format the message.
- [ ] **Step 2: Commit**
```bash
git add packages/skills/git-helper/SKILL.md
git commit -m "docs: update skill entry point with modular instruction links"
```

### Task 6: Verify and Fix Tests
**Files:**
- Modify: `packages/skills/git-helper/test/run_tests.sh` (if needed)

- [ ] **Step 1: Run existing tests**
```bash
npm test --prefix packages/skills/git-helper
```
- [ ] **Step 2: Fix any broken tests due to signature changes**
- [ ] **Step 3: Commit**
```bash
git commit -m "test: update tests for new git-helper signature"
```
