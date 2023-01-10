#!/usr/bin/env bash

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
