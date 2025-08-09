source "$(dirname $0)/../util/echo_colors.sh"

needs_run() {
  ! ((
    brew list --cask | grep -q slack
  ) || (
    test -d "/Applications/Slack.app"
  ))
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo_danger "Slack requires homebrew be installed first."
    return 1;
  fi
}

run() {
  brew install --cask slack
  dockutil --add "/Applications/Slack.app" &
}
