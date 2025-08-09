needs_run() {
  ! brew list --cask | grep -q cursor
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "Cursor requires homebrew be installed first."
    return 1;
  fi
}

run() {
  brew install --cask cursor
  dockutil --add "/Applications/Cursor.app" &
}
