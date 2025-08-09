source "$(dirname $0)/../util/get_sudo.sh"
source "$(dirname "$0")/../util/self_automation_bless.sh"

needs_run() {
  ! brew list --cask | grep -q zoom
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "Zoom requires homebrew be installed first."
    return 1;
  fi
}

run() {
  SUDO_ASKPASS="$(realpath ./util/get_sudo_askpass.sh)" brew install --cask zoom

  # Get rid of the "Zoom wants access to your downloads folder" prompt
  self_automation_bless

  # This window may not be open yet, but we'll try to close it anyway just for convienience
  self_automation_bless
  osascript -e 'tell front window of application "zoom.us" to quit' < /dev/null > /dev/null 2>&1 &!

  dockutil --add "/Applications/zoom.us.app" &
}
