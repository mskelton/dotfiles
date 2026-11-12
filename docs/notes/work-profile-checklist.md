# Work profile checklist

This optional checklist separates work-only setup from personal configuration.

## Marker

- Confirm whether `~/.work` should exist.
- Create the marker only on managed work devices.
- Remove stale markers from personal devices.
- Check scripts before assuming marker behavior.
- Keep the marker free of secrets.

## Accounts

- Confirm the active GitHub account.
- Confirm work email is used for work repositories.
- Confirm signing keys match the intended account.
- Confirm package registries use scoped credentials.
- Confirm cloud CLIs target non-production defaults.

## Configuration

- Link work-specific files only when required.
- Keep employer-specific values out of shared files.
- Avoid copying managed certificates between devices.
- Review VPN and proxy settings.
- Document manual setup outside secret storage.

## Separation checks

- Open a personal repository and inspect Git identity.
- Open a work repository and inspect Git identity.
- Test SSH aliases for both account types.
- Check editor profiles and extensions.
- Confirm browser profiles are visibly distinct.

## Finish

Treat device-management policy as authoritative when it conflicts with an
optional convenience described in these dotfiles.
