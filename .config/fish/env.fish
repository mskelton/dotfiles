# FZF defaults
set -x FZF_DEFAULT_OPTS "--reverse --info=inline"

# Hide Starship command timeout warnings
set -x STARSHIP_LOG error

# Environment variables
set -x EDITOR nvim
set -x GOPATH "$HOME/go"
set -x BUN_INSTALL "$HOME/.bun"
set -x HOMEBREW_NO_ENV_HINTS true
set -x GH_NO_UPDATE_NOTIFIER true
set -x PYENV_ROOT "$HOME/.pyenv"
set -x ANDROID_HOME "$HOME/Library/Android/sdk"
set -x CLOUDSDK_PYTHON "python3.9"
set -x TURBO_NO_UPDATE_NOTIFIER 1
set -x PAGER less
