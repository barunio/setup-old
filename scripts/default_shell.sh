#!/bin/bash

if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s $(which zsh)
fi
