#!/usr/bin/env bash

brew=/opt/homebrew/bin/brew

# Install brew
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	brew trust --formula xo/xo/usql
fi

# Install from Brewfile using heredoc
echo "Installing packages from Brewfile..."
$brew bundle --file=- <<EOF
	# Formulae
	brew "bash"
	brew "composer"
	brew "fd"
	brew "ffmpeg"
	brew "flyctl"
	brew "fnm"
	brew "fzf"
	brew "gh"
	brew "git"
	brew "gnu-sed"
	brew "go"
	brew "gradle"
	brew "hk"
	brew "withgraphite/tap/graphite"
	brew "imagemagick"
	brew "jq"
	brew "mkcert"
	brew "media-control"
	brew "just"
	brew "ktlint"
	brew "neovim"
	brew "tree-sitter-cli"
	brew "php"
	brew "ripgrep"
	brew "uv"
	brew "xo/xo/usql"
	brew "wget"
	brew "zsh-autosuggestions"
	brew "zsh-fast-syntax-highlighting"

	# Casks
	cask "font-jetbrains-mono"
	cask "font-symbols-only-nerd-font"
EOF
