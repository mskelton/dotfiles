# Dotfiles

My personal settings and dotfiles.

## Installation

_If on a work device, run `touch ~/.work` before the following commands._

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/git.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/brew.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/macos.sh)"
```

After installing pre-requisites, run the following to setup the dotfiles.

```bash
git clone git@github.com:mskelton/dotfiles.git
cd dotfiles
git submodule init
git submodule update --remote
./install
```

### Additional setup

- [Setup tools](https://github.com/mskelton/dotfiles/tree/main/docs/tools.md)
- [Install Chromium extensions](https://github.com/mskelton/dotfiles/tree/main/docs/chromium-extensions.md)
- [Install Arc boosts](https://github.com/mskelton/dotfiles/tree/main/docs/arc-boosts.md)
- [Install Arc boosts](https://github.com/mskelton/dotfiles/tree/main/docs/arc-boosts.md)
- [Configure Refined GitHub](https://github.com/mskelton/dotfiles/tree/main/docs/refined-github.md)
- [Configure uBlacklist](https://github.com/mskelton/dotfiles/tree/main/docs/ublacklist.md)
- [Install shortcuts](https://github.com/mskelton/dotfiles/tree/main/docs/shortcuts.md)
- [Copy data from old machine](https://github.com/mskelton/dotfiles/tree/main/docs/shortcuts.md)
- [Configure apps](https://github.com/mskelton/dotfiles/tree/main/docs/configure-apps.md)
