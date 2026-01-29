# Deep Dive Checklist for Key Features

This checklist ensures comprehensive coverage when documenting key features in release notes.

## Before You Start

- [ ] Identified the key feature from project board or milestone
- [ ] Found related PR numbers and issue numbers
- [ ] Located design doc path (if exists)
- [ ] Located user guide path (if exists)

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
- [ ] Configuration example is verified against code
- [ ] All related links (PRs, issues, docs) are included
- [ ] Contributors are verified from PR authors
- [ ] Technical terms are explained
- [ ] Example is runnable/usable by readers

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
