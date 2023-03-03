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

### Additional setup

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

<details>
  <summary>
    Refined GitHub
  </summary>

Refined GitHub has terrible defaults IMO, so this simple script that enables
just the features that I use.

```javascript
;[...document.querySelectorAll('input.feature-checkbox:checked')]
  .forEach(node => node.click())

const enabled = [
  'batch-mark-files-as-viewed',
  'bypass-checks',
  'clean-conversation-filters',
  'clean-conversation-headers',
  'clean-repo-tabs',
  'command-palette-navigation-shortcuts',
  'comment-fields-keyboard-shortcuts',
  'conflict-marker',
  'cross-deleted-pr-branches',
  'dim-bots',
  'download-folder-button',
  'easy-toggle-commit-messages',
  'easy-toggle-files',
  'embed-gist-inline',
  'esc-to-cancel',
  'expand-all-hidden-comments',
  'fit-textareas',
  'github-actions-indicators',
  'hidden-review-comments-indicator',
  'hide-diff-signs',
  'hide-disabled-milestone-sorter',
  'hide-inactive-deployments',
  'hide-low-quality-comments',
  'jump-to-change-requested-comment',
  'jump-to-conversation-close-event',
  'linkify-code',
  'list-prs-for-branch',
  'new-repo-disable-projects-and-wikis',
  'no-duplicate-list-update-time',
  'one-click-diff-options',
  'one-click-review-submission',
  'one-key-formatting',
  'pinned-issues-update-time',
  'pr-jump-to-first-non-viewed-file',
  'prevent-link-loss',
  'preview-hidden-comments',
  'quick-comment-edit',
  'quick-mention',
  'quick-new-issue',
  'reload-failed-proxied-images',
  'resolve-conflicts',
  'restore-file',
  'set-default-repositories-type-to-sources',
  'swap-branches-on-compare',
  'tab-to-indent',
  'vertical-front-matter',
]

enabled.forEach(feature => {
  document.querySelector(`input[name="feature:${feature}"]:not(:checked)`)
    ?.click()
})
```

</details>
