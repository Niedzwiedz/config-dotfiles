#!/usr/bin/env bash
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
TS=$(date +%Y%m%d_%H%M%S)

backup_dir() {
  local dest="$1"
  [ -d "$dest" ] && cp -r "$dest" "${dest}.${TS}.bak" && echo "Backed up $dest"
}

backup_file() {
  local dest="$1"
  [ -f "$dest" ] && cp "$dest" "${dest}.${TS}.bak" && echo "Backed up $dest"
}

# nvim
backup_dir ~/.config/nvim
mkdir -p ~/.config/nvim
cp -r "$REPO/nvim/." ~/.config/nvim/

# tmux
backup_file ~/.tmux.conf
cp "$REPO/tmux/.tmux.conf" ~/.tmux.conf

# ghostty
backup_dir ~/.config/ghostty
mkdir -p ~/.config/ghostty
cp -r "$REPO/ghostty/." ~/.config/ghostty/

# claude skills
backup_dir ~/.claude/skills
mkdir -p ~/.claude/skills
cp -r "$REPO/skills/." ~/.claude/skills/

echo "Done. Backups tagged: $TS"
