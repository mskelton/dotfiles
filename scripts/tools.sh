#!/usr/bin/env bash

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

# Install latest LTS version of Node.js
fnm install --lts

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
npm install -g @anthropic-ai/claude-code
npm install -g @vscode/vsce
npm install -g ovsx

# Install remote fonts
curl -sL https://github.com/mskelton/vscode-codicons/raw/main/dist/codicon.ttf -o "$HOME/Library/Fonts/codicon.ttf"
