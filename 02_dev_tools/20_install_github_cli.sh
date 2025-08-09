needs_run() {
  ! which gh > /dev/null
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "GitHub CLI requires homebrew be installed first."
    return 1;
  fi
}

run() {
  brew install gh
}
