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

set() {
  local option=$1
  local value=$2
  tmux_commands+=(set-option -gq "$option" "$value" ";")
}

setw() {
  local option=$1
  local value=$2
  tmux_commands+=(set-window-option -gq "$option" "$value" ";")
}

build_window_format() {
  local number=$1
  local color=$2
  local background=$3
  local text=$4

  local number_background=$color

  local show_left_separator="#[fg=$number_background,bg=$dark2,nobold,nounderscore,noitalics]$window_left_separator"
  local show_number="#[fg=$dark2,bg=$number_background,bold]$number"
  local show_middle_separator="#[fg=$number_background,bg=$background,nobold,nounderscore,noitalics]$window_middle_separator"
  local show_text="#[fg=$color,bg=$background] $text "
  local show_right_separator="#[fg=$background,bg=$dark2]$window_right_separator"

  local final_window_format="$show_left_separator$show_number$show_middle_separator$show_text$show_right_separator"

  echo "$final_window_format"
}

build_status_module() {
  local index=$1
  local icon=$2
  local color=$3
  local text=$4

  local background=$dimmed5
  local show_left_separator="#[fg=$color,bg=$dark2,nobold,nounderscore,noitalics]$status_left_separator"
  local show_icon="#[fg=$dark2,bg=$color,nobold,nounderscore,noitalics]$icon "
  local show_text="#[fg=$color,bg=$background] $text"
  local show_right_separator="#[fg=$background,bg=$dark2,nobold,nounderscore,noitalics]$status_right_separator"

  echo "$show_left_separator$show_icon$show_text$show_right_separator"
}

load_modules() {
  local modules_list=$1

  local modules_dir=$PLUGIN_DIR/modules

  local module_index=0;
  local module_name
  local loaded_modules
  local IN=$modules_list

  while [ "$IN" != "$iter" ] ;do
    iter=${IN%% *}
    IN="${IN#$iter }"

    module_name=$iter

    local module_path=$modules_dir/$module_name.sh
    source $module_path

    if [ 0 -eq $? ]
    then
      loaded_modules="$loaded_modules $( show_$module_name $module_index )"
      module_index=$module_index+1
      continue
    fi

  done

  echo "$loaded_modules"
}

main() {
  local theme
  theme="$(get_tmux_option "@monokai-pro-filter" "pro")"

  # Aggregate all commands in one array
  local tmux_commands=()

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
  set status-bg "${dark2}"
  set status-fg "${dimmed1}"
  set status-justify "left"
  set status-left-length "100"
  set status-right-length "100"

  # ==================
  # messages
  # ==================
  set message-style "fg=${text},bg=${dark1},align=centre"
  set message-command-style "fg=${text},bg=${accent1},align=centre"

  # ==================
  # panes
  # ==================
  set pane-border-style "fg=${dimmed4}"
  set pane-active-border-style "fg=${accent2}"

  # ==================
  # windows
  # ==================
  setw window-status-activity-style "fg=${accent3},bg=${dark1},none"
  setw window-status-separator ""
  setw window-status-style "fg=${dimmed1},bg=${dark2},none"

  # ==================
  # Statusline
  # ==================
  ## Left
  local window_left_separator=$(get_tmux_option "@monokai-pro_window_left_separator" "")
  local window_right_separator=$(get_tmux_option "@monokai-pro_window_right_separator" "")
  local window_middle_separator=$(get_tmux_option "@monokai-pro_window_middle_separator" "")

  local window_format=$( load_modules "window_format")
  local window_current_format=$(load_modules "window_current_format")

  setw window-status-format "$window_format"
  setw window-status-current-format "$window_current_format"

  ## Right
  local status_left_separator=$(get_tmux_option "@monokai-pro_status_left_separator" "")
  local status_right_separator=$(get_tmux_option "@monokai-pro_status_right_separator" "")

  local status_modules_right=$(get_tmux_option "@monokai-pro_status_modules_right" "datetime mode")
  local loaded_modules_right=$( load_modules "$status_modules_right")
  set status-right "$loaded_modules_right"

  local status_modules_left=$(get_tmux_option "@monokai-pro_status_modules_left" "logo")
  local loaded_modules_left=$( load_modules "$status_modules_left")
  set status-left "$loaded_modules_left"

  tmux "${tmux_commands[@]}"
}

main "$@"
