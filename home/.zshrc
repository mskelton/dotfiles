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

# Most aliases exist in ~/.alias, but aliases that have specific syntax
# are placed here.
alias gmm='git merge $(git default)'
alias grm='git rebase $(git default)'

# Make warp play nicely with the GitHub CLI
PAGER=""

# Update tag for GitHub action
function update-tag() {
  latest_tag=$(git tag -l --sort -version:refname | head -n 1)
  tag=$(printf %.2s $latest_tag)

  git tag -fa $tag -m "Update $tag tag"
  git push origin $tag --force
}
