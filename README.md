# Dotfiles

My personal settings and dotfiles.

## Installation

_If on a work device, run `touch ~/.work` before the following commands._

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/git.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/brew.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/macos.sh)"
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
    Setup tools
  </summary>

Before installing tools, install [Node.js](https://nodejs.org/en/), then run the
following commands.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/tools.sh)"
```

</details>

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
    Install Arc boosts
  </summary>

- [npm](https://arc.net/boost/0E7D0C8B-4F81-4078-B356-15216038A7F4)
- [Growthbook](https://arc.net/boost/B651E339-8850-418C-B3F4-B0B27E6C4438)

</details>

<details>
  <summary>
    Configure Refined GitHub
  </summary>

1. Navigate to the extension options
1. Expand the **Export options** panel and click **Import**
1. Upload `config/refined-github.json`

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

<details>
  <summary>
    Setup TaskWarrior
  </summary>

```fish
set secret (read -P "Encryption Secret: ")
set client_id (read -P "Client ID: ")
set origin (read -P "Origin: ")

echo -e 'include ~/.config/task/config
news.version=2.6.0
sync.encryption_secret='$secret'
sync.server.client_id='$client_id'
sync.server.origin='$origin'
context=home' > ~/.taskrc
```

To prevent duplicate creation of recurring tasks, run the following command to
set the `recurrence` setting to `on` for the home machine and `off` for the work
machine.

```bash
task config recurrence on
```

</details>

<details>
  <summary>
    Setup shortcuts
  </summary>

- [Focus](https://www.icloud.com/shortcuts/65840b635c7d4073b4319c1ddabcdce5)
- [Media](https://www.icloud.com/shortcuts/ebf0580126fb433f850db9e1bd35e4bc)

</details>
