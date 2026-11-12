# Browser extension checklist

Use this note when rebuilding a browser profile from saved configuration.

## Inventory

- Install only extensions that are still needed.
- Verify the publisher for each extension.
- Remove duplicate functionality.
- Review extensions with broad site access.
- Note extensions that require imported settings.

## Permissions

- Prefer access on click when practical.
- Restrict access to required sites.
- Review incognito access separately.
- Disable file URL access unless needed.
- Recheck permissions after major updates.

## Configuration

- Import tracked configuration files deliberately.
- Confirm imports target the expected profile.
- Keep downloaded exports out of the repository.
- Normalize JSON before comparing exports.
- Inspect diffs for tokens or personal data.

## Verification

1. Restart the browser.
2. Open a normal browsing window.
3. Test one extension at a time.
4. Confirm keyboard shortcuts.
5. Confirm blocked sites remain accessible when expected.
6. Remove temporary export files.

## Reminder

A browser sync account can restore stale settings, so verify the resulting state
rather than assuming the import was authoritative.
