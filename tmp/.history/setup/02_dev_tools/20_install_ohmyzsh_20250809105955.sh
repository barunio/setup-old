source "$(dirname "$0")/../util/get_sudo.sh"
dirname=$(dirname "$0")

needs_run() {
  test -z $ZSH
}

dependencies_met() {
  # We're not using brew here, but the brew installer installs git which
  # is necessary for the OhMyZsh installer
  if ! (( ${+commands[brew]} )); then
    echo "OhMyZsh requires homebrew be installed first."
    return 1;
  fi
}

fix_zsh_permissions() {
  get_sudo
  sudo chmod g-w,o-w /usr/local/share/zsh
  sudo chmod g-w,o-w /usr/local/share/zsh/site-functions
}

configure_zsh() {
  sed -i '' 's/robbyrussell/agnoster/g' ~/.zshrc

  ohmyzsh_plugins="bundler docker gem git git-auto-fetch rails rake sudo"
  sed -i '' "s/plugins=(git)/plugins=($ohmyzsh_plugins)/g" ~/.zshrc
}

configure_mac_terminal() {
  git clone https://github.com/Twixes/SF-Mono-Powerline.git
  cp SF-Mono-Powerline/*.otf ~/Library/Fonts/
  rm -rf SF-Mono-Powerline/

  open "$dirname/20_install_ohmyzsh/Argonaut.terminal" && \
  sleep 10 && osascript -e 'tell application "Terminal" to close first window' || true

  open "$dirname/20_install_ohmyzsh/Darcula.terminal" && \
  sleep 10 && osascript -e 'tell application "Terminal" to close first window' || true

  sleep 5

  get_sudo
  sudo -u $USER defaults write com.apple.Terminal.plist "Default Window Settings" "Darcula"
  sudo -u $USER defaults write com.apple.Terminal.plist "Startup Window Settings" "Darcula"
}

run() {
  RUNZSH=no
  get_sudo
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  fix_zsh_permissions
  configure_zsh
  configure_mac_terminal
}
