#!/usr/bin/env bash

input=$(cat)

dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Git branch
branch=""
if git -C "$dir" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$dir" symbolic-ref --short HEAD 2>/dev/null || git -C "$dir" rev-parse --short HEAD 2>/dev/null)
fi

# Helper: build a 10-char progress bar string for a given percentage
make_bar() {
  local pct="$1"
  local filled empty bar_inner
  filled=$(printf '%.0f' "$(echo "$pct * 10 / 100" | bc -l)")
  empty=$((10 - filled))
  bar_inner=""
  for i in $(seq 1 "$filled"); do bar_inner="${bar_inner}#"; done
  for i in $(seq 1 "$empty");  do bar_inner="${bar_inner}-"; done
  printf '[%s] %.0f%%' "$bar_inner" "$pct"
}

# Build the status line
parts=()

# directory (shortened home)
short_dir="${dir/#$HOME/~}"
parts+=("${short_dir}")

# git branch
if [ -n "$branch" ]; then
  parts+=("git:${branch}")
fi

# model
if [ -n "$model" ]; then
  parts+=("${model}")
fi

# context window: just the percentage number
if [ -n "$used" ]; then
  parts+=("ctx:$(printf '%.0f' "$used")%")
fi

# Rate limits (Claude.ai subscription only; absent for API users)
five_hour_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
rate_parts=""
if [ -n "$five_hour_pct" ]; then
  rate_parts="5h:$(make_bar "$five_hour_pct")"
fi
if [ -n "$seven_day_pct" ]; then
  seven_day_str="7d:$(make_bar "$seven_day_pct")"
  if [ -n "$rate_parts" ]; then
    rate_parts="$rate_parts $seven_day_str"
  else
    rate_parts="$seven_day_str"
  fi
fi
if [ -n "$rate_parts" ]; then
  parts+=("$rate_parts")
fi

# Join with separator
result=""
for part in "${parts[@]}"; do
  if [ -z "$result" ]; then
    result="$part"
  else
    result="$result | $part"
  fi
done

printf '%s\n' "$result"
