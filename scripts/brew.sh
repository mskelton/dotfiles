#!/usr/bin/env bash

brew=/opt/homebrew/bin/brew

# Install brew
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install formulae
formula=(
	ast-grep
	bash
	blueutil
	ccache
	clang-format
	cmake
	cocoapods
	fd
	ffmpeg
	fish
	flyctl
	fnm
	fzf
	gh
	git
	gnu-sed
	go
	imagemagick
	jesseduffield/lazygit/lazygit
	jq
	just
	neovim
	ninja
	ripgrep
	starship
	task
	tmux
	trash
	tree-sitter
	watchman
	wget
	withgraphite/tap/graphite
	yq
)

casks=(
	arc
	figma
	firefox
	font-jetbrains-mono
	font-symbols-only-nerd-font
	hammerspoon
	logi-options-plus
	logitune
	microsoft-edge
	raycast
	shottr
	visual-studio-code
	zoom
)

# Personal/work casks
if [[ -f "$HOME/.work" ]]; then
	casks+=(
		android-studio
		mic-drop
		slack
	)
else
	casks+=(
		android-studio
		docker
		telegram
	)
fi

# Install formula and casks
$brew install "${formula[@]}"
$brew install --cask "${casks[@]}"
