needs_run() {
  ! which dockutil > /dev/null
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "Dockutil requires homebrew be installed first."
    return 1;
  fi
}

run() {
  brew install dockutil
  dockutil --remove all --no-restart
  dockutil --add "/System/Applications/Launchpad.app" --no-restart
  dockutil --add "/System/Applications/Utilities/Terminal.app"
}
