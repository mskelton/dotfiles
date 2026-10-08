# SSH key checklist

This note provides a non-secret checklist for reviewing local SSH setup.

## Files

- Confirm private keys are not group-readable.
- Confirm public keys have matching private keys.
- Confirm obsolete public keys are labeled clearly.
- Check whether hardware-backed keys require middleware.
- Never copy private key contents into issue reports.

## Agent

- Check whether an SSH agent is running.
- List loaded key fingerprints.
- Remove keys that should not be active.
- Load only the identity needed for the current account.
- Confirm agent forwarding is disabled unless required.

## Hosts

- Review aliases in `~/.ssh/config`.
- Confirm each alias uses the intended user.
- Confirm identity files are scoped to hosts.
- Prefer explicit host matching over broad wildcards.
- Review stale known-host entries carefully.

## Useful commands

```sh
ssh-add -l
ssh -G github.com | grep '^identityfile '
ssh -T git@github.com
find ~/.ssh -maxdepth 1 -type f -name '*.pub' -print
```

## Safety

Share fingerprints and public keys only when needed; private keys and security-key
recovery material must remain outside the repository.
