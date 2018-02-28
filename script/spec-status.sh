#!/bin/bash

CURRENT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
PANE_DIR="$(tmux display-message -p -F "#{pane_current_path}")"

# shellcheck disable=1090
source "$CURRENT_DIR/shared.sh"

print_status() {
  color_fail=$(get_tmux_option "@spec_status_color_fail" "#[bg=red] #[fg=black]")
  color_pass=$(get_tmux_option "@spec_status_color_pass" "#[bg=green] #[fg=black]")
  color_none=$(get_tmux_option "@spec_status_color_none" "#[bg=colour8] #[fg=gray]")

  status_color=$color_none
  status_message="N/A"

  if [ -f "$PANE_DIR/.Guardfile" ]; then # [1]
    exit_code=1

    if [ "$exit_code" -eq 0 ]; then
      status_color=${color_pass}
      status_message="PASSING"
    else
      status_color=${color_fail}
      status_message="FAILING"
    fi
  fi

  printf "Spec: %s %s " "${status_color}" "${status_message}"
}

main() {
  print_status
}

main
