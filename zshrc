# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# automatically enter directories without cd
setopt auto_cd

# use macvim as an editor
# look in the wego code directory when we cd
cdpath=(~/work/code/)

export EDITOR='mvim -f'

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# use incremental search
bindkey "^R" history-incremental-search-backward

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy keybindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# keep and save TONS of history
export HISTSIZE=4096
export SAVEHIST=1000
export HISTFILE=~/.zhistory
# ignore duplicate history entries
setopt histignoredups
# append command to history file once executed
setopt inc_append_history

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# Try to correct command line spelling
# setopt CORRECT CORRECT_ALL

# Enable extended globbing
setopt EXTENDED_GLOB

export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"
export PATH="./bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# local config
if [ -e "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
