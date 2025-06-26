# History settings
setopt EXTENDED_HISTORY       # Include timestamp
setopt HIST_EXPIRE_DUPS_FIRST # Trim dupes first if history is full
setopt HIST_FIND_NO_DUPS      # Do not display previously found command
setopt HIST_IGNORE_SPACE      # Do not save if line starts with space
setopt HIST_NO_STORE          # Do not save history commands
setopt HIST_REDUCE_BLANKS     # Strip superfluous blanks
setopt INC_APPEND_HISTORY     # Don’t wait for shell to exit to save history lines

# Use Emacs keybindings
set -o emacs

# Word navigation keybindings
bindkey '^B' backward-word
bindkey '^F' forward-word

# Setup starship prompt
eval "$(starship init zsh)"

# Setup Homebrew env
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# Setup fzf
source <(fzf --zsh)

# Setup direnv
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

# Setup fnm
eval "$(fnm env --use-on-cd --corepack-enabled --log-level error --shell zsh)"

# Setup rustup
[ -f $HOME/.cargo/env ] && . $HOME/.cargo/env

# Shell aliases
source $HOME/.alias

# Extra configs
[ -f $HOME/.zshcustom ] && source $HOME/.zshcustom
[ -f $HOME/.zshpersonal ] && source $HOME/.zshpersonal
[ -f $HOME/.zshwork ] && source $HOME/.zshwork

# Path for custom binaries and tools
export PATH="$HOME/.local/bin""\
:$HOME/.local/bin-work""\
:$HOME/.cargo/bin""\
:$HOME/.local/share/npm/bin""\
:$HOME/.bun/bin""\
:$HOME/go/bin""\
:$HOME/flutter/bin""\
:$HOME/Library/Application Support/fnm""\
:$HOME/.slack/bin""\
:$ANDROID_HOME/emulator""\
:$ANDROID_HOME/platform-tools""\
:/opt/homebrew/bin""\
:$PATH"
