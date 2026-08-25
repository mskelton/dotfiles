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
# Each line prepends; later entries take precedence over earlier ones
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$HOME/Library/Application Support/fnm:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/.local/share/npm/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Setup Homebrew env
eval "$(/opt/homebrew/bin/brew shellenv)"

# Enable fzf
export FZF_DEFAULT_OPTS="--reverse --info=inline"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
