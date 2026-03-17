#!/usr/bin/env bash

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Mirror the _prompt_path logic: trim ~/dev/ prefix
home="$HOME"
dev_prefix="$home/dev/"
if [[ "$cwd" == "$dev_prefix"* ]]; then
  display_path="${cwd#$dev_prefix}"
else
  display_path="${cwd/$home/\~}"
fi

# Git status
git_part=""
if git_dir=$(git -C "$cwd" rev-parse --git-dir 2>/dev/null); then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)

  # Dirty state (index + worktree, skip optional locks)
  if git -C "$cwd" diff --no-lock-index --quiet 2>/dev/null && git -C "$cwd" diff --no-lock-index --cached --quiet 2>/dev/null; then
    dirty=""
  else
    dirty="*"
  fi

  # Untracked files
  if [[ -n $(git -C "$cwd" ls-files --others --exclude-standard 2>/dev/null) ]]; then
    dirty="${dirty}?"
  fi

  # Ahead/behind upstream
  upstream=$(git -C "$cwd" rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)
  ahead_behind=""
  if [[ -n "$upstream" ]]; then
    ahead=$(git -C "$cwd" rev-list --count "${upstream}..HEAD" 2>/dev/null)
    behind=$(git -C "$cwd" rev-list --count "HEAD..${upstream}" 2>/dev/null)
    [[ "$ahead" -gt 0 ]] && ahead_behind="+${ahead}"
    [[ "$behind" -gt 0 ]] && ahead_behind="${ahead_behind}-${behind}"
  fi

  git_part=" ${branch}${dirty}${ahead_behind}"
fi

# Context usage indicator
ctx_part=""
if [[ -n "$used_pct" ]]; then
  used_int=${used_pct%.*}
  if [[ "$used_int" -ge 75 ]]; then
    ctx_part=" ctx:${used_int}%"
  fi
fi

# Build the line using printf to handle ANSI colors
printf "\033[2m%s\033[0m" "${display_path}${git_part}${ctx_part}"
[[ -n "$model" ]] && printf "\033[2m  %s\033[0m" "$model"
printf "\n"
