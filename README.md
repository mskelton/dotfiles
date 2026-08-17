# Dotfiles

## Pre-requisites

- Ensure Google Chrome is installed before running the following commands
- If on a work device, run `touch ~/.work` before the following commands

## Setup

```bash
git clone https://github.com/mskelton/dotfiles.git && cd dotfiles
./scripts/brew.sh
./scripts/tools.sh
./scripts/macos.sh
./scripts/git.sh
ln hooks/pre-commit .git/hooks/pre-commit
curl -LSfs https://go.mskelton.dev/farm/install | sh
[ -f $HOME/.work ] && farm link work || farm link home
```

## Configuration

[System](https://github.com/mskelton/dotfiles/tree/main/docs/02-system.md)

## Pre-migration

[Migration checklist](https://github.com/mskelton/dotfiles/tree/main/docs/01-migration-checklist.md)
