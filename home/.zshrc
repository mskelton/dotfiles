# oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=()

# Initialize oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Custom aliases
source $HOME/.alias

# If a .zshcustom file exists, load the custom configuration from that file
if [ -f $HOME/.zshcustom ]; then
  source $HOME/.zshcustom
fi

# Make warp play nicely with the GitHub CLI
PAGER=""

