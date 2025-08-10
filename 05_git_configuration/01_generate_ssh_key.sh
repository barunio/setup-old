source "$(dirname $0)/../util/echo_colors.sh"
source "$(dirname $0)/../util/user_prompts.sh"

needs_run() {
  ! cat ~/.ssh/id_rsa.pub | grep -q "$email"
}

dependencies_met() {
  if [ -z "${email}" ]; then
    echo_danger "Generating an SSH key requires the email environment variable to be set."
    return 1
  fi

  if ! which expect > /dev/null; then
    echo_danger "Automating SSH key generation requires expect."
    return 1;
  fi
}

run() {
  while [ -z "${ssh_key_password}" ]; do
    ssh_key_password=$(prompt_for_text_secret 'Enter a password for your new SSH key:\n\n(This is required.)')
  done

  ssh-keygen -t rsa -b 4096 -C "$email" -N "$ssh_key_password" -f ~/.ssh/id_rsa <<< y

  # escape '$' as '\$'
  ssh_key_password=$(echo $ssh_key_password | sed 's/\$/\\\$/g')

  # Use expect to respond to prompts, and use sed to keep the password out of stdout
  expect <<< "
    spawn ssh-add -K $HOME/.ssh/id_rsa
    expect {
      -re \"Enter passphrase for .*\" {
        send \"$ssh_key_password\r\"
        exp_continue
      }
      -re \"Identity added: .*\" {
        exit 0
      }
    }

    catch wait result
    exit [lindex \$result 3]
  " |& sed "s/$ssh_key_password/<password>/g"

  if (( ${pipestatus[1]} )); then
    echo_danger "Failed to add the generated key to the SSH agent."
    return 1
  fi
}
