# Dotfiles

My personal settings and dotfiles.

## Installation

<details>
  <summary>
    Before continuing, expand and follow the Git setup instructions.
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

```bash
git clone git@github.com:mskelton/dotfiles.git
cd dotfiles
git submodule init
git submodule update --remote
./install
```

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
