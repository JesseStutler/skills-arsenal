# skills-arsenal
The skills-arsenal encompasses several skills for open-source governance, currently is in the experimental stage.

## Usage

Skills can be installed either globally (for all projects) or per-project.

### Cursor Example

**Project Level** Copy the specific skill folder (e.g., `release-note-helper`) into your project's `.cursor/skills/` directory:

```bash
# Example structure
my-project/
  .cursor/
    skills/
      release-note-helper/
        SKILL.md
        ...
```

**Global Level** Copy the specific skill folder into your global cursor skills directory:

```bash
~/.cursor/skills/
```

### Claude Code Example
For Claude Code, please refer to the official documentation for skills configuration: [Claude Code Skills Docs](https://code.claude.com/docs/en/skills)

### Gemini CLI Example
For Gemini CLI, please refer to the official documentation: [Gemini CLI Skills Docs](https://geminicli.com/docs/cli/skills/)

## Structure & Skills

Current available skills in this arsenal:

### 1. release-note-helper

**Description**: Generates comprehensive release notes by analyzing git history, design documents, and project changes. **Use Case**: Use when you need to create, draft, or publish release notes, changelogs, or version updates. It helps analyze git history and categorizes changes professionally.

### 2. skill-creator

**Description**: A meta-skill that serves as a guide for creating new effective skills. **Use Case**: Use when you want to extend the AI's capabilities with specialized knowledge, workflows, or tool integrations. It provides best practices and templates for defining new skills.

> **Note**: This skill is adapted from [Anthropic's skills repository](https://github.com/anthropics/skills/tree/main/skills/skill-creator).
