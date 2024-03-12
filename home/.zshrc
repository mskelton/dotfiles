# Custom aliases
source $HOME/.alias

# If a .zshcustom file exists, load the custom configuration from that file
if [ -f $HOME/.zshcustom ]; then
  source $HOME/.zshcustom
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup starship prompt
eval "$(starship init zsh)"
