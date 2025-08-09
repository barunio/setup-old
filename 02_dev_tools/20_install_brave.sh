source ./util/get_sudo.sh
dirname=$(dirname "$0")

needs_run() {
  ! brew list --cask | grep -q brave
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "Brave requires homebrew be installed first."
    return 1;
  fi
}

run() {
  brew install --cask brave
  dockutil --add "/Applications/Brave Browser.app" &
}
