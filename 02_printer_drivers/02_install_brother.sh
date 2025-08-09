needs_run() {
  ! pkgutil --pkgs | grep "com.Brother.Brotherdriver"
}

dependencies_met() {
  return 0
}

run() {
  echo "\n\nVisit the Brother website to download the printer driver for the HL-2270DW printer:"
  echo "https://www.brother-usa.com/support/hl2270dw"
  open https://www.brother-usa.com/support/hl2270dw
}
