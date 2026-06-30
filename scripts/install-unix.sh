#!/usr/bin/env bash
set -euo pipefail
REPO_URL="${1:-}"
TARGET="$HOME/texmf/tex/latex/school-latex-template"
if [ -z "$REPO_URL" ]; then
  echo "Nutzung: ./scripts/install-unix.sh https://github.com/DEINNAME/school-latex-template.git"
  exit 1
fi
mkdir -p "$(dirname "$TARGET")"
if [ -d "$TARGET/.git" ]; then
  echo "Repo existiert bereits: $TARGET"
else
  git clone "$REPO_URL" "$TARGET"
fi
if command -v mktexlsr >/dev/null 2>&1; then
  mktexlsr "$HOME/texmf" || true
fi
echo "Fertig. Teste mit: \\documentclass{schoolworksheet}"
