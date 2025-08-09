source "$(dirname $0)/../util/get_sudo.sh"

needs_run() {
  return 0
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo_danger "Configuring homebrew requires homebrew be installed first."
    return 1;
  fi
}

run() {
  # Tap cask so cask is ready to go
  brew tap homebrew/cask

  # Use bundle to do _something_ so bundle installs
  brew bundle --help > /dev/null

  # https://docs.brew.sh/FAQ#my-mac-apps-dont-find-usrlocalbin-utilities
  get_sudo
  sudo launchctl config user path "/usr/local/bin:$PATH"
}
