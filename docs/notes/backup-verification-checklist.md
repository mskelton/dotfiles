# Backup verification checklist

A backup is useful only when its contents can be located and restored.

## Scope

- Identify documents that exist only locally.
- Include exported application settings where useful.
- Include shell history only when intentionally retained.
- Exclude reproducible caches and dependencies.
- Record repositories with unpushed commits separately.

## Destination

- Confirm the destination has enough free space.
- Confirm encryption is enabled where appropriate.
- Confirm the destination is not the source disk.
- Label the backup with a clear date.
- Avoid overwriting the previous known-good backup.

## Verification

- Compare expected and actual file counts.
- Open a sample of copied documents.
- Verify a sample of nested directories.
- Check that hidden configuration files were included.
- Confirm symlinks behaved as intended.

## Restore sample

1. Choose a small representative file.
2. Restore it to a temporary directory.
3. Compare it with the source.
4. Open the restored copy.
5. Remove the temporary copy.
6. Record the verification result.

## Finish

Disconnect removable backup media cleanly and keep the verification note with the
migration checklist, not only on the machine being replaced.
