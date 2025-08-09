#!/bin/zsh
TRAPZERR() {
  echo_danger "There was a fatal error, and setup exited early."
  echo_danger "Please check the log carefully and consider sharing it."
  exit 1
}

cd "$(dirname "$0")"
source ./util/echo_colors.sh
source ./util/get_sudo.sh
source ./util/self_automation_bless.sh
export TIMEOUT_SECONDS=600

echo_primary "Setting up initial dependencies..."
prompt_if_no_sudo_password

# Disable homebrew auto-updating so we can parallelize
# installs with less cross-process locking
export HOMEBREW_NO_AUTO_UPDATE=1
./run_scripts.sh 01_init
brew update

# Theoretically, the dev_tools and k8s script sets could run in parallel but the Docker install script
# (in k8s folder) seems to fail frequently when run with too many other things going on
echo_primary "Installing dev tools and printer drivers..."
./run_scripts.sh 02_dev_tools 02_k8s 02_printer_drivers


export name="Barun Singh"
export email="barunio@gmail.com"

echo_primary "Configuring git..."
./run_scripts.sh 05_git_configuration

echo
echo_primary "Setup completed successfully, and some final steps for the end user were linked on the desktop."
