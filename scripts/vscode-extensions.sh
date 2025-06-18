#!/bin/bash
# VS Code Extensions Install Script
# Usage: curl -fsSL https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/scripts/vscode-extensions.sh | bash

set -e

echo "📦 Installing VS Code extensions..."

# Download extensions list
extensions_url="https://raw.githubusercontent.com/mskelton/dotfiles/HEAD/config/vscode-extensions.json"
extensions=$(curl -fsSL "$extensions_url" | jq -r '.extensions[]')

install_extensions() {
    local editor_name="$1"
    local editor_cmd="$2"

    if command -v "$editor_cmd" >/dev/null 2>&1; then
        echo "🔧 Installing extensions for $editor_name..."

        while IFS= read -r extension; do
            if [[ -n "$extension" ]]; then
                echo "  Installing $extension..."
                "$editor_cmd" --install-extension "$extension" --force
            fi
        done <<<"$extensions"
    else
        echo "⚠️ $editor_cmd not found in PATH"
    fi
}

install_extensions "VS Code" "code"
install_extensions "Cursor" "cursor"

echo "✅ Extension installation complete!"
