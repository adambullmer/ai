# Git Helper Staging Guidelines Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enhance `git-helper` with autonomous, non-interactive staging and atomic grouping guidelines.

**Architecture:** Update the `git-helper.sh` script to support piped input for `git add -p` and enhance `SKILL.md` with detailed workflows.

**Tech Stack:** POSIX Shell, Git

---

### Task 1: Update `scripts/git-helper.sh` to support non-interactive staging

**Files:**
- Modify: `packages/skills/git-helper/scripts/git-helper.sh`

- [x] 1. **Step 1: Implement `stage` command with non-interactive support**
- [x] 2. **Step 2: Implement `diff-staged` command**
- [x] 3. **Step 3: Update `commit` command to handle `--yes` correctly**
- [x] 4. **Step 4: Commit script changes**
---
### Task 2: Update `SKILL.md` with detailed guidelines
- [x] 1. **Step 1: Replace "Agentic Guidelines" with "Workflow: Atomic Staging & Grouping"**
- [x] 2. **Step 2: Update "Commands" section**
- [x] 3. **Step 3: Commit documentation changes**
---
### Task 3: Update `README.md`
- [x] 1. **Step 1: Sync README with SKILL.md**
- [x] 2. **Step 2: Commit README changes**
---
### Task 4: Verify with tests
- [x] 1. **Step 1: Add tests for `stage` (untracked and hunks)**
- [x] 2. **Step 2: Update the execution loop in `run_tests.sh`**
- [x] 3. **Step 3: Run all tests and verify**
- [x] 4. **Step 4: Commit test changes**

---

### Task 5: Gemini CLI Integration

**Files:**
- Modify: `packages/skills/git-helper/SKILL.md`
- Create: `packages/skills/git-helper/gemini-extension.json`

- [x] **Step 1: Add YAML frontmatter to `SKILL.md`**
  Ensure the skill has the required metadata for Gemini CLI discovery.

- [x] **Step 2: Create `gemini-extension.json`**
  Define the extension manifest to allow installation and discovery in Gemini CLI.

- [x] **Step 3: Update `package.json` with test script**
  Ensure the package follows standard npm/yarn conventions for testing.
