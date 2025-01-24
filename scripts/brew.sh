#!/usr/bin/env bash

brew=/opt/homebrew/bin/brew

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Tap additional repositories
$brew tap homebrew/cask-drivers
$brew tap homebrew/cask-fonts

# Install formulae
formula=(
	1password-cli
	as-tree
	ast-grep
	bash
	bat
	blueutil
	ccache
	clang-format
	cmake
	cocoapods
	dict
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
	keith/formulae/reminders-cli
	luarocks
	neovim
	ngrok/ngrok/ngrok
	ninja
	opam
	p7zip
	rename
	ripgrep
	shellcheck
	sponge
	starship
	stylua
	swiftformat
	task
	timg
	tmux
	trash
	tree
	tree-sitter
	watchman
	wget
	withgraphite/tap/graphite
	yq
	zoxide
)

casks=(
	arc
	docker
	figma
	firefox
	font-jetbrains-mono
	font-symbols-only-nerd-font
	ghostty
	hammerspoon
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
	withgraphite/tap/graphite
	zoom
)

# Install formula and casks
$brew install "${formula[@]}"
$brew install --cask "${casks[@]}"

# Personal/work casks
if [[ -f "$HOME/.work" ]]; then
	$brew install --cask \
		slack
else
	$brew install \
		tursodatabase/tap/turso

	$brew install --cask \
		android-studio \
		quicken
fi
