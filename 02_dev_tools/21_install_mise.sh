dirname=$(dirname "$0")

needs_run() {
  ! which asdf > /dev/null
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "The Mise Version Manager requires homebrew be installed first."
    return 1;
  fi
}

run() {
  brew install mise
  mise use --global node@latest
  mise use --global ruby@latest
}
