# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh

source "$(dirname "$0")/../util/get_sudo.sh"
dirname=$(dirname "$0")

needs_run() {
  ! brew list | grep -q zsh-completions
}

dependencies_met() {
  if ! (( ${+commands[brew]} )); then
    echo "The Homebrew Zsh Completions requires homebrew be installed first."
    return 1;
  fi
}

run() {
  brew install zsh-completions

  echo "$(cat $dirname/21_configure_brew_completions/add_to_zshrc ~/.zshrc)" > ~/.zshrc

  get_sudo
  sudo chmod go-w "$(brew --prefix)/share"
}
