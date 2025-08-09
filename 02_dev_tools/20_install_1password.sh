source "$(dirname $0)/../util/echo_colors.sh"

needs_run() {
  ! brew list --cask | grep -q 1password
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo_danger "1Password requires homebrew be installed first."
    return 1;
  fi
}

run() {
  brew install --cask 1password
  # dockutil --add "/Applications/1Password 7.app" &
}
