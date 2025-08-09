#!/bin/zsh

source "$(dirname "$0")/get_sudo.sh"
source "$(dirname "$0")/echo_colors.sh"

timeout() {
  local _timeout=$1; shift 
  local _command=$1

  (eval ${@}) &
  _pid=$!

  local _start_time=$SECONDS
  get_sudo
  while sudo kill -0 -- -$_pid &> /dev/null ; do
    if [ $(($SECONDS - $_start_time)) -ge ${_timeout} ]; then
      echo_danger "$_command timed out."
      get_sudo
      sudo kill -- -$_pid

      local _wait_time=$SECONDS
      get_sudo
      while sudo kill -0 -- -$_pid &> /dev/null; do
        if [ $(($SECONDS - $_wait_time)) -ge 15 ]; then
          get_sudo
          sudo kill -9 -- -$_pid

          echo_danger "Process did not respond to SIGTERM, so was killed forcefully."
          return 1
        fi

        sleep 0.5
        get_sudo
      done

      echo_danger "Killed gracefully."
      return 1
    fi

    sleep 0.5
    get_sudo
  done

  wait $_pid
}
