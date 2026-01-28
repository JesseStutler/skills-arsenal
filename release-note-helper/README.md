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
│   └── conventional-commits.md # Commit/PR parsing guidance
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

1. **Collect key highlights**
   - Prefer project board, milestone, or release tracking issues
   - Summarize 3 to 6 key features for "What's New"

2. **Define the version range**
   - Ask for the previous version tag if not provided
   - Use `[last_tag]...HEAD` for git history

3. **Gather change data**
   - Pull PR titles and labels
   - Use file paths to infer categories if commit messages are inconsistent

4. **Fill the template**
   - Write "What's New" as short highlights
   - Populate "Other Notable Changes" by category
   - Add links to PRs, issues, docs, and changelog

5. **Finalize**
   - Ensure API changes and dependencies are visible
   - Confirm contributors and new contributors
