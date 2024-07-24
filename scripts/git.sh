#!/usr/bin/env bash

user=$(whoami)
read -p 'What is your email? ' email

# Create the ssh key
mkdir -p "$HOME/.ssh"

# Create the default global gitconfig
cat <<EOF >"$HOME/.gitconfig"
[user]
	name = Mark Skelton
	email = $email
[core]
	excludesfile = /Users/$user/.gitignore-global
[include]
	path = /Users/$user/.gitconfig-shared
[includeIf "hasconfig:remote.*.url:work:ramp/**"]
	path = /Users/$user/.gitconfig-work
EOF
