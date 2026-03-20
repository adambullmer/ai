# Implementation Plan: Git Helper

## Phase 1: Scaffolding [checkpoint: dd2aaa7]
- [x] Task: Create package directory `packages/skills/git-helper/`
- [x] Task: Create `package.json` for versioning and metadata
- [x] Task: Update `SKILL.md` with conventional commit and agentic guidelines
- [x] Task: Conductor - User Manual Verification 'Scaffolding' (Protocol in workflow.md)

## Phase 2: Logic Implementation [checkpoint: 807a288]
- [x] Task: Write `scripts/git-helper.sh` [5247d67]
    - [x] Implement `status` command
    - [x] Implement `diff` command
    - [x] Implement `commit` command with confirmation and conventional commit support
- [x] Task: Ensure script is POSIX-compliant
- [x] Task: Run `shellcheck` and resolve any warnings
- [x] Task: Conductor - User Manual Verification 'Logic Implementation' (Protocol in workflow.md)

## Phase 3: Documentation & Verification
- [x] Task: Create `README.md` with usage instructions, agentic guidelines, and security warnings [d6031d8]
- [x] Task: Verify skill functionality in a local test environment
- [ ] Task: Conductor - User Manual Verification 'Documentation & Verification' (Protocol in workflow.md)
