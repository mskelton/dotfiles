# Dotfiles

My personal settings and dotfiles.

## Installation

<details>
  <summary>
    Before continuing, expand and follow the Git setup instructions.
  </summary>

```bash
xcode-select --install

user=$(whoami)
read '?What is your email?: ' email
ssh-keygen -t ed25519 -C $email

mkdir $HOME/.ssh
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

### System setup

_If on a work device, run `export WORK=1` before the following commands._

```bash
./scripts/brew.sh
./scripts/macos.sh
./scripts/tools.sh
```


<details>
  <summary>
    Additional steps to copy data from old machine
  </summary>

- Copy Quicken data files
- Copy `~/.config/fish/custom.fish`
- Copy Taskwarrior data `~/.task`
- Copy `~/.local/share/fish/fish_history`
- Copy pictures and documents

</details>
