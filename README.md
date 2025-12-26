# Dotfiles

_If on a work device, run `touch ~/.work` before the following commands._

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/git.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/brew.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/tools.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/chrome.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/macos.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/vscode-extensions.sh)"
```

After installing pre-requisites, run the following to setup the dotfiles.

```bash
git clone git@github.com:mskelton/dotfiles.git
cd dotfiles
ln hooks/pre-commit .git/hooks/pre-commit
curl -LSfs https://go.mskelton.dev/farm/install | sh
[ -f $HOME/.work ] && farm link work || farm link home
```

- [Migration checklist](https://github.com/mskelton/dotfiles/tree/main/docs/01-migration-checklist.md)
- [System](https://github.com/mskelton/dotfiles/tree/main/docs/02-system.md)
- [Apps](https://github.com/mskelton/dotfiles/tree/main/docs/03-apps.md)
