show_logo() {
  local logo=" "
  local background="$accent2"
  local color="$dark2"

  local show_left_separator="#[fg=$background,bg=$dark2,nobold,nounderscore,noitalics]$status_left_separator"
  local show_text="#[fg=$color,bg=$background,bold]$logo"
  local show_right_separator="#[fg=$background,bg=$dark2,nobold,nounderscore,noitalics]$status_right_separator"
  echo "$show_left_separator$show_text$show_right_separator"
}
