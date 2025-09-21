#!/bin/bash
# VS Code Extensions Install Script
# Usage: curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/vscode-extensions.sh | bash

set -e

echo "📦 Managing VS Code extensions..."

extensions_file="$HOME/dev/dotfiles/config/vscode-extensions.json"
extensions_url="https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/config/vscode-extensions.json"

# Download extensions list or get from local file
if [ -f "$extensions_file" ]; then
    extensions=$(jq -r '.extensions[]' "$extensions_file")
else
    extensions=$(curl -fsSL "$extensions_url" | jq -r '.extensions[]')
fi

install_extensions() {
    local editor_name="$1"
    local editor_cmd="$2"

    if command -v "$editor_cmd" >/dev/null 2>&1; then
        echo "🔧 Checking extensions for $editor_name..."

        # Get currently installed extensions
        installed_exts=$("$editor_cmd" --list-extensions)

        while IFS= read -r extension; do
            if [[ -n "$extension" ]]; then
                if ! echo "$installed_exts" | grep -q "^$extension$"; then
                    echo "  ➕ Installing $extension..."
                    "$editor_cmd" --install-extension "$extension"
                fi
            fi
        done <<<"$extensions"
    else
        echo "⚠️ $editor_cmd not found in PATH"
    fi
}

# install_extensions "VS Code" "code"
install_extensions "Cursor" "cursor"

echo "✅ Extension management complete!"
