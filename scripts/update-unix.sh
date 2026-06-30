#!/usr/bin/env bash
set -euo pipefail
cd "$HOME/texmf/tex/latex/school-latex-template"
git pull
if command -v mktexlsr >/dev/null 2>&1; then
  mktexlsr "$HOME/texmf" || true
fi
