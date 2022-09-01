# Fix GPG inappropriate ioctl for device error
export GPG_TTY=$(tty)

# Setup rustup
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi
