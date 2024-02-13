show_mode() {
  local index=$1
  local background="$accent5"
  local color="$dark2"

  # Enable mode indicator
  set-option -g status on

  declare -r prefix_prompt_config='@monokai-pro-mode-prefix'
  declare -r copy_prompt_config='@monokai-pro-mode-copy'
  declare -r sync_prompt_config='@monokai-pro-mode-sync'
  declare -r empty_prompt_config='@monokai-pro-mode-empty'

  local -r \
  prefix_prompt=$(get_tmux_option "$prefix_prompt_config" "WAIT") \
  copy_prompt=$(get_tmux_option "$copy_prompt_config" "COPY") \
  sync_prompt=$(get_tmux_option "$sync_prompt_config" "SYNC") \
  empty_prompt=$(get_tmux_option "$empty_prompt_config" "TMUX")

  # HACK: https://github.com/MunifTanjim/tmux-mode-indicator/blob/master/mode_indicator.tmux#L45
  local mode_prompt="#{?client_prefix,$prefix_prompt,#{?pane_in_mode,$copy_prompt,#{?pane_synchronized,$sync_prompt,$empty_prompt}}}"

  local show_left_separator="#[fg=$background,bg=$dark2,nobold,nounderscore,noitalics]$status_left_separator"
  local show_text="#[fg=$color,bg=$background,bold]$mode_prompt"
  local show_right_separator="#[fg=$background,bg=$dark2,nobold,nounderscore,noitalics]$status_right_separator"

  echo "$show_left_separator$show_text$show_right_separator "
}
