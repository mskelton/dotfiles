# Dotfiles

My personal settings and dotfiles.

## Installation

```sh
git clone git@github.com:mskelton/dotfiles.git
cd dotfiles
./install
```

## Pre-requisites

### Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install Homebrew formulas

```sh
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

Fish variables can't be directly symlinked, but there is a sample file to get
things started.

```sh
cp ~/.config/fish/fish_variables.sample ~/.config/fish/fish_variables
```

Also make sure to install fish plugins.

```sh
curl -sL https://git.io/fisher | source
fisher update
```

## Miscelaneous system setup

### macOS settings

```sh
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g NSScrollViewRubberbanding -int 0
```

### Nerd Fonts

Download and install the [`Symbols Nerd Font`](https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Symbols-2048-em%20Nerd%20Font%20Complete.ttf) for Kitty to properly use Nerd font symbols.
