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
	cask "logi-options+"
	cask "logitune"
EOF
	else
		cat <<EOF
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
	brew "bat"
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
	brew "withgraphite/tap/graphite"
	brew "imagemagick"
	brew "jq"
	brew "just"
	brew "ktlint"
	brew "neovim"
	brew "anomalyco/tap/opencode"
	brew "php"
	brew "ripgrep"
	brew "sponge"
	brew "starship"
	brew "task"
	brew "timg"
	brew "tmux"
	brew "tursodatabase/tap/turso"
	brew "xo/xo/usql"
	brew "watchman"
	brew "wget"
	brew "yq"
	brew "zsh-autosuggestions"
	brew "zsh-fast-syntax-highlighting"

	# Casks
	cask "1password"
	cask "1password-cli"
	cask "android-studio"
	cask "chatgpt"
	cask "cursor"
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
