# Chromium

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
