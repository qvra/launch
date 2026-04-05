#!/usr/bin/env bash
set -euo pipefail

if [ "${1:-}" = "" ] || [ "${2:-}" = "" ]; then
  echo "usage: bash bootstrap.sh <target-dir> <repo-name>" >&2
  exit 1
fi

target_dir="$1"
repo_name="$2"

mkdir -p "$target_dir"/{src,tests,docs,scripts}

cat > "$target_dir/README.md" <<EOT
# ${repo_name}

One-line role statement for ${repo_name}.

## What belongs here

- concrete work with a clear repo role
- files that strengthen entry, use, reuse, comparison, or proof

## What does not belong here

- junk drawers
- dead structure
- explanation before result
- random unrelated artifacts

## Current role

State what this repository does in one sharp sentence.

## Next routes

- link the nearest related repos or surfaces here

## Status

Active repository surface.
EOT

cat > "$target_dir/.gitignore" <<'EOT'
.DS_Store
dist/
build/
coverage/
node_modules/
.venv/
venv/
__pycache__/
*.pyc
*.pyo
*.pyd
EOT

cat > "$target_dir/scripts/verify-layout.sh" <<'EOT'
#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

test -f README.md
test -f .gitignore
test -d src
test -d tests
test -d docs
echo "layout:ok"
EOT

chmod +x "$target_dir/scripts/verify-layout.sh"

printf "created:%s\n" "$target_dir"
printf "repo:%s\n" "$repo_name"
printf "verify:%s\n" "$target_dir/scripts/verify-layout.sh"
