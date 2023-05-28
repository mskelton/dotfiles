#!/usr/bin/env bash

brew=/opt/homebrew/bin/brew

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Tap additional repositories
$brew tap homebrew/cask-drivers
$brew tap homebrew/cask-fonts

# Install formulae
$brew install \
	bash \
	bat \
	blueutil \
	clang-format \
	cmake \
	cocoapods \
	dict \
	dos2unix \
	fd \
	fish \
	fzf \
	gh \
	git \
	gnu-sed \
	go \
	jesseduffield/lazygit/lazygit \
	jq \
	neovim \
	ninja \
	rename \
	ripgrep \
	sponge \
	starship \
	stylua \
	task \
	tmux \
	trash \
	tree-sitter \
	watchman \
	wget

# Install casks
$brew install --cask \
	arc \
	docker \
	figma \
	firefox \
	font-jetbrains-mono \
	font-symbols-only-nerd-font \
	google-chrome \
	kitty \
	logi-options-plus \
	logitune \
	mic-drop \
	microsoft-edge \
	mimestream \
	phoenix \
	raycast \
	shottr \
	telegram \
	visual-studio-code \
	zoom

# Personal/work casks
if [[ -z "$WORK" ]]; then
	$brew install --cask \
		android-studio \
		quicken \
		obsidian \
		todoist \
		tradingview
else
	brew install --cask \
		slack
fi
