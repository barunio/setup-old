needs_run() {
  ! which gpg > /dev/null  
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "Installing GPG requires homebrew be installed first."
    return 1
  fi
}

run() {
  brew install gpg
}
