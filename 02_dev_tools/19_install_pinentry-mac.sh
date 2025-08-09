needs_run() {
  ! which pinentry-mac > /dev/null  
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "Installing Pinentry requires homebrew be installed first."
    return 1
  fi
}

run() {
  brew install pinentry-mac
}
