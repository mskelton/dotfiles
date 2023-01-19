#!/usr/bin/env bash

# Make fish the default shell
sudo sh -c "echo $(brew --prefix)/bin/fish >> /etc/shells"
chsh -s $(brew --prefix)/bin/fish

# Install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install tpm plugins
~/.tmux/plugins/tpm/bin/install_plugins

# Install fzf keybindings
$(brew --prefix)/opt/fzf/install

# Install Docker completion
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish -o ~/.config/fish/completions/docker.fish

# Install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Use a user directory so sudo is not required for installation
npm config set prefix=~/.local/share/npm

# Disable npm audit and npm fund, I dislike both
npm config set audit=false
npm config set fund=false

# Enable corepack
corepack enable

# Install go binaries
go install github.com/mskelton/lorem@latest
go install github.com/mskelton/pomo@latest
go install github.com/mskelton/zet@latest
go install github.com/spf13/cobra-cli@latest

# Install gh extensions
gh extension install dlvhdr/gh-dash
gh extension install gennaro-tedesco/gh-f
gh extension install mislav/gh-branch
gh extension install mislav/gh-license
