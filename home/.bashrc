# Hide macOS Bash 3.2 deprecation warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# Starship theme
eval "$(starship init bash)"

# Custom aliases
source "$HOME/.alias"

# Environment variables
export EDITOR=nvim
export GOPATH="$HOME/go"
export BUN_INSTALL="$HOME/.bun"
export CLOUDSDK_PYTHON="python3.9"

# Path
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/bin-work"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/share/npm/bin"
export PATH="$PATH:$HOME/.claude/local/bin"
export PATH="$PATH:$HOME/.bun/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/flutter/bin"
export PATH="$PATH:$HOME/Library/Application Support/fnm"
export PATH="$PATH:$HOME/.slack/bin"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:/opt/homebrew/bin

# Setup Homebrew env
eval "$(/opt/homebrew/bin/brew shellenv)"

# Enable fzf
export FZF_DEFAULT_OPTS="--reverse --info=inline"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
