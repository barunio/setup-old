#!/bin/zsh
source "$(dirname "$0")/get_sudo.sh"
prompt_if_no_sudo_password
echo $SUDO_PASSWORD
