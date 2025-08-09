needs_run() {
  if [ "$(which git)" = "/usr/local/bin/git" ]; then
    return 1
  fi
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "Updating Git requires homebrew be installed first."
    return 1
  fi
}

run() {
  brew install git
}
