# Generic Release Note Template

This template provides a standard structure for release notes suitable for most projects.

---

# Release [VERSION]

Released: [DATE]

## Summary

[1-2 paragraph overview of this release's focus and key highlights. Answer the question: "Why should I upgrade?" Match the previous release's tone and continue the project's product narrative when appropriate.]

## What's New

[High-level highlights and key features from project planning or milestones]

### Key Features Overview

- **[Key Feature 1]**: [One-line impact summary]
- **[Key Feature 2]**: [One-line impact summary]
- **[Key Feature 3]**: [One-line impact summary]

[Order key features by strategic importance and release narrative, not by merge date. Do not promote every feature PR to this list.]

### Key Feature Details

#### [Key Feature 1]

**Background and Motivation**:

[2-3 paragraphs explaining:
- What problem does this feature solve?
- Why was this solution chosen?
- Who benefits from this feature?]

**Key Capabilities**:

- [Capability 1]: [Brief description]
- [Capability 2]: [Brief description]
- [Capability 3]: [Brief description]

**Configuration**:

[CRITICAL: Verify configuration format from actual code before documenting]

```yaml
# or bash, depending on actual config format
[Accurate configuration example]
```

Related:
- Issues: [#ISSUE_NUMBER](link)
- PRs: [#PR_NUMBER](link)
- Design Doc: [link if available]
- User Guide: [link if available]
- Contributors: [@contributor1], [@contributor2]

#### [Key Feature 2]

**Background and Motivation**:

[2-3 paragraphs explaining the problem and solution]

**Key Capabilities**:

- [Capability 1]
- [Capability 2]

**Configuration**:

```yaml
[Accurate configuration example]
```

Related:
- Issues: [#ISSUE_NUMBER](link)
- PRs: [#PR_NUMBER](link)
- Design Doc: [link if available]
- User Guide: [link if available]
- Contributors: [@contributor]

## Other Notable Changes

### API Changes

[For each new CRD, public API, scheduler/framework extension point, plugin argument, command flag, Helm value, annotation, feature gate, or user-facing behavior change, include a brief configuration example when applicable]

- **[New CRD/API Name]**: [What it is and why it matters]

```yaml
apiVersion: [group]/[version]
kind: [Kind]
metadata:
  name: example
spec:
  [key fields with brief comments]
```

Related: [#PR_NUMBER](link), [@contributor]

### Features & Enhancements

- **[Enhancement Name]**: [Description of improvement] ([#PR_NUMBER](link), [@contributor])
- **[Feature Name]**: [Description of the feature and its benefits] ([#PR_NUMBER](link), [@contributor])

### Bug Fixes

[CRITICAL: Gather from BOTH git log AND project board for completeness]

- **[Issue Description]**: [What was fixed and impact] ([#ISSUE_NUMBER](link), [@contributor])
- **[Issue Description]**: [Fix description] ([#ISSUE_NUMBER](link), [@contributor])

### Dependencies

- [Dependency update and impact] ([#PR_NUMBER](link), [@contributor])

### Performance

- [Performance improvement and measurable impact] ([#PR_NUMBER](link), [@contributor])

### Other

- [Maintenance, CI, refactoring, or minor changes] ([#PR_NUMBER](link), [@contributor])

## Known Issues

[If any known issues exist, list them here with workarounds]

- [Issue description] - Workaround: [solution]

## Upgrade Instructions

[If applicable, provide step-by-step upgrade instructions]

```bash
# Example upgrade commands
helm upgrade [release] [chart] --version [VERSION]
# or
kubectl apply -f [URL]
```

**Note**: [Any important notes about upgrade, e.g., new CRDs to review]

## Contributors

Thank you to all contributors who made this release possible:

[CRITICAL: Verify contributors from PR authors, not just git commit authors]

[@contributor1], [@contributor2], [@contributor3], ...

[If first-time contributors exist]
Special welcome to our new contributors: [@new_contributor1], [@new_contributor2]

## Full Changelog

[Link to full changelog, e.g., https://github.com/org/repo/compare/v1.0.0...v1.1.0]

---

## Usage Notes for This Template

When using this template:

1. **Replace all [PLACEHOLDERS]** with actual content
2. **Keep it concise** - users want quick overview, not exhaustive details
3. **Link liberally** - link to PRs, issues, docs, and commits
4. **User perspective** - write from user's viewpoint, not developer's
5. **Be specific** - "Fixed crash when parsing large files" vs "Fixed bug"
6. **Credit everyone** - include all contributors who made meaningful contributions
7. **Merge documentation into relevant sections** - include docs with the related feature
8. **No emoji** - release notes must not include emoji characters
9. **No extra sections** - do not add sections beyond this template
10. **Verify configurations** - ALWAYS check actual code for config format
11. **Match previous release style** - read the previous release note before drafting
12. **Rank by importance** - Key Features are the release's headline capabilities, not every feature PR
13. **Use Alpha labels sparingly** - only for opt-in, disabled-by-default, upstream-dependent, or evolving-interface capabilities

### Section Guidelines

- **Summary**: High-level overview, answer "why should I upgrade?", and continue the project narrative when appropriate
- **What's New**: Key features highlighted from project planning
  - Each feature needs: background, motivation, capabilities, config example, related links
- **API Changes**: Public or external interface changes WITH config examples, including extension points, plugin args, flags, Helm values, annotations, and feature gates
- **Features & Enhancements**: New capabilities and improvements
- **Bug Fixes**: Corrections to unintended behavior (check BOTH git log AND project board)
- **Dependencies**: Important dependency updates users should know
- **Performance**: Measurable improvements and impact
- **Other**: Maintenance and internal changes
- **Known Issues**: Critical issues users should be aware of
- **Contributors**: Always include, verified from PR authors

### Key Feature Content Requirements

For EACH key feature, you MUST include:

| Section | Required | Source |
|---------|----------|--------|
| Background and Motivation | Yes | Design doc, Issue description |
| Key Capabilities | Yes | Design doc, PR description |
| Architecture/Diagram | If complex | Design doc |
| Configuration Example | Yes | VERIFY FROM CODE |
| Related Issues | Yes | Project board, Issue tracker |
| Related PRs | Yes | Git log, PR references |
| Design Doc Link | If exists | docs/design/ |
| User Guide Link | If exists | docs/user-guide/ |
| Contributors | Yes | PR authors (not git log) |

### Feature Grouping Guidelines

Separate features if:
- They serve different purposes
- They can be used independently
- They have different target users
- They have separate design docs

Group features if:
- They are tightly coupled
- One is a sub-component of another
- They share the same background and motivation

### Stability Label Guidelines

Mark a feature as **Alpha** only when it is new and opt-in, disabled by default, depends on evolving upstream APIs, or has interfaces/behavior expected to change. Do not mark compatibility support, benchmark tooling, bug fixes, or incremental enhancements as Alpha unless project maintainers explicitly classify them that way.
