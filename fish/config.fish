# Hush the greeting message
function fish_greeting; end

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

# Homebrew sbin path
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# Cargo path
set -g fish_user_paths "$HOME/.cargo/bin" $fish_user_paths

# Go path
set -x GOPATH "$HOME/go"
set -g fish_user_paths "$GOPATH/bin" $fish_user_paths

# npm global binaries
set -g fish_user_paths "$HOME/.local/npm/bin" $fish_user_paths

# Bun
set -Ux BUN_INSTALL "$HOME/.bun"
set -px --path PATH "$HOME/.bun/bin"

