#!/usr/bin/env bash

user=$(whoami)
mkdir -p "$HOME/.ssh"

personal_email="mdskelton99@gmail.com"
work_email="mskelton@ramp.com"

if [[ -f "$HOME/.work" ]]; then
  ssh-keygen -t ed25519 -N '' -f "$HOME/.ssh/id_ed25519_home" -C "$personal_email"
  ssh-keygen -t ed25519 -N '' -f "$HOME/.ssh/id_ed25519_sk_work" -C "$work_email"

  cat <<EOF >"$HOME/.ssh/config"
Host home personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_home
  IdentitiesOnly yes

Host github.com work
  HostName github.com
  User git
  IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  IdentityFile ~/.ssh/id_ed25519_work
  IdentitiesOnly yes
EOF
else
  ssh-keygen -t ed25519 -N '' -f "$HOME/.ssh/id_ed25519_home" -C "$personal_email"

  cat <<EOF >"$HOME/.ssh/config"
Host github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_home
  IdentitiesOnly yes
EOF
fi

cat <<EOF >"$HOME/.gitconfig"
[user]
  signingkey = ~/.ssh/id_ed25519_home.pub
[core]
	excludesfile = /Users/$user/.gitignore-global
[include]
	path = /Users/$user/.gitconfig-shared
[includeIf "hasconfig:remote.*.url:*:ramp/**"]
	path = /Users/$user/.gitconfig-work
EOF
