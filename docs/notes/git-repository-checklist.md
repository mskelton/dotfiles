# Git repository checklist

Use this optional list before moving or archiving a local repository.

## Working tree

- Run `git status --short`.
- Check for staged changes.
- Check for unstaged changes.
- Check for untracked files.
- Check for ignored files that contain local data.

## Branches

- Identify the current branch.
- List branches without an upstream.
- Look for branches ahead of their remotes.
- Look for branches already merged.
- Confirm detached worktrees are not in use.

## Remotes

- Print configured remotes.
- Confirm fetch URLs are still valid.
- Confirm push URLs target the intended account.
- Fetch remote references with pruning.
- Review stale remote-tracking branches.

## Useful commands

```sh
git status --short --branch
git remote -v
git branch -vv
git worktree list
git log --oneline --decorate -10
```

## Archive decision

A repository is ready to archive only after valuable work is committed, pushed,
or copied to an intentional backup location.
