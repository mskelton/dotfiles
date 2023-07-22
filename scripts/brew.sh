#!/usr/bin/env bash

brew=/opt/homebrew/bin/brew

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Tap additional repositories
$brew tap homebrew/cask-drivers
$brew tap homebrew/cask-fonts

# Install formulae
formula=(
	bash
	bat
	blueutil
	ccache
	clang-format
	cmake
	cocoapods
	dict
	fd
	fish
	fzf
	gh
	git
	gnu-sed
	go
	jesseduffield/lazygit/lazygit
	jq
	luarocks
	neovim
	ninja
	p7zip
	pngpaste
	rename
	ripgrep
	sponge
	starship
	stylua
	task
	tmux
	trash
	tree-sitter
	watchman
	wget
)

casks=(
	arc
	docker
	figma
	firefox
	font-jetbrains-mono
	font-symbols-only-nerd-font
	google-chrome
	kitty
	logi-options-plus
	logitune
	mic-drop
	microsoft-edge
	mimestream
	raycast
	shottr
	telegram
	visual-studio-code
	zoom
)

# Install formula and casks
$brew install ${formula[@]}
$brew install --cask ${casks[@]}

# Personal/work casks
if [[ -z "$WORK" ]]; then
	$brew install --cask \
		android-studio \
		dozer \
		quicken \
		obsidian \
		todoist \
		tradingview
else
	brew install --cask \
		slack
fi
