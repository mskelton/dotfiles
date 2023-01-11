# Hide macOS Bash 3.2 deprecation warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# Starship theme
eval "$(starship init bash)"

# Custom aliases
source $HOME/.alias

# Custom environment files that might not exist
files=($HOME/.bashrc-widen $HOME/.bashenv-widen)
for file in "${files[@]}"; do
	[ -f $file ] && source $file
done

# Environment variables
export EDITOR=nvim
export GOPATH="$HOME/go"
export BUN_INSTALL="$HOME/.bun"

# Path
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/bin-widen"
export PATH="$PATH:$HOME/.local/npm/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.bun/bun"
export PATH="$PATH:$fzf_base/bin"

# Setup Homebrew env
if [[ "$(uname -m)" == "arm64" ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
else
	eval "$(/usr/local/bin/brew shellenv)"
fi

# Enable fzf
export FZF_DEFAULT_OPTS="--reverse --info=inline"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source /Users/mark/.docker/init-bash.sh || true # Added by Docker Desktop
