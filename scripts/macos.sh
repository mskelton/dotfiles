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

# Disable disk not ejected properly notification. This notification is very
# annoying when flashing firmware to the Advantage 360 keyboard.
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.DiskArbitration.diskarbitrationd DADisableEjectNotification -bool true

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

# Disable natural scrolling
defaults write -g com.apple.swipescrolldirection -int 0

# Disable rubber band scrolling
defaults write -g NSScrollViewRubberbanding -int 0

# Scrollbars only when scrolling. For the trackpad, this is true but my mouse
# doesn't hide scrollbars automatically.
defaults write -g AppleShowScrollBars -string "WhenScrolling"

# Adjust trackpad tracking speed
defaults write -g com.apple.trackpad.scaling -float 0.875

# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1

################################################################################
### KEYBOARD ###################################################################
################################################################################

# Enable key repeat
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

# Use all F1, F2 as standard keys
defaults write -g com.apple.keyboard.fnState -bool true

# Disable globe key
defaults write com.apple.HIToolbox AppleFnUsageType -int 0

# Disable smart quotes and dashes
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

# Disable add period with double-space
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable default text replacement items
defaults write -g NSUserDictionaryReplacementItems '()'

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

################################################################################
### SHORTCUTS ##################################################################
################################################################################

disable_shortcut="<dict><key>enabled</key><false/></dict>"

enabled_shortcuts=(
  27  # Move focus to next window
  52  # Dock hiding
  59  # Toggle voice over
  163 # Toggle do not disturb
  183 # Brightness down
  184 # Brightness up
)

shortcuts_output=$(defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys)
shortcut_ids=$(echo "$shortcuts_output" | grep -E '^[[:space:]]*[0-9]+[[:space:]]*=' | sed 's/^[[:space:]]*\([0-9]*\).*/\1/')

for id in $shortcut_ids; do
  if [[ " ${enabled_shortcuts[@]} " =~ " ${id} " ]]; then
    continue
  fi

  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$id" "$disable_shortcut"
done

################################################################################
### APP SHORTCUTS ##############################################################
################################################################################
#  @   Command
#  ~   Option
#  $   Shift
#  ^   Control

# Figma
defaults write com.figma.Desktop NSUserKeyEquivalents -dict-add 'Show/Hide UI' -string '@$u'
defaults write com.figma.Desktop NSUserKeyEquivalents -dict-add 'Copy as SVG' -string '@$s'

# Chrome
for app in "Chrome" "Chrome.canary" "Chrome.beta" "Chrome.dev"; do
  defaults write "com.google.$app" NSUserKeyEquivalents -dict-add 'Select Next Tab' -string '@e'
  defaults write "com.google.$app" NSUserKeyEquivalents -dict-add 'Select Previous Tab' -string '@$e'
  defaults write "com.google.$app" NSUserKeyEquivalents -dict-add 'Close Other Tabs' -string '@$k'
done

killall cfprefsd
