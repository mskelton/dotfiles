#!/usr/bin/env bash

# Allow fish to be used as a shell
sudo sh -c "echo /opt/homebrew/bin/fish >> /etc/shells"

# Install kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Install bun
# https://bun.sh
curl -fsSL https://bun.sh/install | bash

# Install Starship
# https://starship.rs
curl -sS https://starship.rs/install.sh | sh
mkdir ~/.cache/starship

# Install fzf keybindings
/opt/homebrew/opt/fzf/install \
	--no-update-rc \
	--completion \
	--key-bindings \
	--no-bash \
	--no-zsh

# Install lazy.nvim
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable ~/.local/share/nvim/lazy/lazy.nvim

# Use a user directory so sudo is not required for installation
npm config set prefix=~/.local/share/npm

# Disable npm audit and npm fund, I dislike both
npm config set audit=false
npm config set fund=false

# Disable pnpm update notifier
npm config set update-notifier=false

# Disable pnpm workspace root check
npm config set ignore-workspace-root-check=true

# Enable corepack
sudo corepack enable

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install cargo binaries
cargo install --git https://github.com/mskelton/pngpaste
cargo install --git https://github.com/mskelton/dtsfmt

# Install go binaries
go install github.com/mskelton/byte@latest
go install github.com/mskelton/git-cleanup@latest
go install github.com/mskelton/lorem@latest
go install github.com/mskelton/pr@latest
go install github.com/mskelton/prs@latest
go install github.com/mskelton/url@latest
go install github.com/spf13/cobra-cli@latest

# Install gh extensions
gh extension install mislav/gh-license

# Install npm binaries
npm install -g turbo
npm install -g @anthropic-ai/claude-code
npm install -g @vscode/vsce
npm install -g ovsx

# Install remote fonts
curl -sL https://termicons.mskelton.dev/termicons.ttf -o $HOME/Library/Fonts/termicons.ttf
curl -sL https://github.com/mskelton/vscode-codicons/raw/main/dist/codicon.ttf -o $HOME/Library/Fonts/codicon.ttf

# Setup launchd services
# launchd-reload
