#!/usr/bin/env bash

brew=/opt/homebrew/bin/brew

# Install brew
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

get_conditional_casks() {
	if [[ -f "$HOME/.work" ]]; then
		cat <<EOF
	cask "mic-drop"
	cask "slack"
	cask "logi-options-plus"
	cask "logitune"
EOF
	else
		cat <<EOF
	cask "thebrowsercompany-dia"
	cask "telegram"
	cask "zoom"
EOF
	fi
}

# Install from Brewfile using heredoc
echo "Installing packages from Brewfile..."
$brew bundle --file=- <<EOF
	# Taps
	tap "jesseduffield/lazygit"
	tap "withgraphite/tap"
	tap "xo/xo"

	# Formulae
	brew "ast-grep"
	brew "bash"
	brew "blueutil"
	brew "fd"
	brew "ffmpeg"
	brew "fish"
	brew "flyctl"
	brew "fnm"
	brew "fzf"
	brew "gh"
	brew "git"
	brew "gnu-sed"
	brew "go"
	brew "imagemagick"
	brew "lazygit"
	brew "jq"
	brew "just"
	brew "neovim"
	brew "ripgrep"
	brew "starship"
	brew "task"
	brew "timg"
	brew "tmux"
	brew "trash"
	brew "tree-sitter"
	brew "watchman"
	brew "wget"
	brew "graphite"
	brew "usql"
	brew "yq"
	brew "zsh-autosuggestions"
	brew "zsh-fast-syntax-highlighting"

	# Casks
	cask "android-studio"
	cask "arc"
	cask "figma"
	cask "firefox"
	cask "font-jetbrains-mono"
	cask "font-symbols-only-nerd-font"
	cask "hammerspoon"
	cask "microsoft-edge"
	cask "raycast"
	cask "shottr"
	cask "visual-studio-code"

	# Conditional casks
	$(get_conditional_casks)
EOF
