echo_primary() {
  echo "($(date '+%X')) \033[0;34m$1\033[0m"
}

echo_warning() {
  echo "($(date '+%X')) \033[0;33m$1\033[0m"
}

echo_danger() {
  echo "($(date '+%X')) \033[0;31m$1\033[0m"
}
