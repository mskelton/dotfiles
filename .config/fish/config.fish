set -g fish_greeting

# Starship theme
starship init fish | source

# Setup Homebrew env
eval "$(/opt/homebrew/bin/brew shellenv)"

source $HOME/.alias
source $HOME/.config/fish/colors.fish
source $HOME/.config/fish/abbreviations.fish
source $HOME/.config/fish/keybindings.fish
source $HOME/.config/fish/path.fish
source $HOME/.config/fish/env.fish

# Custom environment files that might not exist
for f in custom personal work
    set file $HOME/.config/fish/$f.fish
    test -f $file; and source $file
end

# Setup opam
source $HOME/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true

# Setup fnm
if type -q fnm
    fnm env | source
end

# Setup Zoxide
zoxide init fish | source
