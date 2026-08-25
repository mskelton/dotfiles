#!/usr/bin/env bash

# Load Homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv bash)"

# Install kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Install bun
# https://bun.sh
curl -fsSL https://bun.sh/install | bash

# Install fzf keybindings
/opt/homebrew/opt/fzf/install \
	--no-update-rc \
	--completion \
	--key-bindings \
	--no-bash \
	--no-zsh

# Install lazy.nvim
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable ~/.local/share/nvim/lazy/lazy.nvim

# Install latest LTS version of Node.js
eval "$(fnm env --shell bash)"
fnm install --lts
fnm default lts-latest
fnm use lts-latest

# Use a user directory so sudo is not required for installation
npm config set prefix=~/.local/share/npm

# Disable npm audit and npm fund, I dislike both
npm config set audit=false
npm config set fund=false

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install go binaries
go install github.com/mskelton/branch-manager@latest
go install github.com/mskelton/git-cleanup@latest
go install github.com/mskelton/pr@latest
go install github.com/mskelton/prs@latest
go install github.com/mskelton/url@latest

# Install npm binaries
npm install -g --dangerously-allow-all-scripts \
	@anthropic-ai/claude-code \
	@vscode/vsce \
	ovsx \
	yarn

# Install remote fonts
curl -sL https://termicons.mskelton.dev/termicons.ttf -o "$HOME/Library/Fonts/termicons.ttf"
curl -sL https://github.com/mskelton/vscode-codicons/raw/main/dist/codicon.ttf -o "$HOME/Library/Fonts/codicon.ttf"
