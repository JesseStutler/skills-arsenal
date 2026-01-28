# Commit and PR Parsing Guide for CNCF Projects

This guide focuses on how to extract release note content from real-world CNCF project history, where commit messages are often inconsistent.

## Sources of Truth (preferred order)

1. GitHub project board or milestone items
2. PR titles and labels
3. Commit titles and bodies
4. File paths and component ownership

## Categorization Rules

Use CNCF-style categories:
- API Changes
- Features & Enhancements
- Bug Fixes
- Deprecation
- Security
- Dependencies
- Performance
- Other

## When Commit Messages Are Inconsistent

### Use PR Titles First

PR titles are usually cleaner than commit messages:
```bash
git log --merges --pretty=format:"- %s" v1.0.0...HEAD
```

### Use PR Labels

Common CNCF label patterns:
- `kind/feature`, `kind/bug`, `kind/api-change`
- `sig/scheduling`, `sig/node`, `sig/api-machinery`
- `area/scheduler`, `area/controller`, `area/api`, `area/cli`

### Use File Paths

Infer category from directories:
- `pkg/scheduler` → Features or Bug Fixes (scheduler)
- `pkg/apis` or `apis/` → API Changes
- `docs/` → Link docs in the related feature section
- `charts/` or `helm/` → Dependencies or Installation

## Mapping Examples

### API Changes

- CRD changes, new fields, version bumps
- Admission or validation behavior changes

### Features & Enhancements

- New plugins, new scheduling strategies
- New controllers or operator capabilities

### Bug Fixes

- Fixes in scheduler logic, controllers, or CLI behavior

### Dependencies

- Kubernetes or Go version updates
- Container image or base image bumps

### Performance

- Throughput improvements, latency reductions, scaling changes

## Summary

For CNCF projects, rely on PR metadata and file paths rather than commit prefixes. The goal is a clear release note categorized by impact, not a commit-derived changelog.
