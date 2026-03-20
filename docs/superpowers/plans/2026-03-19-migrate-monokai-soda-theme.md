# Migrate Monokai Soda Theme Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Migrate the existing `monokai-soda` theme into the new AI monorepo structure as a standalone, versioned package.

**Architecture:** The theme will be placed in `packages/themes/monokai-soda/`. It will include a `THEME.md` file with YAML frontmatter for AI discovery, a `package.json` for versioning via Changesets, and the original `monokai-soda.json` file.

**Tech Stack:** Bash, JSON, Markdown, Changesets (for versioning).

---

### Task 1: Initialize Monorepo Workspaces

**Files:**
- Modify: `package.json`

- [ ] **Step 1: Add workspaces to root package.json**

```json
{
  "name": "ai-monorepo",
  "private": true,
  "workspaces": [
    "packages/**/*"
  ]
}
```

- [ ] **Step 2: Commit**

```bash
git add package.json
git commit -m "chore: initialize monorepo workspaces"
```

### Task 2: Create Theme Package Structure

**Files:**
- Create: `packages/themes/monokai-soda/package.json`
- Create: `packages/themes/monokai-soda/README.md`

- [ ] **Step 1: Create package.json for the theme**

```json
{
  "name": "@adambullmer/ai-theme-monokai-soda",
  "version": "1.0.0",
  "description": "Monokai Soda theme for Gemini and other AI agents.",
  "license": "MIT",
  "publishConfig": {
    "access": "public"
  }
}
```

- [ ] **Step 2: Create README.md for the theme**

```markdown
# Monokai Soda Theme

A vibrant, dark theme inspired by Monokai Soda.

## Usage
Reference this theme in your agent configuration or load it via the `THEME.md` entrypoint.
```

- [ ] **Step 3: Commit**

```bash
git add packages/themes/monokai-soda/package.json packages/themes/monokai-soda/README.md
git commit -m "feat(themes): initialize monokai-soda package"
```

### Task 3: Migrate Theme Assets

**Files:**
- Create: `packages/themes/monokai-soda/monokai-soda.json`
- Create: `packages/themes/monokai-soda/THEME.md`

- [ ] **Step 1: Copy monokai-soda.json from source**

Run: `cp ~/github/gemini-theme-monokai-soda/monokai-soda.json packages/themes/monokai-soda/`

- [ ] **Step 2: Create THEME.md with YAML frontmatter**

```markdown
---
name: monokai-soda
version: 1.0.0
type: theme
description: A vibrant, dark theme inspired by Monokai Soda.
file: monokai-soda.json
---

# Monokai Soda Theme

This theme provides a high-contrast, dark color scheme optimized for AI agent interfaces and code presentation.
```

- [ ] **Step 3: Commit**

```bash
git add packages/themes/monokai-soda/monokai-soda.json packages/themes/monokai-soda/THEME.md
git commit -m "feat(themes): migrate monokai-soda assets and add THEME.md"
```

### Task 4: Verify Monorepo Integration

- [ ] **Step 1: Validate package.json names and workspaces**

Run: `npm query .workspace`
Expected: Should list `@adambullmer/ai-theme-monokai-soda` (if npm is used) or equivalent for the chosen package manager.

- [ ] **Step 2: Verify THEME.md exists and is readable**

Run: `ls packages/themes/monokai-soda/THEME.md`
Expected: File exists.

- [ ] **Step 3: Final Commit**

```bash
git commit --allow-empty -m "chore(themes): monokai-soda migration complete"
```
