source "$(dirname $0)/../util/echo_colors.sh"
source "$(dirname $0)/../util/user_prompts.sh"

needs_run() {
  ! ls ~/src/af_ssh_config/ > /dev/null
}

dependencies_met() {
  return 0
}

run() {
  mkdir -p ~/src/af_ssh_config/
  git clone org-115119@github.com:appfolio/af_ssh_config.git ~/src/af_ssh_config/
  cp ~/src/af_ssh_config/config ~/.ssh/config
  sed -i '' "s/# User REPLACEME/User $(id -un)/g" ~/.ssh/config

  open -a TextEdit ~/.ssh/id_rsa.pub
  prompt_text="Please copy/paste the SSH key that just opened in TextEdit, log in to "
  prompt_text+="the Accounts App (URL below) and update the 'Public SSH Key' section: \n"
  prompt_text+="https://accounts.appf.io/\n\n"
  prompt_text+="Close TextEdit and click next when completed."
  prompt "$prompt_text"
}
