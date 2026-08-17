# Hide macOS Bash 3.2 deprecation warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# Custom aliases
source "$HOME/.alias"

# Environment variables
export EDITOR=nvim
export GOPATH="$HOME/go"
export BUN_INSTALL="$HOME/.bun"
export CLOUDSDK_PYTHON="python3"

# Custom config
[ -f "$HOME/.bashcustom" ] && source "$HOME/.bashcustom"

# Path for custom binaries and tools
[ -f "$HOME/.path" ] && source "$HOME/.path"

# Setup Homebrew env
eval "$(/opt/homebrew/bin/brew shellenv)"

# Enable fzf
export FZF_DEFAULT_OPTS="--reverse --info=inline"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
