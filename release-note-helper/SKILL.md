---
name: release-note-helper
description: Generates comprehensive release notes by analyzing git history and project changes. Use when the user asks to create, draft, or publish release notes, changelogs, or version updates for any project.
---

# Release Note Helper

This skill helps project maintainers generate professional release notes by analyzing git history, project plans, and following project-specific conventions.

## Quick Start

1. **Check for project-specific template**: Look in `assets/` for `{project-name}-template.md`
2. **If no template exists**: Use `assets/generic-template.md` as the base
3. **Identify key features**: Prefer project plans or release boards
4. **Analyze git history**: Gather changes since the last release
5. **Categorize changes**: Group commits by type (features, fixes, etc.)
6. **Draft release note**: Follow the template format

## Workflow

### Step 1: Identify Project Template

Check if a project-specific template exists:
```bash
ls assets/
```

- **If template exists**: Use it as the format guide
- **If no template**: Use `assets/generic-template.md`
- **To add a new template**: See [README.md](README.md)

### Step 2: Identify Key Features (Required)

You MUST prioritize release plans or project boards to define key highlights:
- GitHub Projects (release planning board)
- Milestones or roadmap issues
- Release tracking issues

How to fetch (strict order):
1. If GitHub MCP tools are available AND a project board link is provided, you MUST use MCP to read it.
2. If MCP tools are available BUT no project board link is provided, you MUST ask the user for the project board or milestone link.
3. If MCP tools are not available, you MUST ask the user to provide a short list of key features or a link to the plan.
4. If no plan exists, proceed to infer from git history and clearly state that highlights were inferred from commits/PRs.

### Step 3: Gather Git History

Collect changes since the last release. The previous version tag must be provided by the user.
If the tag is missing, you MUST ask for it and stop.
```bash
# List all commits since last tag
git log --pretty=format:"- %s (%h, @%an)" [last_tag]...HEAD

# Get detailed commit info
git log --stat [last_tag]...HEAD

# List all merged PRs (if using GitHub)
git log --merges --pretty=format:"- %s" [last_tag]...HEAD
```

### Step 4: Categorize Changes

Group commits based on conventional commits or context:

**Features**: New capabilities, enhancements
- Prefix: `feat:`, `feature:`, `add:`
- Examples: New API endpoints, new components, new functionality

**Bug Fixes**: Corrections to existing behavior
- Prefix: `fix:`, `bugfix:`
- Examples: Crash fixes, incorrect behavior corrections

**API Changes**: Changes to APIs, CRDs, or public interfaces
- Prefix: `api:`, `api-change:`, or explicit API change descriptions
- Examples: New fields, changed behavior, new versions

**Maintenance**: Internal improvements
- Prefix: `chore:`, `refactor:`, `ci:`, `test:`
- Examples: Dependency updates, code cleanup, CI improvements

If commit messages are not standardized:
- Use PR titles and labels instead of commit titles
- Group by affected areas (scheduler, queue, job, plugins, API, CLI)
- Use file paths and directories to infer category
- Fold documentation changes into the related feature section

### Step 5: Draft Release Note

Follow the project-specific template format. Key principles:

- **User-centric language**: Focus on impact, not implementation
- **Clear categorization**: Group related changes together
- **Credit contributors**: Acknowledge all contributors
- **Include examples**: Show usage for new features when relevant
- **Link to issues/PRs**: Provide context and traceability

### Step 6: Review and Refine

- Ensure all significant changes are included
- Check that breaking changes are clearly marked
- Verify contributor attributions
- Add upgrade instructions if needed
- Proofread for clarity and accuracy

## Templates

Use the CNCF-style generic template:

- **Generic template**: [assets/generic-template.md](assets/generic-template.md)

Template guidance is in [README.md](README.md).

## Enforcement Notes

- Do not skip Step 2. If you cannot access project planning data, you MUST ask for it.
- Only infer "What's New" from git history when no plan exists, and explicitly label it as inferred.

## Best Practices

**Be Concise**: Users want to quickly understand what changed
**Be Specific**: "Fixed crash on startup" is better than "Fixed bugs"
**Be Honest**: Don't oversell changes or hide risks
**Be Grateful**: Always thank contributors
**Be Helpful**: Add usage tips or pointers for major changes

## Additional Resources (Optional)

- Release note best practices: [references/best-practices.md](references/best-practices.md)
- Conventional commits guide: [references/conventional-commits.md](references/conventional-commits.md)
