#!/usr/bin/env bash

# Make fish the default shell
sudo sh -c "echo /opt/homebrew/bin/fish >> /etc/shells"
chsh -s /opt/hombrew/bin/fish

# Install Kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Install Starship
curl -sS https://starship.rs/install.sh | sh

# Install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install tpm plugins
~/.tmux/plugins/tpm/bin/install_plugins

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

# Install gh extensions
gh extension install dlvhdr/gh-dash
gh extension install gennaro-tedesco/gh-f
gh extension install mislav/gh-branch
gh extension install mislav/gh-license
