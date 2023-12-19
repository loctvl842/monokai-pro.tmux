show_window_format() {
  local number="#I"
  local color="$dimmed2"
  local background="$dark1"
  local text="$(get_tmux_option "@monokai-pro_window_default_text" "#W")"
  
  local default_window_format=$( build_window_format "$number" "$color" "$background" "$text")

  echo "$default_window_format"
}
