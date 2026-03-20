# Implementation Plan: Git Helper Staging Guidelines

## Phase 1: Logic Implementation
- [x] Task: Update `scripts/git-helper.sh`
    - [x] Add `stage` command with hunk support
    - [x] Add `diff-staged` command
    - [x] Ensure `commit` command supports `--yes` and `-y`
- [x] Task: Run `shellcheck` and resolve any warnings
- [x] Task: Update tests in `packages/skills/git-helper/test/run_tests.sh`
- [x] Task: Conductor - User Manual Verification 'Logic Implementation' (Protocol in workflow.md)

## Phase 2: Documentation & Guidelines [checkpoint: 06af5c6]
- [x] Task: Update `packages/skills/git-helper/SKILL.md` with "Workflow: Atomic Staging & Grouping"
- [x] Task: Update `packages/skills/git-helper/README.md` with the new workflow
- [x] Task: Conductor - User Manual Verification 'Documentation & Guidelines' (Protocol in workflow.md)
