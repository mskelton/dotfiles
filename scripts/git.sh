#!/usr/bin/env bash

read -rp "Personal email: " personal_email

mkdir -p "$HOME/.ssh"
ssh-keygen -t ed25519 -N '' -f "$HOME/.ssh/id_ed25519" -C "$personal_email"

cat <<EOF >"$HOME/.ssh/config"
Host github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
EOF

cat <<EOF >"$HOME/.gitconfig"
[user]
	email = $personal_email
  signingkey = $HOME/.ssh/id_ed25519.pub
[core]
	excludesfile = $HOME/.gitignore-global
[include]
	path = $HOME/.gitconfig-shared
[includeIf "hasconfig:remote.*.url:*:anysphere/**"]
	path = $HOME/.gitconfig-work
EOF
