set -g fish_greeting

# Colors
source ~/.config/fish/colors.fish

# Include custom environment
if test -f ~/.config/fish/env.fish
  source ~/.config/fish/env.fish
end

# Custom aliases
source $HOME/.alias

# Most aliases exist in ~/.alias, but aliases that have specific syntax
# are placed here.
alias gmm "git merge (git default)"
alias grm "git rebase (git default)"

# Environment variables
set -x EDITOR "nvim"
set -x GOPATH "$HOME/go"
set -x BUN_INSTALL "$HOME/.bun"

# Path
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "$HOME/.cargo/bin" $fish_user_paths
set -g fish_user_paths "$GOPATH/bin" $fish_user_paths
set -g fish_user_paths "$HOME/.local/npm/bin" $fish_user_paths
set -g fish_user_paths "$HOME/.bun/bun" $fish_user_paths
