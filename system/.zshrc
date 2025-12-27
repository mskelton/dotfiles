# History settings
setopt EXTENDED_HISTORY       # Include timestamp
setopt HIST_EXPIRE_DUPS_FIRST # Trim dupes first if history is full
setopt HIST_FIND_NO_DUPS      # Do not display previously found command
setopt HIST_IGNORE_SPACE      # Do not save if line starts with space
setopt HIST_NO_STORE          # Do not save history commands
setopt HIST_REDUCE_BLANKS     # Strip superfluous blanks
setopt INC_APPEND_HISTORY     # Don’t wait for shell to exit to save history lines

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

# Basic prompt
setopt prompt_subst
PROMPT='$(_prompt_path) %F{%(?.green.red)}❯%f '

# Setup Homebrew env
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# Setup fzf
source <(fzf --zsh)

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
if [[ -f $HOME/.work ]]; then
  source $HOME/.zshwork
else
  source $HOME/.zshhome
fi

# Path for custom binaries and tools
export PATH="$HOME/.local/bin""\
:$HOME/.cargo/bin""\
:$HOME/.local/share/npm/bin""\
:$HOME/.bun/bin""\
:$HOME/go/bin""\
:$HOME/Library/Application Support/fnm""\
:$ANDROID_HOME/emulator""\
:$ANDROID_HOME/platform-tools""\
:/opt/homebrew/bin""\
:$PATH"

# Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# bun completions
[ -s "/Users/mskelton/.bun/_bun" ] && source "/Users/mskelton/.bun/_bun"

# pnpm
export PNPM_HOME="/Users/mskelton/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
