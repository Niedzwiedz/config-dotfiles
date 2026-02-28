#!/usr/bin/env bash
set -euo pipefail

KEEP=2

clean() {
  local pattern="$1"
  local backups
  # sort descending (newest first via reverse sort on timestamp in name)
  mapfile -t backups < <(ls -d $pattern 2>/dev/null | sort -r)

  local total=${#backups[@]}
  if [ "$total" -le "$KEEP" ]; then
    return
  fi

  for (( i=KEEP; i<total; i++ )); do
    rm -rf "${backups[$i]}"
    echo "Deleted ${backups[$i]}"
  done
}

clean "$HOME/.config/nvim.*.bak"
clean "$HOME/.config/ghostty.*.bak"
clean "$HOME/.tmux.conf.*.bak"
clean "$HOME/.claude/skills.*.bak"

echo "Done. Kept last $KEEP backups per config."
