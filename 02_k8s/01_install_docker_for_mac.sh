source "$(dirname "$0")/../util/get_sudo.sh"
source "$(dirname $0)/../util/echo_colors.sh"
source "$(dirname $0)/../util/timeout.sh"
source "$(dirname $0)/../util/self_automation_bless.sh"

needs_run() {
  ! (brew list --cask | grep -q docker) &> /dev/null
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "Docker for Mac requires homebrew be installed first."
    return 1;
  fi
}

# Docker is notoriously tricky to install and run unattended:
# https://github.com/docker/for-mac/issues/2359#issuecomment-607154849
setup_docker_app() {
  timeout 45 osascript -e '
    tell application "System Events"
      repeat until (exists front window of application process "Docker")
        delay 0.1
      end repeat
    end tell
  '
  self_automation_bless
  osascript -e '
    tell application "System Events"
      tell front window of application process "Docker" to click UI Element "OK"
    end tell
  '

  timeout 45 osascript -e '
    tell application "System Events"
      repeat until (exists front window of application process "SecurityAgent")
        delay 0.1
      end repeat
    end tell
  '
  self_automation_bless
  osascript -e "
    tell application \"System Events\"
      tell front window of application process \"SecurityAgent\"
        set value of text field 2 to \"$SUDO_PASSWORD\"
        click UI Element \"Install Helper\" 
      end tell
    end tell
  "
}

run() {
  brew install --cask docker --no-quarantine

  # Automatic completion of the Docker installation seems to cause trouble with the CI VMs and
  # at present is not necessary as we're not automating any further Docker-related steps as part of setup.

  # open /Applications/Docker.app
  # bypass_gatekeeper_prompt

  # echo_primary "Automating Docker installation prompts..."
  # setup_docker_app

  # echo "Waiting for Docker to start..."
  # while ! docker info &> /dev/null; do
  #   sleep 5
  # done

  # This window may not be open yet, but we'll try to close it anyway just for convienience
  # self_automation_bless
  # osascript -e 'tell front window of application "Docker Desktop" to quit' < /dev/null > /dev/null 2>&1 &!

  dockutil --add "/Applications/Docker.app" &
}
