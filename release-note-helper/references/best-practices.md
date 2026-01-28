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
- Component or area (scheduler, controller, API, CLI)
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

## Security

If security fixes exist:
- State severity and affected versions
- Link to security advisory if available
- Recommend upgrade urgency

## Checklist

Before publishing:
- [ ] "What's New" highlights are clear and short
- [ ] Categories match CNCF conventions
- [ ] PR links are included for each item
- [ ] Contributors and new contributors are listed
- [ ] Upgrade-impacting changes are explicit
