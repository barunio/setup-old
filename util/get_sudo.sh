prompt_if_no_sudo_password() {
  # Get the user's sudo-capable password
  while [ -z "${SUDO_PASSWORD}" ]; do
    read -s "?Password: " password_attempt
    echo

    (echo $password_attempt | sudo -S true) > /dev/null 2>&1 \
      && export SUDO_PASSWORD=$password_attempt
  done
}

get_sudo() {
  prompt_if_no_sudo_password

  if (( ${+SUDO_PASSWORD} )); then
    echo $SUDO_PASSWORD | sudo -S true > /dev/null 2>&1
  fi
}