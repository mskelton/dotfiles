# Dotfiles

My personal settings and dotfiles.

## Installation

```bash
git clone git@github.com:mskelton/dotfiles.git
cd dotfiles
git submodule init
git submodule update --remote
./install
```

## Git

<details>
  <summary>
    Expand to see Git setup instructions
  </summary>

```bash
user=$(whoami)
read -p 'Email: ' email
ssh-keygen -t ed25519 -C $email

cat <<EOF >$HOME/.ssh/config
Host *.github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
EOF

cat <<EOF >$HOME/.gitconfig
[user]
	name = Mark Skelton
	email = $email
  signingKey = /Users/$user/.ssh/id_ed25519.pub
[core]
	excludesfile = /Users/$user/.gitignore-global
[commit]
  gpgsign = true
[gpg]
	format = ssh
[include]
	path = /Users/$user/.gitconfig-shared
EOF

echo "Run the following command to copy the ssh key to your clipboard."
echo ""
echo "cat ~/.ssh/id_ed25519.pub | pbcopy"
echo ""
```

</details>

### Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/opt/homebrew/bin/brew install $(cat config/formula.txt)
/opt/homebrew/bin/brew install --cask $(cat config/casks.txt)
```

### Miscellaneous system setup

```bash
./scripts/macos.sh
./scripts/tools.sh
```

### Nerd Fonts

Download and install the
[`Symbols Nerd Font`](https://github.com/ryanoasis/nerd-fonts/blob/da88bdb6/patched-fonts/NerdFontsSymbolsOnly/complete/Symbols-2048-em%20Nerd%20Font%20Complete.ttf)
for Kitty to properly use Nerd font symbols.
