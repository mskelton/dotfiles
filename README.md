# Dotfiles

My personal settings and dotfiles.

## Installation

_If on a work device, run `export WORK=1` before the following commands._

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/git.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/brew.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/macos.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/tools.sh)"
```

After installing pre-requisites, run the following to setup the dotfiles.

```bash
git clone git@github.com:mskelton/dotfiles.git
cd dotfiles
git submodule init
git submodule update --remote
./install
```

### Additional setup

<details>
  <summary>
    Install Chrome extensions
  </summary>

- [1Password](https://chrome.google.com/webstore/detail/1password-%E2%80%93-password-mana/aeblfdkhhhdcdjpifhhbdiojplfjncoa)
- [Bookmark Sync](https://chrome.google.com/webstore/detail/bookmark-sync/eandejdimaomjfhmobeofcgljmmbgkde)
- [Dark Reader](https://chrome.google.com/webstore/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh)
- [Material Icons for GitHub](https://chrome.google.com/webstore/detail/material-icons-for-github/bggfcpfjbdkhfhfmkjpbhnkhnpjjeomc)
- [Picture-in-Picture Extension](https://chrome.google.com/webstore/detail/picture-in-picture-extens/hkgfoiooedgoejojocmhlaklaeopbecg)
- [RSS Feed Reader](https://chrome.google.com/webstore/detail/rss-feed-reader/pnjaodmkngahhkoihejjehlcdlnohgmp)
- [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi)
- [Refined GitHub](https://chrome.google.com/webstore/detail/refined-github/hlepfoohegkhhmjieoechaddaejaokhf)
- [Stylus](https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne)
- [Tampermonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo)
- [Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb)
- [uBlacklist](https://chrome.google.com/webstore/detail/ublacklist/pncfbmialoiaghdehhbnbhkkgmjanfhe)

</details>

<details>
  <summary>
    Configure Refined GitHub
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

<details>
  <summary>
    Configure uBlacklist
  </summary>

1. Navigate to the extension options
1. Where it says "Restore settings", click **Restore**
1. Upload `config/ublacklist-settings.json`

</details>

<details>
  <summary>
    Copy data from old machine
  </summary>

- Copy Quicken data files
- Copy `~/.config/fish/custom.fish`
- Copy Taskwarrior data `~/.task`
- Copy `~/.local/share/fish/fish_history`
- Copy pictures and documents

</details>
