#!/usr/bin/env bash

user=$(whoami)
read -p 'What is your email? ' email

# Create the ssh key
mkdir $HOME/.ssh
ssh-keygen -t ed25519 -C $email
cat <<EOF >$HOME/.ssh/config
Host *.github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
EOF

# Create the default global gitconfig
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
