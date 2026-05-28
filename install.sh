#!/usr/bin/env bash
set -euo pipefail

REPO="${SKILLS_REPO:-JesseStutler/skills-arsenal}"
REF="${SKILLS_REF:-main}"
AGENT=""
SCOPE="global"
DEST=""
SKILLS=()

usage() {
  cat <<'USAGE'
Install skills-arsenal skills without cloning the repository.

Usage:
  ./install.sh --agent <cursor|claude|gemini|codex|all> [options]

Options:
  --skill <name>        Install one skill. Can be repeated. Defaults to all skills.
  --scope <global|project>
                        Install globally or into the current project. Defaults to global.
  --dest <path>         Override the target skills directory.
  --repo <owner/repo>   GitHub repository. Defaults to JesseStutler/skills-arsenal.
  --ref <ref>           Git ref, branch, or tag. Defaults to main.
  -h, --help            Show this help.

Examples:
  ./install.sh --agent claude --skill release-note-helper
  ./install.sh --agent all --scope global
  curl -fsSL https://raw.githubusercontent.com/JesseStutler/skills-arsenal/main/install.sh | bash -s -- --agent gemini
USAGE
}

die() {
  echo "error: $*" >&2
  exit 1
}

need_arg() {
  local option="$1"
  local value="${2:-}"
  [[ -n "$value" ]] || die "$option requires a value"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent)
      need_arg "$1" "${2:-}"
      AGENT="$2"
      shift 2
      ;;
    --skill)
      need_arg "$1" "${2:-}"
      SKILLS+=("$2")
      shift 2
      ;;
    --scope)
      need_arg "$1" "${2:-}"
      SCOPE="$2"
      shift 2
      ;;
    --dest)
      need_arg "$1" "${2:-}"
      DEST="$2"
      shift 2
      ;;
    --repo)
      need_arg "$1" "${2:-}"
      REPO="$2"
      shift 2
      ;;
    --ref)
      need_arg "$1" "${2:-}"
      REF="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "unknown option: $1"
      ;;
  esac
done

[[ -n "$AGENT" ]] || die "--agent is required"
[[ "$SCOPE" == "global" || "$SCOPE" == "project" ]] || die "--scope must be global or project"

command -v tar >/dev/null 2>&1 || die "tar is required"
if command -v curl >/dev/null 2>&1; then
  FETCH=(curl -fsSL)
elif command -v wget >/dev/null 2>&1; then
  FETCH=(wget -qO-)
else
  die "curl or wget is required"
fi

target_for() {
  local agent="$1"

  if [[ -n "$DEST" ]]; then
    printf '%s\n' "$DEST"
    return
  fi

  case "$agent:$SCOPE" in
    cursor:global) printf '%s\n' "$HOME/.cursor/skills" ;;
    cursor:project) printf '%s\n' ".cursor/skills" ;;
    claude:global) printf '%s\n' "$HOME/.claude/skills" ;;
    claude:project) printf '%s\n' ".claude/skills" ;;
    gemini:global) printf '%s\n' "$HOME/.gemini/skills" ;;
    gemini:project) printf '%s\n' ".gemini/skills" ;;
    codex:global) printf '%s\n' "${CODEX_HOME:-$HOME/.codex}/skills" ;;
    codex:project) die "codex project scope is not supported by this installer" ;;
    *) die "unsupported agent: $agent" ;;
  esac
}

tmpdir="$(mktemp -d)"
cleanup() {
  rm -rf "$tmpdir"
}
trap cleanup EXIT

archive_url="https://github.com/${REPO}/archive/refs/heads/${REF}.tar.gz"
if [[ "$REF" == v* || "$REF" == refs/tags/* ]]; then
  ref_name="${REF#refs/tags/}"
  archive_url="https://github.com/${REPO}/archive/refs/tags/${ref_name}.tar.gz"
fi

echo "Downloading ${REPO}@${REF}"
"${FETCH[@]}" "$archive_url" | tar -xz -C "$tmpdir"

src_root="$(find "$tmpdir" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
[[ -n "$src_root" ]] || die "archive did not contain a repository directory"

if [[ ${#SKILLS[@]} -eq 0 ]]; then
  while IFS= read -r skill_dir; do
    SKILLS+=("$(basename "$skill_dir")")
  done < <(find "$src_root" -mindepth 2 -maxdepth 2 -name SKILL.md -type f -exec dirname {} \; | sort)
fi

AGENTS=()
if [[ "$AGENT" == "all" ]]; then
  if [[ "$SCOPE" == "project" ]]; then
    AGENTS=(cursor claude gemini)
  else
    AGENTS=(cursor claude gemini codex)
  fi
else
  AGENTS=("$AGENT")
fi

for agent in "${AGENTS[@]}"; do
  target="$(target_for "$agent")"
  mkdir -p "$target"

  for skill in "${SKILLS[@]}"; do
    src="$src_root/$skill"
    [[ -f "$src/SKILL.md" ]] || die "skill not found or missing SKILL.md: $skill"

    rm -rf "$target/$skill"
    cp -R "$src" "$target/$skill"
    echo "Installed $skill -> $target/$skill"
  done
done
