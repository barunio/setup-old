source "$(dirname $0)/../util/echo_colors.sh"
source "$(dirname $0)/../util/user_prompts.sh"

needs_run() {
  ! gpg -k --with-colons | grep -q 'AppFolio GPG key'
}

dependencies_met() {
  if [ -z "${email}" ]; then
    echo_danger "Generating a GPG key requires the email environment variable to be set."
    return 1
  fi

  if [ -z "${name}" ]; then
    echo_danger "Generating a GPG key requires the name environment variable to be set."
    return 1
  fi

  if ! which gpg > /dev/null; then
    echo_danger "Automating SSH key generation requires GnuPG."
    return 1;
  fi
}

run() {
  while [ -z "${gpg_key_password}" ]; do
    gpg_key_password=$(prompt_for_text_secret 'Enter a password for your new GPG key:\n\n(This is required.)')
  done

  gpg --full-generate-key --batch <<< "
    Key-Type: RSA
    Key-Length: 4096
    Subkey-Type: RSA
    Subkey-Length: 4096
    Name-Real: $name
    Name-Comment: AppFolio GPG key
    Name-Email: $email
    Expire-Date: 1y
    Passphrase: $gpg_key_password
    %commit
  "
}

