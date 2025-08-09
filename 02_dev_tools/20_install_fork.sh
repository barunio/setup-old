needs_run() {
  ! brew list --cask | grep -q github
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "GitHub Desktop requires homebrew be installed first."
    return 1;
  fi
}

run() {
  brew install --cask fork
  dockutil --add "/Applications/Fork.app" &
}
