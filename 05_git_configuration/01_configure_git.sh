source "$(dirname $0)/../util/echo_colors.sh"

dirname=$(dirname "$0")

needs_run() {
  return 0
}

dependencies_met() {
  if [ -z "${name}" ]; then
    echo_danger "Configuring Git requires the name environment variable to be set."
    return 1
  fi

  if [ -z "${email}" ]; then
    echo_danger "Configuring Git requires the email environment variable to be set."
    return 1
  fi
}

run() {
  git config --global user.name "$name"
  git config --global user.email "$email"
  git config --global credential.helper osxkeychain
  git config --global pull.rebase false
  git config --global rebase.autosquash true
}
