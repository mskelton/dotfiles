# Custom binaries
set -g fish_user_paths $fish_user_paths "$HOME/.local/bin"
set -g fish_user_paths $fish_user_paths "$HOME/.local/bin-work"

# Misc
set -g fish_user_paths $fish_user_paths "$HOME/.cargo/bin"
set -g fish_user_paths $fish_user_paths "$HOME/.local/share/npm/bin"
set -g fish_user_paths $fish_user_paths "$HOME/.bun/bin"
set -g fish_user_paths $fish_user_paths "$GOPATH/bin"
set -g fish_user_paths $fish_user_paths "$fzf_base/bin"
set -g fish_user_paths $fish_user_paths "$PYENV_ROOT/bin"
set -g fish_user_paths $fish_user_paths "$HOME/flutter/bin"

# Android studio
set -g fish_user_paths $fish_user_paths "$ANDROID_HOME/tools"
set -g fish_user_paths $fish_user_paths "$ANDROID_HOME/tools/bin"
set -g fish_user_paths $fish_user_paths "$ANDROID_HOME/platform-tools"
