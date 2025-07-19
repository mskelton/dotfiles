#!/usr/bin/env bash

user=$(whoami)
mkdir -p "$HOME/.ssh"

personal_email="mdskelton99@gmail.com"
work_email="mskelton@ramp.com"

home_keyfile="$HOME/.ssh/id_ed25519_home"
work_keyfile="$HOME/.ssh/id_ed25519_sk_work"
ssh-keygen -t ed25519 -N '' -f "$home_keyfile" -C "$personal_email"

if [[ -f "$HOME/.work" ]]; then
  ssh-keygen -t ed25519 -N '' -f "$work_keyfile" -C "$work_email"

  cat <<EOF >"$HOME/.ssh/config"
Host home personal
  HostName github.com
  User git
  IdentityFile $home_keyfile
  IdentitiesOnly yes

Host github.com work
  HostName github.com
  User git
  IdentityAgent "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  IdentityFile $work_keyfile
  IdentitiesOnly yes
EOF
else
  cat <<EOF >"$HOME/.ssh/config"
Host github.com
  User git
  IdentityFile $home_keyfile
  IdentitiesOnly yes
EOF
fi

cat <<EOF >"$HOME/.gitconfig"
[user]
  signingkey = $home_keyfile.pub
[core]
	excludesfile = /Users/$user/.gitignore-global
[include]
	path = /Users/$user/.gitconfig-shared
[includeIf "hasconfig:remote.*.url:*:ramp/**"]
	path = /Users/$user/.gitconfig-work
EOF
