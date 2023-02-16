set -g fish_greeting

# Starship theme
starship init fish | source

source $HOME/.alias
source $HOME/.config/fish/colors.fish

# Custom environment files that might not exist
for f in widen personal env
  set file $HOME/.config/fish/$f.fish
  test -f $file; and source $file
end

function fish_hybrid_key_bindings
  fzf_key_bindings
  fish_default_key_bindings -M insert
  fish_vi_key_bindings --no-erase

  # Use Ctrl+x since it's something we can map cmd+k to for clearing the screen
  bind -M insert \cx 'echo -n (clear | string replace \e\[3J ""); commandline -f repaint'

  # Open tmux-sessionizer with Ctrl+f
  bind -M insert \cf "tmux-sessionizer; commandline -f repaint"

  # Use _ to go to the beginning of the line as I use this a lot in Vim
  bind -s --preset _ beginning-of-line
  bind -s --preset -M visual _ beginning-of-line

  # Switch between modes with escape. A little out of the ordinary, but I find
  # myself doing it a lot. Also updates escape in insert mode to not move
  # backwards one character.
  bind -s --preset -M insert \e "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f repaint-mode; end"
  bind -s --preset \e "set fish_bind_mode insert; commandline -f repaint-mode"
end

# Use my custom keybindings
set -g fish_key_bindings fish_hybrid_key_bindings

# FZF defaults
set -x FZF_DEFAULT_OPTS "--reverse --info=inline"

# Environment variables
set -x EDITOR "nvim"
set -x GOPATH "$HOME/go"
set -x BUN_INSTALL "$HOME/.bun"
set -x HOMEBREW_NO_ENV_HINTS true

# Setup Homebrew env
eval "$(/opt/homebrew/bin/brew shellenv)"

# Setup asdf package manager
source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.fish

# Path
set -g fish_user_paths $fish_user_paths "$HOME/.local/bin"
set -g fish_user_paths $fish_user_paths "$HOME/.local/bin-widen"
set -g fish_user_paths $fish_user_paths "$GOPATH/bin"
set -g fish_user_paths $fish_user_paths "$HOME/.cargo/bin"
set -g fish_user_paths $fish_user_paths "$HOME/.local/npm/bin"
set -g fish_user_paths $fish_user_paths "$HOME/.bun/bun"
set -g fish_user_paths $fish_user_paths "$fzf_base/bin"
