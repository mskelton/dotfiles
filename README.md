# Dotfiles

My personal settings and dotfiles.

## Installation

```bash
git clone git@github.com:mskelton/dotfiles.git
git submodule init
git submodule update --remote
cd dotfiles
./install
```

## Pre-requisites

### Install Homebrew formula

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/opt/homebrew/bin/brew install $(cat config/formula.txt)
/opt/homebrew/bin/brew install --cask $(cat config/casks.txt)
```

## Miscellaneous system setup

```bash
./scripts/macos.sh
./scripts/git.sh
./scripts/tools.sh
./scripts/editor.sh
```

### Nerd Fonts

Download and install the
[`Symbols Nerd Font`](https://github.com/ryanoasis/nerd-fonts/blob/da88bdb6/patched-fonts/NerdFontsSymbolsOnly/complete/Symbols-2048-em%20Nerd%20Font%20Complete.ttf)
for Kitty to properly use Nerd font symbols.
