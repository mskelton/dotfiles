# Chromium Extensions

- [1Password](https://chrome.google.com/webstore/detail/1password-%E2%80%93-password-mana/aeblfdkhhhdcdjpifhhbdiojplfjncoa)
- [Bookmark Sync](https://chrome.google.com/webstore/detail/bookmark-sync/eandejdimaomjfhmobeofcgljmmbgkde)
- [Dark Reader](https://chrome.google.com/webstore/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh)
- [Material Icons for GitHub](https://chrome.google.com/webstore/detail/material-icons-for-github/bggfcpfjbdkhfhfmkjpbhnkhnpjjeomc)
- [Picture-in-Picture Extension](https://chrome.google.com/webstore/detail/picture-in-picture-extens/hkgfoiooedgoejojocmhlaklaeopbecg)
- [RSS Feed Reader](https://chrome.google.com/webstore/detail/rss-feed-reader/pnjaodmkngahhkoihejjehlcdlnohgmp)
- [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi)
- [Refined GitHub](https://chrome.google.com/webstore/detail/refined-github/hlepfoohegkhhmjieoechaddaejaokhf)
- [User JavaScript and CSS](https://chromewebstore.google.com/detail/user-javascript-and-css/nbhcbdghjpllgmfilhnhkllmkecfmpld?hl=en)
- [uBlacklist](https://chrome.google.com/webstore/detail/ublacklist/pncfbmialoiaghdehhbnbhkkgmjanfhe)

## Configure Refined GitHub

1. Navigate to the extension options
1. Expand the **Export options** panel and click **Import**
1. Upload `config/refined-github.json`

## Configure uBlacklist

1. Navigate to the extension options
1. Where it says "Restore settings", click **Restore**
1. Upload `config/ublacklist-settings.json`

## Configure User JavaScript and CSS

1. Navigate to the extension options
1. Click `Upload JSON`
1. Upload `config/user-js-css.json`

To update the saved settings, run the following steps:

1. Navigate to the extension options
1. Click `Download JSON`
1. Run the following command
   ```bash
   ls $HOME/Downloads/user-js-css-*.json | xargs -I {} sh -c "cat {} | jq > $HOME/dev/dotfiles/config/user-js-css.json && rm {}"
   ```
1. Commit and push changes
