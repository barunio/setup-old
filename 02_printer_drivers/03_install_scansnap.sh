source "$(dirname $0)/../util/get_sudo.sh"

needs_run() {
  ! pkgutil --pkgs | grep -q "com.fujitsu.pfu.scansnap.Home"
}

dependencies_met() {
  return 0
}

run() {
  brew install --cask fujitsu-scansnap-home
}
