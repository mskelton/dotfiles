#!/usr/bin/env bash

brew=/opt/homebrew/bin/brew

# Install brew
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

get_conditional_packages() {
	if [[ -f "$HOME/.work" ]]; then
		cat <<EOF
	cask "granola"
	cask "logi-options+"
	cask "logitune"
EOF
	else
		cat <<EOF
	cask "android-studio"
	brew "flyctl"
	cask "firefox"
	cask "telegram"
	cask "zoom"
EOF
	fi
}

# Install from Brewfile using heredoc
echo "Installing packages from Brewfile..."
$brew bundle --file=- <<EOF
	# Formulae
	brew "ast-grep"
	brew "bash"
	brew "composer"
	brew "fd"
	brew "ffmpeg"
	brew "fnm"
	brew "fzf"
	brew "gh"
	brew "git"
	brew "gnu-sed"
	brew "go"
	brew "gradle"
	brew "withgraphite/tap/graphite"
	brew "imagemagick"
	brew "jq"
	brew "just"
	brew "ktlint"
	brew "neovim"
	brew "anomalyco/tap/opencode"
	brew "php"
	brew "ripgrep"
	brew "uv"
	brew "timg"
	brew "xo/xo/usql"
	brew "wget"
	brew "yq"
	brew "zsh-autosuggestions"
	brew "zsh-fast-syntax-highlighting"

	# Casks
	cask "1password"
	cask "1password-cli"
	cask "chatgpt"
	cask "cursor"
	cask "figma"
	cask "font-jetbrains-mono"
	cask "font-symbols-only-nerd-font"
	cask "hammerspoon"
	cask "orbstack"
	cask "raycast"
	cask "shottr"
	cask "visual-studio-code"

	# Conditional casks
	$(get_conditional_packages)
EOF
