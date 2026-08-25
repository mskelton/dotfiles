# History settings
setopt EXTENDED_HISTORY       # Include timestamp
setopt HIST_EXPIRE_DUPS_FIRST # Trim dupes first if history is full
setopt HIST_FIND_NO_DUPS      # Do not display previously found command
setopt HIST_IGNORE_SPACE      # Do not save if line starts with space
setopt HIST_NO_STORE          # Do not save history commands
setopt HIST_REDUCE_BLANKS     # Strip superfluous blanks
setopt INC_APPEND_HISTORY     # Don’t wait for shell to exit to save history lines

if [[ -z "$CURSOR_AGENT" && -z "$CLAUDECODE" && -z "$CODEX_CI" ]]; then
  # Enable completion
  fpath=($HOME/.zsh/completions $fpath)
  autoload -U compinit
  compinit

  # Use Emacs keybindings
  set -o emacs

  # Word navigation keybindings
  bindkey '^B' backward-word
  bindkey '^F' forward-word

  # Trim ~/dev/ off the prompt if present
  _prompt_path() {
    if [[ $PWD == $HOME/dev/* ]]; then
      print -r -- "${PWD#$HOME/dev/}"
    else
      print -r -- "%~"
    fi
  }

  # Git branch for prompt
  _prompt_git() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [[ -n "$branch" ]] && print -r -- " %F{magenta}${branch}%f"
  }

  # Basic prompt
  setopt prompt_subst
  PROMPT='$(_prompt_path)$(_prompt_git) %F{%(?.green.red)}❯%f '
fi

# Setup Homebrew env
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

if [[ -z "$CURSOR_AGENT" && -z "$CLAUDECODE" && -z "$CODEX_CI" ]]; then
  # Setup fzf
  source <(fzf --zsh)
fi

# Setup direnv
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

# Setup fnm
eval "$(fnm env --use-on-cd --log-level error --shell zsh)"

# Setup rustup
[ -f $HOME/.cargo/env ] && . $HOME/.cargo/env

# Shell aliases
source $HOME/.alias

# Extra configs
[ -f $HOME/.zshcustom ] && source $HOME/.zshcustom

# Work or home config
if [ -f "$HOME/.work" ]; then
  source $HOME/.zshwork
else
  source $HOME/.zshhome
fi

# Path for custom binaries and tools
# Each line prepends; later entries take precedence over earlier ones
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$HOME/Library/Application Support/fnm:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/.local/share/npm/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

if [[ -z "$CURSOR_AGENT" && -z "$CLAUDECODE" && -z "$CODEX_CI" ]]; then
  # Plugins
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

  # bun completions
  [ -s "/Users/mskelton/.bun/_bun" ] && source "/Users/mskelton/.bun/_bun"
fi
