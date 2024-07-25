#!/usr/bin/env bash

user=$(whoami)

# Create the ssh key
mkdir -p "$HOME/.ssh"

# Create the default global gitconfig
cat <<EOF >"$HOME/.gitconfig"
[user]
  signingkey = /Users/$user/.ssh/id_ed25519_personal.pub
[core]
	excludesfile = /Users/$user/.gitignore-global
[include]
	path = /Users/$user/.gitconfig-shared
[includeIf "hasconfig:remote.*.url:work:ramp/**"]
	path = /Users/$user/.gitconfig-work
EOF
