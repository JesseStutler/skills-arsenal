---
name: release-note-helper
description: Generates comprehensive release notes by analyzing git history, design documents, and project changes. Use when the user asks to create, draft, or publish release notes, changelogs, or version updates for any project.
---

# Release Note Helper

This skill helps project maintainers generate professional release notes by analyzing git history, design documents, user guides, and project-specific conventions.

## Quick Start

1. **Check for project-specific template**: Look in `assets/` for `{project-name}-template.md`
2. **If no template exists**: Use `assets/generic-template.md` as the base
3. **Identify key features**: MUST read project plans, design docs, and user guides
4. **Analyze git history**: Gather changes since the last release
5. **Deep dive into features**: Read related code, PRs, and issues for accurate details
6. **Categorize changes**: Group commits by type (features, fixes, etc.)
7. **Draft release note**: Follow the template format with rich content

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

**CRITICAL**: Project boards provide the WHAT, but you still need to gather the WHY and HOW from other sources (see Step 2.1).

### Step 2.1: Deep Dive into Key Features (CRITICAL)

For EACH key feature identified from the project board, you MUST gather detailed information:

1. **Read Design Documents**
   - Search for design docs: `docs/design/`, `docs/proposals/`, `design/`
   - Read the design doc to understand background, motivation, and architecture
   - Extract key concepts, architecture diagrams, and design decisions

2. **Read User Guides**
   - Search for user guides: `docs/user-guide/`, `docs/guides/`
   - Extract usage examples, configuration options, and best practices

3. **Read Related PRs and Issues**
   - Use MCP tools to read issue/PR details: `issue_read`, `pull_request_read`
   - Understand the problem being solved and the implementation approach
   - Get accurate contributor information from PR authors, not git log

4. **Read Actual Code for Configuration**
   - NEVER guess configuration formats
   - Find the actual config struct/type in the codebase
   - Verify whether config is YAML, command-line flags, environment variables, etc.

5. **Read Related API Changes (for multi-repo projects)**
   - Check if the project has separate API repositories
   - Review API repo changes in the same version range

**Information to gather for each key feature:**
- Background: Why was this feature needed?
- Motivation: What problem does it solve?
- Architecture: How is it designed? (include diagrams if available)
- Key concepts: What new concepts are introduced?
- Configuration: How to configure it? (with accurate examples)
- Related links: PRs, issues, design docs, user guides

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

# List bug fix commits (use multiple patterns)
git log --pretty=format:"- %s ([#%h](link), @%an)" [last_tag]...HEAD | grep -iE "^- fix|bug"
```

**CRITICAL for Bug Fixes:**
- Git log alone is NOT sufficient for bug fixes
- MUST also check project board's "Bug" or "Fix" items
- Cross-reference both sources for completeness
- Include issue links, not just commit hashes

### Step 4: Categorize Changes

Group commits based on conventional commits or context:

**Features**: New capabilities, enhancements
- Prefix: `feat:`, `feature:`, `add:`
- Examples: New API endpoints, new components, new functionality

**Bug Fixes**: Corrections to existing behavior
- Prefix: `fix:`, `bugfix:`
- Examples: Crash fixes, incorrect behavior corrections
- **MUST be comprehensive** - check git log AND project board

**API Changes**: Changes to APIs, CRDs, or public interfaces
- Prefix: `api:`, `api-change:`, or explicit API change descriptions
- Examples: New fields, changed behavior, new versions
- **Include configuration examples** for new CRDs/APIs

**Maintenance**: Internal improvements
- Prefix: `chore:`, `refactor:`, `ci:`, `test:`
- Examples: Dependency updates, code cleanup, CI improvements

If commit messages are not standardized:
- Use PR titles and labels instead of commit titles
- Group by affected component or module
- Use file paths and directories to infer category
- Fold documentation changes into the related feature section

### Step 5: Feature Grouping Guidelines (CRITICAL)

**When to separate features:**
- Features serve different purposes
- Features can be used independently
- Features have different target users or use cases
- Features have their own design docs

**When to group features:**
- Features are tightly coupled and always used together
- One feature is a sub-component of another
- Features share the same background and motivation

### Step 6: Draft Release Note

Follow the project-specific template format. Key principles:

- **User-centric language**: Focus on impact, not implementation
- **Clear categorization**: Group related changes together
- **Credit contributors**: Acknowledge all contributors (verify from PRs, not just git log)
- **Include examples**: Show ACCURATE usage for new features
- **Link to issues/PRs**: Provide context and traceability
- **English only**: Release notes MUST be written in English
- **No emoji**: Release notes MUST NOT include emoji characters
- **No extra sections**: Do not add sections that are not present in the chosen template

**What's New Structure (CRITICAL):**
Each key feature MUST include:
1. **Background and Motivation**: Why this feature is needed (2-3 paragraphs)
2. **Key Capabilities**: What the feature provides (bullet list)
3. **Architecture/Key Concepts**: How it works (diagram if available)
4. **Configuration Example**: ACCURATE configuration (verify from code)
5. **Related Links**: PRs, design docs, user guides, contributors

### Step 7: Review and Refine

- Ensure all significant changes are included
- Check that breaking changes are clearly marked
- Verify contributor attributions (check PR authors, not just git log)
- Add upgrade instructions if needed
- Proofread for clarity and accuracy
- **Verify configuration examples against actual code**

## Templates

Use the CNCF-style generic template:

- **Generic template**: [assets/generic-template.md](assets/generic-template.md)

Template guidance is in [README.md](README.md).

## Enforcement Notes

- Do not skip Step 2. If you cannot access project planning data, you MUST ask for it.
- Do not skip Step 2.1. You MUST read design docs and user guides for key features.
- Only infer "What's New" from git history when no plan exists, and explicitly label it as inferred.
- If no release note exists, you MUST generate one following the chosen template.
- Release notes MUST be written in English.
- Release notes MUST NOT include emoji.
- The output MUST strictly follow the template structure; do not introduce extra sections.
- Configuration examples MUST be verified against actual code.
- Bug fixes MUST be gathered from both git log AND project board.
- Contributors MUST be verified from PR authors, not just git commit authors.

## Best Practices

| Practice | Description |
|----------|-------------|
| Be Concise | Users want to quickly understand what changed |
| Be Specific | "Fixed crash on startup" is better than "Fixed bugs" |
| Be Accurate | Verify all technical details before including them |
| Be Thorough | Check multiple sources for bug fixes and contributors |
| Be Helpful | Add usage tips or pointers for major changes |

**Key Quality Checks:**
- [ ] Each key feature has background, motivation, config example, and related links
- [ ] Configuration examples are verified from actual code (not guessed)
- [ ] Bug fixes are gathered from both git log AND project board
- [ ] Contributors are verified from PR authors
- [ ] Features are appropriately grouped or separated

For detailed best practices and common pitfalls with examples, see [references/best-practices.md](references/best-practices.md).

## References

These references provide detailed guidance and checklists:

- **Best Practices**: [references/best-practices.md](references/best-practices.md) - Detailed guidance on writing quality release notes, including common pitfalls with examples
- **Deep Dive Checklist**: [references/deep-dive-checklist.md](references/deep-dive-checklist.md) - Step-by-step checklist for gathering feature information
- **Conventional Commits**: [references/conventional-commits.md](references/conventional-commits.md) - Guide for parsing commit messages
