# Dotfiles

My personal settings and dotfiles.

## Installation

```bash
git clone git@github.com:mskelton/dotfiles.git
cd dotfiles
./install
```

## Pre-requisites

### Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install Homebrew formulas

```bash
brew install $(cat config/formula.txt)
```

### Git config

To setup the git config, add the following block to `~/.gitconfig` and remove
much of your existing config.

```
[include]
	path = /Users/USER/.gitconfig-shared
```

### Fish

```bash
curl -sL https://git.io/fisher | source
fisher update
```

### Neovim

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

## Miscelaneous system setup

### macOS settings

```bash
./macos-setup.sh
```

### Nerd Fonts

Download and install the
[`Symbols Nerd Font`](https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Symbols-2048-em%20Nerd%20Font%20Complete.ttf)
for Kitty to properly use Nerd font symbols.

### Tmux

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
