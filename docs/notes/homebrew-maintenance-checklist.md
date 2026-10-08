# Homebrew maintenance checklist

Use this optional checklist when package-manager behavior appears inconsistent.

## Basic health

- Confirm `brew` resolves to the expected binary.
- Run `brew doctor` and read each warning.
- Check the configured Homebrew prefix.
- Review pinned formulae.
- Review disabled automatic updates.

## Installed software

- List outdated formulae.
- List outdated casks.
- Check leaves before removing dependencies.
- Review taps that are no longer needed.
- Check whether renamed formulae need migration.

## Cleanup

- Preview cleanup before deleting caches.
- Keep downloads needed for offline work.
- Remove broken symlinks carefully.
- Avoid cleanup during an active install.
- Re-run diagnostics after maintenance.

## Useful commands

```sh
command -v brew
brew --prefix
brew doctor
brew outdated
brew leaves
brew tap
```

## Caution

Do not use broad force flags merely to silence a diagnostic; determine whether
the warning reflects intentional local configuration first.
