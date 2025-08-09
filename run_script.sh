#!/bin/zsh
cd "$(dirname "$0")"
source ./util/echo_colors.sh
source ./util/timeout.sh

source "$1"
script_name=$(basename "$1")

if ! dependencies_met; then
  echo_danger "Dependencies not met, skipping."
  exit 1
fi

if ! needs_run; then
  echo_primary "Doesn't need to run."
  exit 0
fi

_perform() (
  set -Ee

  if [[ -v TIMEOUT_SECONDS ]]; then
    timeout $TIMEOUT_SECONDS run < /dev/null
  else
    run < /dev/null
  fi

  echo_primary "Run completed successfully."
)

echo_primary "Running script..."
_perform
if [ "$?" = '0' ]; then; exit 0; fi

echo_warning "Failed, trying again..."
sleep 5
_perform
if [ "$?" = '0' ]; then; exit 0; fi

echo_warning "There was another failure, trying once more..."
sleep 10
_perform
if [ "$?" = '0' ]; then; exit 0; fi

echo_danger "Final retry failed." 
exit 1
