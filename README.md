Barun's new computer setup. Automated, just `cd` into this directory and run
`./setup`.

## What this does

* Set up new ssh keys if needed
* Install homebrew formulas (work things)
* Install applications via `brew cask` (not just work things)
* Install MacVim
* Setup dotfiles
* Clone wegowise repo
* Set up keyboard shortcuts, default to zshell
* Configure startup services
* Give instructions for what needs to be done manually to finish setup

The script should be idempotent. Look at the [setup script](setup) to see what
exactly is installed and [browse the dotfiles](dotfiles/) to check
configurations.
