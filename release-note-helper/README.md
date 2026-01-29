# Release Note Helper - Project Guide

This document explains how to customize release notes for specific projects.

## Overview

Different projects have different release note conventions. This skill supports project-specific templates while providing a generic fallback for new projects.

## Directory Structure

```
release-note-helper/
├── SKILL.md                    # Main skill instructions
├── README.md                   # This file - project guide
├── assets/                     # Release note templates
│   └── generic-template.md     # Default template (CNCF style)
├── references/                 # Supporting documentation
│   ├── best-practices.md       # CNCF release note best practices
│   ├── conventional-commits.md # Commit/PR parsing guidance
│   └── deep-dive-checklist.md  # Checklist for key features
└── scripts/                    # Utility scripts (future)
```

## Using This Skill

### How to Trigger the Skill

Use any of the following prompts:

- "Create release notes for volcano v1.14.0"
- "Draft a release note for kubernetes v1.35.0"
- "Generate changelog for karmada v1.16.0"
- "Write release notes from v1.13.0 to v1.14.0"

To ensure accurate scope, always include the previous version tag (for example, `v1.13.0`).

### For CNCF Projects

1. Use the generic CNCF-style template
2. Ask: "Create release note for volcano v1.14.0"
3. If a project has a release planning board, highlight items from the board first
4. **CRITICAL**: Provide the project board link for accurate key features

### For New CNCF Projects

1. The agent will use the generic template
2. Follow Karmada and Kubernetes structure for clarity and consistency

## Template Structure Guidelines

The generic template is intended to align with CNCF projects:
- Start with "What's New" for highlights
- Follow with "Other Notable Changes" grouped by kind
- Include "API Changes" and "Dependencies" when relevant

## Maintenance

- **Keep templates concise** - focus on structure, not content
- **Update guidance** when CNCF conventions change

## Tips for Maintainers

- Start with the generic template for all CNCF projects
- Include links to milestones, project boards, and PRs
- Keep templates under 200 lines for clarity

## Release Note Workflow Guide

Use this workflow when drafting a release note:

### Phase 1: Information Gathering

1. **Collect key highlights**
   - Prefer project board, milestone, or release tracking issues
   - Summarize 3 to 6 key features for "What's New"

2. **Define the version range**
   - Ask for the previous version tag if not provided
   - Use `[last_tag]...HEAD` for git history

3. **Deep dive into each key feature** (CRITICAL)
   - Read design docs: `docs/design/`, `docs/proposals/`
   - Read user guides: `docs/user-guide/`, `docs/guides/`
   - Read related PRs and issues via MCP tools
   - Read actual code for configuration format

### Phase 2: Data Collection

4. **Gather change data**
   - Pull PR titles and labels
   - Use file paths to infer categories if commit messages are inconsistent
   - Collect bug fixes from BOTH git log AND project board

5. **Verify configuration formats**
   - Find config definitions in code
   - Determine if YAML, CLI flags, env vars, or CRD spec
   - Get default values

6. **Verify contributors**
   - Check PR authors, not just git commit authors
   - Use MCP `pull_request_read` to get accurate info

### Phase 3: Writing

7. **Fill the template**
   - Write "What's New" as short highlights
   - Expand each key feature with:
     - Background and motivation (2-3 paragraphs)
     - Key capabilities (bullet list)
     - Architecture (if complex)
     - Configuration example (verified from code)
     - Related links (PRs, design docs, user guides)
   - Populate "Other Notable Changes" by category

8. **Add links and references**
   - Link to PRs, issues, docs, and changelog
   - Include design doc and user guide links for key features

### Phase 4: Review

9. **Finalize**
   - Ensure API changes and dependencies are visible
   - Confirm contributors from PR authors
   - Verify all configuration examples against actual code
   - Check feature grouping is appropriate

## Common Mistakes to Avoid

See [references/best-practices.md](references/best-practices.md) for detailed guidance on:

1. Shallow feature descriptions
2. Incorrect configuration formats
3. Incomplete bug fix lists
4. Wrong contributor attribution
5. Merged features that should be separate
6. Missing API examples
7. Single-repo mindset for multi-repo projects
8. Missing related links

## Quality Checklist

Before publishing, verify:

- [ ] Each key feature has background, motivation, config example, and related links
- [ ] Configuration examples are verified from actual code
- [ ] Bug fixes are complete (git log + project board)
- [ ] Contributors are verified from PR authors
- [ ] Features are appropriately grouped/separated
- [ ] All related repos are checked for changes
