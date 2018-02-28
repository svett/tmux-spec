#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck disable=1090
SPEC_STATUS_OUTPUT="#($CURRENT_DIR/script/spec-status.sh)"
SPEC_STATUS_INTERPOLATION_STRING="\\#{spec_status}"

# shellcheck disable=1090
source "$CURRENT_DIR/script/shared.sh"

do_interpolation() {
  local string="$1"
  local interpolated="${string/$SPEC_STATUS_INTERPOLATION_STRING/$SPEC_STATUS_OUTPUT}"
  echo "$interpolated"
}

update_tmux_option() {
  local option="$1"
  local option_value
  local new_option_value

  option_value="$(get_tmux_option "$option")"
  new_option_value="$(do_interpolation "$option_value")"

  echo "$new_option_value"
  set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_option "status-right"
  update_tmux_option "status-left"
}

main
