#!/usr/bin/env bash

# Make fish the default shell
sudo sh -c "echo /opt/homebrew/bin/fish >> /etc/shells"
chsh -s /opt/homebrew/bin/fish

# Install Starship
curl -sS https://starship.rs/install.sh | sh

# Install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install tpm plugins
~/.tmux/plugins/tpm/bin/install_plugins

# Install fzf keybindings
/opt/homebrew/opt/fzf/install

# Install Docker completion
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish -o ~/.config/fish/completions/docker.fish

# Install lazy.nvim
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable ~/.local/share/nvim/lazy/lazy.nvim

# Use a user directory so sudo is not required for installation
npm config set prefix=~/.local/share/npm

# Disable npm audit and npm fund, I dislike both
npm config set audit=false
npm config set fund=false

# Disable pnpm update notifier
npm config set update-notifier=false

# Enable corepack
sudo corepack enable

# Install go binaries
go install github.com/mskelton/lorem@latest
go install github.com/mskelton/pomo@latest
go install github.com/mskelton/url@latest
go install github.com/mskelton/zet@latest
go install github.com/spf13/cobra-cli@latest

# Install gh extensions
gh extension install dlvhdr/gh-dash
gh extension install gennaro-tedesco/gh-f
gh extension install mislav/gh-branch
gh extension install mislav/gh-license
