#!/bin/bash

################################################################
# KEYBOARD SHORTCUTS DEFINED HERE WILL NOT APPEAR IN THE       #
# SYSTEM PREFERENCES KEYBOARD SHORTCUTS GUI                    #
#                                                              #
# Example of how to use the console to see existing shortcuts: #
#   defaults read -app Terminal NSUserKeyEquivalents           #
################################################################

# OS X Terminal:
#
#   Ctrl-Tab to go to the next tab
#   Ctrl-Shift-Tab to go to the previous one
defaults write -app Terminal NSUserKeyEquivalents '{
  "Show Next Tab" = "^\U21e5";
  "Show Previous Tab" = "^$\U21e5";
}'


