needs_run() {
  ! which expect > /dev/null
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "Expect requires homebrew be installed first."
    return 1;
  fi
}

run() {
  brew install expect
}
