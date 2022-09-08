set -g fish_greeting

source $HOME/.alias
source $HOME/.config/fish/colors.fish

# Custom environment files that might not exist
for file in $HOME/.config/fish/widen.fish $HOME/.config/fish/env.fish
  test -f $file; and source $file
end

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
