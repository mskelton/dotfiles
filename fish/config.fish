set -g fish_greeting

# Starship theme
starship init fish | source

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

# Setup Homebrew env
eval "$(/opt/homebrew/bin/brew shellenv)"

# Setup pyenv
# if test -d "$PYENV_ROOT"
#   pyenv init - | source
# end
