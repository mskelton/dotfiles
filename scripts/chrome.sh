#!/bin/bash
set -euo pipefail

# Chrome is sometimes installed early on machines under enterprise management.
# Check if it is installed, and install via brew if it is not.
if ! [ -d "/Applications/Google Chrome.app" ]; then
	/opt/homebrew/bin/brew install --cask google-chrome
fi

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

# Prompt Chrome to install these extensions (and notify user) on next boot
# https://developer.chrome.com/docs/extensions/mv3/external_extensions/#preferences
extensions=()
extensions+=(aeblfdkhhhdcdjpifhhbdiojplfjncoa) # 1Password
extensions+=(eandejdimaomjfhmobeofcgljmmbgkde) # Bookmark Sync
extensions+=(eimadpbcbfnmbkopoojfekhnkhdbieeh) # Dark Reader
extensions+=(bggfcpfjbdkhfhfmkjpbhnkhnpjjeomc) # Material Icons for GitHub
extensions+=(hkgfoiooedgoejojocmhlaklaeopbecg) # Picture-in-Picture Extension
extensions+=(pnjaodmkngahhkoihejjehlcdlnohgmp) # RSS Feed Reader
extensions+=(fmkadmapgofadopljbjfkapdkoienihi) # React Developer Tools
extensions+=(hlepfoohegkhhmjieoechaddaejaokhf) # Refined GitHub
extensions+=(nbhcbdghjpllgmfilhnhkllmkecfmpld) # User JavaScript and CSS
extensions+=(pncfbmialoiaghdehhbnbhkkgmjanfhe) # uBlacklist

extension_root="$HOME/Library/Application Support/Google/Chrome/External Extensions"
mkdir -p "$extension_root"

for i in "${extensions[@]}"; do
	extension_file="$extension_root/$i.json"

	if ! [ -f "$extension_file" ]; then
		echo '{"external_update_url": "https://clients2.google.com/service/update2/crx"}' >"$extension_root/$i.json"
	fi
done
