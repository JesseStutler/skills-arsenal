# skills-arsenal
The skills-arsenal encompasses several skills for open-source governance, currently is in the experimental stage.

## Installation

Skills can be installed either globally (for all projects) or per-project. The recommended path is the npm CLI, which copies the selected skill into the agent's local skills directory without requiring users to clone this repository.

### npm / npx

Install all skills globally for one agent:

```bash
npx skills-arsenal install --agent claude
```

Install one skill:

```bash
npx skills-arsenal install --agent cursor --skill release-note-helper
```

Install into the current project instead of the global user directory:

```bash
npx skills-arsenal install --agent gemini --scope project
```

Install globally for Codex:

```bash
npx skills-arsenal install --agent codex
```

Install the CLI globally:

```bash
npm install -g skills-arsenal
skills-arsenal install --agent all
```

List packaged skills:

```bash
npx skills-arsenal list
```

Before the package is published to npm, you can test the same CLI from GitHub:

```bash
npx github:JesseStutler/skills-arsenal install --agent claude
```

Supported agents:

| Agent | Global target | Project target |
| --- | --- | --- |
| Cursor | `~/.cursor/skills/` | `.cursor/skills/` |
| Claude Code | `~/.claude/skills/` | `.claude/skills/` |
| Gemini CLI | `~/.gemini/skills/` | `.gemini/skills/` |
| Codex | `${CODEX_HOME:-~/.codex}/skills/` | Not supported |

> Note: local agents still need local skill files to discover `SKILL.md`; the installer removes the manual clone/copy step, but npm still downloads this package.

### Maintainer: publish to npm

This section is only for the package maintainer. End users do not need to publish anything.

Before end users can run the `npx` commands above, the maintainer must publish this package:

```bash
npm login
npm run check
npm publish --access public
```

If `skills-arsenal` is already taken on npm, rename the package in `package.json` to a scoped package such as `@jessestutler/skills-arsenal`, publish it with `npm publish --access public`, and document this command for users:

```bash
npx @jessestutler/skills-arsenal install --agent claude
```

### curl fallback

Users without npm can install through the shell script:

```bash
curl -fsSL https://raw.githubusercontent.com/JesseStutler/skills-arsenal/main/install.sh | bash -s -- --agent claude
```

### Manual install

#### Cursor Example

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

#### Claude Code Example
For Claude Code, please refer to the official documentation for skills configuration: [Claude Code Skills Docs](https://code.claude.com/docs/en/skills)

#### Gemini CLI Example
For Gemini CLI, please refer to the official documentation: [Gemini CLI Skills Docs](https://geminicli.com/docs/cli/skills/)

## Structure & Skills

Current available skills in this arsenal:

### 1. release-note-helper

**Description**: Generates comprehensive release notes by analyzing git history, design documents, and project changes. **Use Case**: Use when you need to create, draft, or publish release notes, changelogs, or version updates. It helps analyze git history and categorizes changes professionally.

### 2. skill-creator

**Description**: A meta-skill that serves as a guide for creating new effective skills. **Use Case**: Use when you want to extend the AI's capabilities with specialized knowledge, workflows, or tool integrations. It provides best practices and templates for defining new skills.

> **Note**: This skill is adapted from [Anthropic's skills repository](https://github.com/anthropics/skills/tree/main/skills/skill-creator).
