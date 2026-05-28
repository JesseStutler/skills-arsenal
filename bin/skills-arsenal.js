#!/usr/bin/env node

const fs = require("fs");
const os = require("os");
const path = require("path");

const packageRoot = path.resolve(__dirname, "..");
const validAgents = new Set(["cursor", "claude", "gemini", "codex", "all"]);
const validScopes = new Set(["global", "project"]);

function usage() {
  console.log(`Install skills-arsenal skills without cloning the repository.

Usage:
  skills-arsenal install --agent <cursor|claude|gemini|codex|all> [options]
  skills-arsenal list

Options:
  --skill <name>        Install one skill. Can be repeated. Defaults to all skills.
  --scope <global|project>
                        Install globally or into the current project. Defaults to global.
  --dest <path>         Override the target skills directory.
  -h, --help            Show this help.

Examples:
  npx skills-arsenal install --agent claude
  npx skills-arsenal install --agent cursor --skill release-note-helper
  npx skills-arsenal install --agent gemini --scope project
  npm install -g skills-arsenal
  skills-arsenal install --agent all`);
}

function die(message) {
  console.error(`error: ${message}`);
  process.exit(1);
}

function parseArgs(argv) {
  const args = {
    command: argv[0] || "help",
    agent: "",
    scope: "global",
    dest: "",
    skills: []
  };

  for (let i = 1; i < argv.length; i += 1) {
    const arg = argv[i];

    if (arg === "--agent") {
      args.agent = requiredValue(argv, ++i, arg);
    } else if (arg === "--scope") {
      args.scope = requiredValue(argv, ++i, arg);
    } else if (arg === "--dest") {
      args.dest = requiredValue(argv, ++i, arg);
    } else if (arg === "--skill") {
      args.skills.push(requiredValue(argv, ++i, arg));
    } else if (arg === "-h" || arg === "--help") {
      args.command = "help";
    } else {
      die(`unknown option: ${arg}`);
    }
  }

  return args;
}

function requiredValue(argv, index, option) {
  const value = argv[index];
  if (!value || value.startsWith("--")) {
    die(`${option} requires a value`);
  }
  return value;
}

function listSkills() {
  return fs.readdirSync(packageRoot, { withFileTypes: true })
    .filter((entry) => entry.isDirectory())
    .map((entry) => entry.name)
    .filter((name) => fs.existsSync(path.join(packageRoot, name, "SKILL.md")))
    .sort();
}

function expandHome(inputPath) {
  if (inputPath === "~") {
    return os.homedir();
  }
  if (inputPath.startsWith("~/")) {
    return path.join(os.homedir(), inputPath.slice(2));
  }
  return inputPath;
}

function targetFor(agent, scope, dest) {
  if (dest) {
    return path.resolve(expandHome(dest));
  }

  const cwd = process.cwd();
  const home = os.homedir();
  const codexHome = process.env.CODEX_HOME || path.join(home, ".codex");

  if (agent === "cursor" && scope === "global") return path.join(home, ".cursor", "skills");
  if (agent === "cursor" && scope === "project") return path.join(cwd, ".cursor", "skills");
  if (agent === "claude" && scope === "global") return path.join(home, ".claude", "skills");
  if (agent === "claude" && scope === "project") return path.join(cwd, ".claude", "skills");
  if (agent === "gemini" && scope === "global") return path.join(home, ".gemini", "skills");
  if (agent === "gemini" && scope === "project") return path.join(cwd, ".gemini", "skills");
  if (agent === "codex" && scope === "global") return path.join(codexHome, "skills");
  if (agent === "codex" && scope === "project") die("codex project scope is not supported by this installer");

  die(`unsupported agent: ${agent}`);
}

function copySkill(skill, target) {
  const src = path.join(packageRoot, skill);
  const dest = path.join(target, skill);

  if (!fs.existsSync(path.join(src, "SKILL.md"))) {
    die(`skill not found or missing SKILL.md: ${skill}`);
  }

  fs.rmSync(dest, { recursive: true, force: true });
  fs.mkdirSync(target, { recursive: true });
  fs.cpSync(src, dest, { recursive: true });
  console.log(`Installed ${skill} -> ${dest}`);
}

function install(args) {
  if (!args.agent) die("--agent is required");
  if (!validAgents.has(args.agent)) die("--agent must be cursor, claude, gemini, codex, or all");
  if (!validScopes.has(args.scope)) die("--scope must be global or project");

  const skills = args.skills.length > 0 ? args.skills : listSkills();
  if (skills.length === 0) die("no skills found in this package");

  const agents = args.agent === "all"
    ? (args.scope === "project" ? ["cursor", "claude", "gemini"] : ["cursor", "claude", "gemini", "codex"])
    : [args.agent];

  for (const agent of agents) {
    const target = targetFor(agent, args.scope, args.dest);
    for (const skill of skills) {
      copySkill(skill, target);
    }
  }
}

function main() {
  const args = parseArgs(process.argv.slice(2));

  if (args.command === "help") {
    usage();
    return;
  }

  if (args.command === "list") {
    for (const skill of listSkills()) {
      console.log(skill);
    }
    return;
  }

  if (args.command === "install") {
    install(args);
    return;
  }

  die(`unknown command: ${args.command}`);
}

main();
