#!/usr/bin/env bash

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_tmux_option() {
  local option value default
  option="$1"
  default="$2"
  value=$(tmux show-option -gqv "$option")

  if [ -n "$value" ]
  then
    if [ "$value" = "null" ]
    then
      echo ""

    else
      echo "$value"
    fi

  else
    echo "$default"

  fi
}

main() {
  local theme
  theme="$(get_tmux_option "@monokai-pro-filter" "pro")"

  # https://github.com/dylanaraps/pure-sh-bible#parsing-a-keyval-file
  # Setting 'IFS' tells 'read' where to split the string.
  while IFS='=' read -r key val; do
    # Skip over lines containing comments.
    # (Lines starting with '#').
    [ "${key##\#*}" ] || continue

    # '$key' stores the key.
    # '$val' stores the value.
      eval "local $key"="$val"
  done < "${PLUGIN_DIR}/palettes/${theme}.tmuxtheme"

  # ==================
  # status
  # ==================
  set status "on"
  set status-bg "${dimmed5}"
  set status-justify "left"
  set status-left-length "100"
  set status-right-length "100"
}

main "$@"
