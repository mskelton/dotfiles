# Shell session checklist

A short, optional checklist for diagnosing a fresh terminal session.

## Identity

- Confirm the expected user with `whoami`.
- Confirm the home directory with `printf '%s\n' "$HOME"`.
- Check the active shell with `printf '%s\n' "$SHELL"`.
- Inspect the current directory with `pwd`.
- Verify the hostname with `hostname`.

## Search path

- Print path entries one per line.
- Look for duplicate path entries.
- Confirm user binaries precede system fallbacks.
- Verify package-manager binaries are present.
- Check that stale application paths are absent.

## Startup files

- Confirm `.zshenv` is readable.
- Confirm `.zshrc` is linked correctly.
- Check whether work-specific configuration is expected.
- Look for startup warnings in a clean shell.
- Compare interactive and login shell behavior.

## Useful commands

```sh
printf '%s\n' "$PATH" | tr ':' '\n'
command -v git
command -v node
command -v farm
zsh -lic 'echo shell-ready'
```

## Finish

Record unexpected output before changing configuration so the original state can
be reproduced later.
