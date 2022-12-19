#!/usr/bin/env bash

# Enable dark theme
defaults write -g AppleInterfaceStyle -string "Dark"

# Disable rubber band scrolling
defaults write -g NSScrollViewRubberbanding -int 0

# Scrollbars only when scrolling. For the trackpad, this is true but my mouse
# doesn't hide scrollbars automatically.
defaults write -g AppleShowScrollBars -string "WhenScrolling"

# Make the Dock icons a more reasonable size
defaults write com.apple.dock tilesize -int 45

# Enable key repeat
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

# Use all F1, F2 as standard keys
defaults write -g com.apple.keyboard.fnState -bool true

# Remove downloads and recent apps from the dock
defaults write com.apple.Dock show-recents -int 0
defaults write com.apple.Dock static-others '()'

# Disable disk not ejected properly notification. This notification is very
# annoying when flashing firmware to the Advantage 360 keyboard.
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.DiskArbitration.diskarbitrationd.plist DADisableEjectNotification -bool true

# Install Docker completion
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish -o ~/.config/fish/completions/docker.fish
