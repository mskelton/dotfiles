#!/usr/bin/env bash

user=$(whoami)
read -p 'Email: ' email

# Generate new ssh key
ssh-keygen -t ed25519 -C $email

# Configure GitHub to use the newly created ssh key
cat <<EOF >$HOME/.ssh/config
Host *.github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
EOF

# Create the default gitconfig
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
