# Setup starship prompt
eval "$(starship init zsh)"

# Setup Homebrew env
eval "$(/opt/homebrew/bin/brew shellenv)"

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
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin-work:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/npm/bin:$PATH"
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/flutter/bin:$PATH"
export PATH="$HOME/Library/Application Support/fnm:$PATH"
export PATH="$HOME/.slack/bin:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
