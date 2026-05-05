#!/bin/sh
input=$(cat)

cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Shorten home directory
cwd="${cwd/#$HOME/~}"

# Build status line
out=""

[ -n "$cwd" ] && out="$cwd"
[ -n "$model" ] && out="$out  $model"
if [ -n "$used" ]; then
  out="$out  ctx:$(printf '%.0f' "$used")%"
fi

printf "%s" "$out"
