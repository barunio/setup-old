needs_run() {
  ! cat ~/.gnupg/gpg-agent.conf | grep -q 'pinentry-program /usr/local/bin/pinentry-mac'
}

dependencies_met() {
  if ! which gpg > /dev/null; then
    echo "Configuring gnupg requires gnupg be installed first."
    return 1
  fi

  if ! which pinentry-mac > /dev/null; then
    echo "Configuring gnupg requires pinentry-mac be installed first."
    return 1
  fi
}

run() {
  mkdir -p ~/.gnupg/
  echo 'pinentry-program /usr/local/bin/pinentry-mac' >> ~/.gnupg/gpg-agent.conf

  echo 'export GPG_TTY=$(tty)' >> ~/.zshrc

  # Fix: `gpg: WARNING: unsafe permissions on homedir '/Users/<user>/.gnupg'`
  chmod 700 ~/.gnupg
  chmod 600 ~/.gnupg/*
}
