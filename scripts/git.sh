#!/usr/bin/env bash

user=$(whoami)

# Create the ssh key
mkdir -p "$HOME/.ssh"

read -rp "Enter your personal email: " personal_email
read -rp "Enter your work email: " work_email

if [[ -f "$HOME/.work" ]]; then
	keyfile=id_ed25519_sk_personal
	ssh-keygen -t ed25519 -N '' -f "$HOME/.ssh/$keyfile" -C "$personal_email"
	ssh-keygen -t ed25519 -N '' -f "$HOME/.ssh/id_ed25519_sk_work" -C "$work_email"
else
	keyfile=id_ed25519_sk
	ssh-keygen -t ed25519 -N '' -f "$HOME/.ssh/$keyfile" -C "$work_email"
fi

# Create the default global gitconfig
cat <<EOF >"$HOME/.gitconfig"
[user]
  signingkey = /Users/$user/.ssh/$keyfile.pub
[core]
	excludesfile = /Users/$user/.gitignore-global
[include]
	path = /Users/$user/.gitconfig-shared
[includeIf "hasconfig:remote.*.url:work:ramp/**"]
	path = /Users/$user/.gitconfig-work
EOF
