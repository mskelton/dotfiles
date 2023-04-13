#!/usr/bin/env bash

# Enable dark theme
defaults write -g AppleInterfaceStyle -string 'Dark'

# Set screenshot location to ~/Downloads
defaults write com.apple.screencapture location -string '~/Downloads'

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

# Disable screenshot shortcuts to allow Shottr to use them
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 28 $disable_shortcut
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 30 $disable_shortcut

# Disable input source switching, it conflicts with Neovim autocompletion
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 $disable_shortcut
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 $disable_shortcut

# Disable spotlight search
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 $disable_shortcut

# Disable Switch to Desktop 1, it conflicts with Arc shortcuts
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 118 $disable_shortcut

# Add Option+D for toggling do not disturb
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 175 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>100</integer>
        <integer>2</integer>
        <integer>524288</integer>
      </array>
    </dict>
  </dict>
"

################################################################################
### APP SHORTCUTS ##############################################################
################################################################################
#  @   Command
#  ~   Option
#  $   Shift
#  ^   Control

# Figma
defaults write com.figma.Desktop NSUserKeyEquivalents -dict-add "Show/Hide UI" -string '@$u'
defaults write com.figma.Desktop NSUserKeyEquivalents -dict-add "Copy as SVG" -string '@$s'
