source "$(dirname $0)/../util/get_sudo.sh"

export TIMEOUT_SECONDS=900

needs_run() {
  test -z ${commands[brew]}
}

dependencies_met() {
  return 0
}

run() {
  # CI=true runs the script without prompts
  SUDO_ASKPASS="$PWD/util/get_sudo_askpass.sh" \
  CI=true \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}
