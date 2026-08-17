#!/usr/bin/env bash

# Use Touch ID for sudo
sed -e 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local

# Disable spotlight indexing
sudo mdutil -a -i off

# Enable dark theme
defaults write -g AppleInterfaceStyle -string 'Dark'

# Set screenshot location to ~/Downloads
defaults write com.apple.screencapture location -string "$HOME/Downloads"

# Disable screenshot thumbnail after capture
defaults write com.apple.screencapture show-thumbnail -bool false

################################################################################
### FINDER #####################################################################
################################################################################

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Set column view as default
defaults write com.apple.finder FXPreferredViewStyle -string clmv

# Show folders on top in finder
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Search the current folder
defaults write com.apple.finder FXDefaultSearchScope -string SCcf

# Empty trash after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Disable delay when hovering toolbar title
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

killall Finder

################################################################################
### DOCK #######################################################################
################################################################################

# Make the Dock icons a more reasonable size
defaults write com.apple.dock tilesize -int 45

# Remove downloads and recent apps from the dock
defaults write com.apple.Dock show-recents -int 0
defaults write com.apple.Dock static-others '()'

# Faster auto-hide
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.25

killall Dock

################################################################################
### TRACKPAD ###################################################################
################################################################################

# Disable rubber band scrolling
defaults write -g NSScrollViewRubberbanding -int 0

# Scrollbars only when scrolling. For the trackpad, this is true but my mouse
# doesn't hide scrollbars automatically.
defaults write -g AppleShowScrollBars -string "WhenScrolling"

# Adjust trackpad tracking speed
defaults write -g com.apple.trackpad.scaling -float 0.875

# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1

killall SystemUIServer

################################################################################
### KEYBOARD ###################################################################
################################################################################

# Enable key repeat
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

# Disable globe key
defaults write com.apple.HIToolbox AppleFnUsageType -int 0

# Disable smart quotes and dashes
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

# Disable add period with double-space
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable default text replacement items
defaults write -g NSUserDictionaryReplacementItems '()'

killall SystemUIServer

################################################################################
### MENU BAR ###################################################################
################################################################################

# Remove Spotlight
defaults -currentHost write com.apple.Spotlight MenuItemHidden -bool true

# Show battery percentage
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

# Show bluetooth always
defaults -currentHost write com.apple.controlcenter Bluetooth -int 2

# Show focus always
defaults -currentHost write com.apple.controlcenter FocusModes -int 18

# Show sound always
defaults -currentHost write com.apple.controlcenter Sound -int 16

killall SystemUIServer

################################################################################
### CHROME #####################################################################
################################################################################

# Do not prompt to collect passwords
defaults write com.google.Chrome.plist PasswordManagerEnabled -bool false

# Do not attempt to autofill credit cards
defaults write com.google.Chrome.plist AutofillCreditCardEnabled -bool false

# Default to https connections
defaults write com.google.Chrome.plist HttpsOnlyMode force_enabled

# Clean up UI clutter
defaults write com.google.Chrome.plist SideSearchEnabled -bool false
defaults write com.google.Chrome.plist ShowHomeButton -bool false
defaults write com.google.Chrome.plist ShowFullUrlsInAddressBar -bool true
