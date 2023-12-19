show_window_current_format() {
  local number="#I"
  local color="$accent4"
  local background="$dimmed5"
  local text="$(get_tmux_option "@monokai-pro_window_default_text" "#W")" # use #W for application instead of directory
  
  local default_window_format=$( build_window_format "$number" "$color" "$background" "$text" "$fill" )

  echo "$default_window_format"
}
