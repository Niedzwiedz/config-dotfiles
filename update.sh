#!/usr/bin/env bash
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"

rsync -a --exclude='.git' ~/.config/nvim/ "$REPO/nvim/"
echo "Updated nvim"

cp ~/.tmux.conf "$REPO/tmux/.tmux.conf"
echo "Updated tmux"

rsync -a ~/.config/ghostty/ "$REPO/ghostty/"
echo "Updated ghostty"

rsync -a --exclude='omarchy' ~/.claude/skills/ "$REPO/skills/"
echo "Updated skills"

echo "Done. Run 'git diff' to review changes."
