# Deep Dive Checklist for Key Features

This checklist ensures comprehensive coverage when documenting key features in release notes.

## Before You Start

- [ ] Read the previous stable release note and identified its structure, tone, and product narrative
- [ ] Identified the key feature from project board or milestone
- [ ] If the project board was inaccessible, recorded the fallback sources used
- [ ] Found related PR numbers and issue numbers
- [ ] Located design doc path (if exists)
- [ ] Located user guide path (if exists)
- [ ] Ranked features into Key Features, Features and Enhancements, Bug Fixes, and Other

## Release Story Checklist

- [ ] **What is the release narrative?**
  - Write a 1-2 sentence internal story before drafting
  - Connect the release to the project's larger positioning
  - Avoid reducing the Summary to a list of PRs

- [ ] **What is the most important feature?**
  - Identify the highest-impact capability
  - Explain why it matters to users/operators
  - Put it first in Key Features unless the user provides a different order

- [ ] **Which features are not Key Features?**
  - Move incremental enhancements, compatibility updates, and small plugin changes to lower sections
  - Group small related changes instead of giving each a headline

- [ ] **What is the differentiating value?**
  - State what this project does better or differently than common alternatives
  - Avoid describing only implementation mechanics

## Information Gathering Checklist

### 1. Background and Motivation

- [ ] **What problem does this feature solve?**
  - Read the issue description
  - Read the design doc's "Motivation" section
  - Understand the pain point for users

- [ ] **Why was this solution chosen?**
  - Read design doc's "Design" section
  - Understand trade-offs considered

- [ ] **Who benefits from this feature?**
  - Identify target users

### 2. Technical Details

- [ ] **Architecture**
  - Read design doc for architecture diagrams
  - Identify key components and their interactions
  - Note any new CRDs, controllers, or plugins

- [ ] **Key Concepts**
  - List new terms introduced by this feature
  - Provide brief definitions for each term

- [ ] **Implementation**
  - Identify main code paths changed
  - Note any new packages or modules

### 3. Configuration (CRITICAL)

**NEVER guess configuration format. Always verify from code.**

- [ ] **Identify configuration type**
  - [ ] YAML/JSON config file
  - [ ] Command-line flags
  - [ ] Environment variables
  - [ ] CRD spec fields
  - [ ] ConfigMap

- [ ] **Find configuration definition in code**
  - Search for config struct: `type.*Config`
  - Search for flag definitions: `flag.`, `pflag.`
  - Search for env vars: `os.Getenv`

- [ ] **Document configuration options**
  - List all configurable fields
  - Document default values
  - Provide example with correct format

### 3.5 API and User-Facing Change Sweep

Check external interfaces even when PR descriptions do not call them out:

- [ ] CRDs, API structs, generated clients, and version changes
- [ ] Scheduler framework extension points and plugin interfaces
- [ ] Plugin arguments and configuration schema changes
- [ ] Command-line flags and environment variables
- [ ] Helm values and deployment manifests
- [ ] Annotations, labels, feature gates, and resource key conventions
- [ ] Behavior changes that affect users, operators, autoscalers, quota accounting, or integrations

Document these in API Changes, Upgrade Instructions, or the relevant feature section.

### 3.6 Stability Labeling

- [ ] **Alpha label justified**
  - New opt-in capability
  - Disabled by default
  - Depends on evolving upstream APIs
  - Interface or behavior may change

- [ ] **No Alpha label needed**
  - Compatibility support
  - Benchmark or observability tooling
  - Bug fix or stability enhancement
  - Incremental improvement to an existing stable capability

If alpha features exist, add a release note explaining that only explicitly marked features are alpha-stage.

### 4. Related Resources

- [ ] **Design Doc**
  - Path: `docs/design/*.md` or `docs/proposals/*.md`
  - Link format: `[Design Doc](docs/design/feature-name.md)`

- [ ] **User Guide**
  - Path: `docs/user-guide/*.md` or `docs/guides/*.md`
  - Link format: `[User Guide](docs/user-guide/how_to_use_feature.md)`

- [ ] **PRs**
  - Use MCP `pull_request_read` to get PR details
  - Note: Main PR for feature, follow-up PRs

- [ ] **Issues**
  - Use MCP `issue_read` to get issue details
  - Tracking issue, related bug fixes

### 5. Contributors

**IMPORTANT: Verify contributors from PR authors, not git log.**

- [ ] **Primary Contributors**
  - Who authored the main PR?
  - Who reviewed and approved?

- [ ] **Secondary Contributors**
  - Who contributed follow-up PRs?
  - Who reported the issue?

## Configuration Format Examples

### Command-Line Flags

```go
// Code pattern to look for
fs.StringSliceVar(&opts.Configs, "config-name", defaultValue, "description")
```

Document as:
```bash
--config-name="value1,value2"
```

### YAML Config

```go
// Code pattern to look for
type FeatureConfig struct {
    Enable  bool   `yaml:"enable"`
    Setting string `yaml:"setting"`
}
```

Document as:
```yaml
featureConfig:
  enable: true
  setting: "value"
```

### CRD Spec

```go
// Code pattern to look for
type FeatureSpec struct {
    Field1 string `json:"field1"`
    Field2 int    `json:"field2,omitempty"`
}
```

Document as:
```yaml
apiVersion: example.io/v1
kind: Feature
metadata:
  name: example
spec:
  field1: "value"
  field2: 10
```

## Quality Checklist

Before finalizing the feature documentation:

- [ ] Background explains WHY, not just WHAT
- [ ] Summary follows the release story and previous release style
- [ ] Key Features are ordered by importance, not merge date
- [ ] Configuration example is verified against code
- [ ] All related links (PRs, issues, docs) are included
- [ ] Contributors are verified from PR authors
- [ ] Technical terms are explained
- [ ] Example is runnable/usable by readers
- [ ] Every PR in the release range is covered, grouped, or intentionally excluded
- [ ] API Changes include extension points, flags, Helm values, annotations, plugin args, and feature gates where applicable

## Common Mistakes

### Mistake 1: Guessing Configuration Format

**Bad:**
```yaml
# Guessed YAML format without checking code
feature-configs:
- name: config-1
  type: some-type
```

**Good:** First check the code:
```go
// Found in code: flag-based config
fs.StringSliceVar(&opts.ConfigsRaw, "feature-configs", defaultConfigs,
    "format: name:type:value1:value2")
```

Then document correctly:
```bash
--feature-configs="config-1:some-type:value1:value2"
```

### Mistake 2: Shallow Feature Description

**Bad:**
> Added Feature X for better performance.

**Good:**
> **Background**: [Describe the problem users were facing]
>
> **Key Capabilities**:
> - [Capability 1]: [What it provides]
> - [Capability 2]: [What it provides]

### Mistake 3: Wrong Contributor Attribution

**Bad:** Using git commit author
```bash
git log --format="%an" | sort -u
# Returns: Some Name (may be commit squasher, not original author)
```

**Good:** Check PR author via MCP
```
PR #1234 authored by @actual-author
PR #1235 authored by @another-author
```

### Mistake 4: Incomplete Bug Fix List

**Bad:** Only using git log
```bash
git log | grep -i "fix"  # Gets 15 fixes
```

**Good:** Cross-reference with project board
- Git log: 15 fixes
- Project board "Bug" column: 8 additional fixes
- Total: 23 fixes

### Mistake 5: Promoting Every Feature PR to Key Feature

**Bad:**
> Every PR labeled `kind/feature` gets a Key Feature section.

**Good:**
> Rank by user impact and release narrative. Major new capabilities go to Key Features; incremental plugin updates, compatibility support, and small improvements go to Features and Enhancements or Other.

### Mistake 6: Missing API Changes Because PRs Did Not Mention Them

**Bad:**
> API Changes only lists CRDs that PR authors explicitly called out.

**Good:**
> Scan code and manifests for extension point signatures, plugin arguments, Helm values, flags, annotations, resource keys, and behavior changes. Include user-facing changes even if the PR description omitted them.

### Mistake 7: Overusing Alpha Labels

**Bad:**
> Mark all new features as Alpha to be safe.

**Good:**
> Mark only opt-in, disabled-by-default, upstream-dependent, or evolving-interface features as Alpha. Do not label benchmark tooling, compatibility support, stability fixes, or incremental enhancements as Alpha without project evidence.

## Feature Grouping Decision Tree

```
Is Feature A dependent on Feature B?
├─ Yes → Consider grouping
│   └─ But: Do they serve the same purpose?
│       ├─ Yes → Group them
│       └─ No → Separate them
└─ No → Are they solving the same problem?
    ├─ Yes → Consider grouping
    │   └─ But: Can they be used independently?
    │       ├─ Yes → Separate them
    │       └─ No → Group them
    └─ No → Separate them
```

**Key questions to ask:**
- Do they serve different purposes? → Separate
- Can they be used independently? → Separate  
- Do they have different target users? → Separate
- Do they have separate design docs? → Separate
