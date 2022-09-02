set -g fish_greeting

function __source_if_exists
  test -f $argv; and source $argv
end

source $HOME/.alias
source $HOME/.config/fish/colors.fish

# Custom environment
__source_if_exists $HOME/.config/fish/widen.fish
__source_if_exists $HOME/.config/fish/env.fish

# FZF keybindings
set -g fish_key_bindings fish_default_key_bindings

# Environment variables
set -x EDITOR "nvim"
set -x GOPATH "$HOME/go"
set -x BUN_INSTALL "$HOME/.bun"

# Path
set -g fish_user_paths $fish_user_paths "$GOPATH/bin"
set -g fish_user_paths $fish_user_paths "$HOME/.cargo/bin"
set -g fish_user_paths $fish_user_paths "$HOME/.local/npm/bin"
set -g fish_user_paths $fish_user_paths "$HOME/.bun/bun"
set -g fish_user_paths $fish_user_paths "$fzf_base/bin"
set -g fish_user_paths $fish_user_paths "/usr/local/sbin"
