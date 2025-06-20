# Disable Vim mode
set -o emacs

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
