# Apps

Below are configure steps for applications. This is typically only needed to be
done when setting up new _accounts_ which only happens when changing jobs.

# Shortcuts

- [Rewind](https://www.icloud.com/shortcuts/16c6dd6d3d7f492f977a75aad724f185)
- [Fast Forward](https://www.icloud.com/shortcuts/b6dd59539ee342319fd542bb6e2197b2)
- [Skip Forward](https://www.icloud.com/shortcuts/405d85c171c846a8bcdc523e2128d772)

## Chrome

### Configure Refined GitHub

1. Navigate to the extension options
1. Expand the **Export options** panel and click **Import**
1. Upload `config/refined-github.json`

### Configure uBlacklist

1. Navigate to the extension options
1. Where it says "Restore settings", click **Restore**
1. Upload `config/ublacklist-settings.json`

### Configure User JavaScript and CSS

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

## Shottr

- Set "Screenshots folder" to "~/Downloads"
- Set "Fullscreen screenshot" to "cmd+shift+3"
- Set "Area screenshot" to "cmd+shift+4"
- Set "Active window screenshot" to "cmd+shift+2"
- Set "Instant Text/QR recognition" to "cmd+shift+1"
- Hide menu bar icon

## ChatGPT

- **App->Show ChatGPT** - Only in Dock
- **App->Correct Spelling Automatically** - Off
- **App->Launch At Login** - Off
- **Chat Bar->Keyboard Shortcut** - <kbd>⌥Space</kbd>

## Hammerspoon

Enable permission to Bluetooth in macOS system settings for Hammerspoon. This is
required to make the Bluetooth restart menu item work properly.

## Slack

- **Notifications->Show a badge on Slack's icon to indicate new activity** - Off
- **Home->Show profile photos next to DMs** - Off
- **Messages & Media->Theme** - Compact
- **Messages & Media->Names** - Just display names
- **Accessibility->Keyboard** - Edit your last message

## Todoist

- **General->Time zone** - US/Central
- **General->Task complete tone** - Off
- **Advanced->Show Todoist in menu bar** - Off
- **Advanced->Launch at startup** - On
- **Advanced->Quick Add Task** - <kbd>⌥T</kbd>
- **Theme->Theme->Auto Dark Mode** - Off
- **Productivity->Todoist Karma** - Off
- **Productivity->Goals** - 0
- **Notifications->Daily digest** - Off

## Zoom

### App settings

- **General->Appearance** - Dark mode
- **Video->HD** - On
- **Video->Mirror my video** - Off
- **Video->Stop my video when joining** - On

### Web settings

- **Meeting->Screen sharing->Who can share?** - All Participants
- **Meeting->Screen sharing->Who can start sharing when someone else is
  sharing?** - All Participants
