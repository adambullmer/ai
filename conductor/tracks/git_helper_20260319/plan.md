# Implementation Plan: Git Helper

## Phase 1: Scaffolding
- [ ] Task: Create package directory `packages/skills/git-helper/`
- [ ] Task: Create `package.json` for versioning and metadata
- [ ] Task: Create `SKILL.md` as the extension entrypoint
- [ ] Task: Conductor - User Manual Verification 'Scaffolding' (Protocol in workflow.md)

## Phase 2: Logic Implementation
- [ ] Task: Write `scripts/git-helper.sh`
    - [ ] Implement `status` command
    - [ ] Implement `diff` command
    - [ ] Implement `commit` command with confirmation logic
- [ ] Task: Ensure script is POSIX-compliant
- [ ] Task: Run `shellcheck` and resolve any warnings
- [ ] Task: Conductor - User Manual Verification 'Logic Implementation' (Protocol in workflow.md)

## Phase 3: Documentation & Verification
- [ ] Task: Create `README.md` with usage instructions and security warnings
- [ ] Task: Verify skill functionality in a local test environment
- [ ] Task: Conductor - User Manual Verification 'Documentation & Verification' (Protocol in workflow.md)
