needs_run() {
  ! which realpath > /dev/null
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "CoreUtils requires homebrew be installed first."
    return 1;
  fi
}

run() {
  brew install coreutils
}
