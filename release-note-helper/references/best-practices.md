# Release Note Best Practices for CNCF Projects

This guidance is tailored for Kubernetes, Karmada, Volcano, and similar CNCF projects.

## Core Principles

### 1. Structure for Scale

Large CNCF releases should follow a two-layer structure:
1. **What's New**: Short, high-impact highlights
2. **Other Notable Changes**: Structured by change type

This mirrors the style used by Karmada and Kubernetes release notes.

### 2. Use CNCF-Style Categories

Recommended categories:
- API Changes
- Features & Enhancements
- Deprecation
- Bug Fixes
- Security
- Dependencies
- Performance
- Other

Keep documentation links within the relevant feature sections instead of a separate "Docs" section.

### 3. Emphasize Upgrade Impact

If a change affects upgrades, call it out explicitly:
- Required configuration changes
- Removed or deprecated APIs
- Version compatibility changes
- Known upgrade caveats

### 4. Use PR Links and SIG Context

Each item should include:
- PR number and link
- Component or area
- Optional SIG or subsystem when it clarifies scope

## Writing Style

### Be Specific and Technical

**Good:**
- "Add `ResourceStrategyFit` plugin for per-resource scoring (#4391, @contributor)"
- "Introduce `MultiplePodTemplatesScheduling` feature gate (#6857, @contributor)"

**Bad:**
- "Improved scheduler"
- "Fixed bugs"

### Keep Highlights Short

Use one or two sentences per highlight in "What's New".

### Link Supporting Docs

If a feature has design docs or usage docs, link them directly in the feature section.

## Attribution

### Credit Contributors

Always include a contributors section and explicitly welcome new contributors.

**CRITICAL**: Verify contributors from PR authors, not git commit authors. Git squash/merge can change the author.

## Security

If security fixes exist:
- State severity and affected versions
- Link to security advisory if available
- Recommend upgrade urgency

## Common Pitfalls and How to Avoid Them

These mistakes were identified through real release note reviews:

### 1. Shallow Feature Descriptions

**Problem**: Initial drafts often have one-line descriptions like "Added feature X."

**Solution**: Each key feature MUST include:
- Background (2-3 paragraphs): Why this feature is needed
- Key capabilities (bullet list): What it provides
- Architecture (if complex): How it works
- Configuration example: How to use it
- Related links: PRs, design docs, user guides

### 2. Incorrect Configuration Formats

**Problem**: Guessing configuration format leads to errors. Example: documenting YAML when the actual config uses CLI flags.

**Solution**: 
1. Search for config definition in code
2. Check flag definitions: `flag.StringVar`, `pflag.StringSliceVar`
3. Check config structs: `type.*Config struct`
4. Verify the actual format before documenting

**Example of the mistake:**
```yaml
# WRONG: Guessed YAML format
feature-config:
  option1: value1
  option2: value2
```

**Correct approach:**
```go
// Found in code:
fs.StringSliceVar(&opts.ConfigsRaw, "feature-config", defaultConfigs,
    "format: name:value1:value2")
```

```bash
# CORRECT: CLI flag format
--feature-config="name:value1:value2"
```

### 3. Incomplete Bug Fix Lists

**Problem**: Using only `git log | grep fix` misses many bug fixes.

**Solution**:
1. Run `git log | grep -iE "fix|bug"` for git history
2. Check project board for "Bug" or "Fix" labeled items
3. Use MCP tools to read issue details
4. Cross-reference both sources

### 4. Wrong Contributor Attribution

**Problem**: Git log author may not be the actual contributor due to squash merges.

**Solution**:
1. Use MCP `pull_request_read` to get PR author
2. Check PR page for the actual author
3. Don't rely solely on `git log --format="%an"`

### 5. Merged Features That Should Be Separate

**Problem**: Combining unrelated features into one section when they serve different purposes.

**Solution**: Use the decision tree:
- Do they serve different purposes? → Separate
- Can they be used independently? → Separate
- Do they have different target users? → Separate
- Do they have separate design docs? → Separate

### 6. Missing API Examples

**Problem**: New CRDs/APIs documented without configuration examples.

**Solution**: For each new CRD/API:
1. Find the type definition in code
2. Document required and optional fields
3. Provide a minimal working example

### 7. Single-Repo Mindset

**Problem**: For multi-repo projects, only checking the main repo and missing API changes.

**Solution**:
1. Identify related repositories (e.g., separate API repos)
2. Check each repo for changes in the version range
3. Document API changes from all relevant repos

### 8. Missing Related Links

**Problem**: Features documented without links to design docs, user guides, or related PRs.

**Solution**: For each key feature, include:
- Issue link (tracking issue)
- PR links (main and follow-up)
- Design doc link (if exists)
- User guide link (if exists)

## Deep Dive Process for Key Features

For each key feature identified from the project board:

1. **Read the Issue**
   - Understand the problem being solved
   - Get context on why it was prioritized

2. **Read the Design Doc**
   - Find in `docs/design/` or `docs/proposals/`
   - Extract background, motivation, architecture
   - Note key concepts and terminology

3. **Read the User Guide**
   - Find in `docs/user-guide/` or `docs/guides/`
   - Get usage examples and best practices

4. **Read the PRs**
   - Use MCP to read PR details
   - Get implementation details
   - Verify contributor information

5. **Read the Code**
   - Find configuration definitions
   - Verify config format (YAML, CLI, env vars)
   - Get default values

## Quality Checklist

Before publishing:
- [ ] "What's New" highlights are clear and short
- [ ] Each key feature has background, motivation, capabilities, config example, and related links
- [ ] Categories match CNCF conventions
- [ ] PR links are included for each item
- [ ] Bug fixes are complete (git log + project board)
- [ ] Contributors verified from PR authors
- [ ] Configuration examples verified from code
- [ ] Upgrade-impacting changes are explicit
- [ ] Features are appropriately grouped/separated
- [ ] All related repos checked for changes (if multi-repo project)
