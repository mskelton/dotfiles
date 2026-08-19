---
name: gh-stack
description:
  Create, submit, sync, rebase, and merge stacked pull requests using the native
  `gh stack` CLI extension (github/gh-stack). Use whenever splitting work into a
  chain of dependent PRs, or managing/syncing/restacking/merging an existing PR
  stack. This is the preferred stacking tool over Graphite (`gt`) going forward.
---

# gh-stack

Native GitHub stacked pull requests via the `gh stack` extension
(`github/gh-stack`, public preview). Each PR in a stack targets the branch below
it, forming a chain that lands on trunk. Prefer this over Graphite (`gt`) for
new stacking work.

## Running from Claude Code (non-interactive)

The Bash tool is not a TTY. Several `gh stack` commands have interactive modes
that must be avoided or bypassed with flags:

- `gh stack submit` — opens an editor TUI in a real terminal; in a
  non-interactive shell it auto-skips the editor and uses generated titles (same
  effect as passing `--auto`). Use `--open` to mark PRs ready for review instead
  of draft.
- `gh stack merge` — prompts interactively in a TTY; in a non-interactive shell
  it merges the whole stack without prompting. Pass `--yes` explicitly to be
  safe, and `--squash`/`--rebase`/`--merge` to pick a method rather than relying
  on "last-used".
- `gh stack checkout` with **no argument** opens an interactive picker — always
  pass a stack number, PR number, PR URL, or branch name.
- `gh stack modify` is a full TUI for restructuring a stack — do not run it from
  Claude Code; ask the user to run it themselves in their own terminal.
- Use `gh stack view --short` or `--json` instead of the default interactive
  view.

## Creating a new stack

```bash
# Start a stack targeting the default branch, layer by layer:
gh stack init my-feature-part1
# ...make changes, then...
git add -A && git commit -m "..."
gh stack add my-feature-part2
# ...more changes...
git add -A && git commit -m "..."
gh stack add my-feature-part3
```

`gh stack add -Am "message" branch-name` stages all changes, commits, and
creates the next branch in one step.

To create a multi-layer stack from branches that don't exist yet, in one shot:

```bash
gh stack init layer-a layer-b layer-c
```

To adopt existing branches (bottom to top) into a stack:

```bash
gh stack init existing-branch-1 existing-branch-2
```

Use `--base <branch>` on `init` if trunk isn't the repo's default branch.

## Submitting (push + create/update PRs)

```bash
gh stack submit --auto          # draft PRs, auto-generated titles
gh stack submit --auto --open   # ready-for-review PRs instead of draft
```

This pushes every branch, creates PRs for new branches with correct base
chaining, updates base branches for existing PRs, and creates/updates the stack
object on GitHub.

## Turning already-open PRs into a stack

If branches/PRs already exist (e.g. created without gh-stack) and just need
linking:

```bash
gh stack link branch-a branch-b branch-c   # bottom to top
gh stack link 41 42 43                     # by PR number
gh stack link 7 48 new-branch              # append to existing stack #7
```

## Viewing

```bash
gh stack view --short
gh stack view --json
```

Status icons: `✓` merged, `◎` queued, `○` open, `⚠` needs rebase.

## Keeping in sync

```bash
gh stack sync           # fetch, reconcile, rebase, push, sync PR state
gh stack sync --prune   # also delete local branches for merged PRs
```

Run this after trunk moves or after the stack changes on GitHub (e.g. a teammate
added a PR to it). If sync hits a rebase conflict, it restores all branches and
tells you to run `gh stack rebase`.

## Rebasing / conflict resolution

```bash
gh stack rebase              # cascading rebase of the whole stack
gh stack rebase --continue   # after resolving conflicts
gh stack rebase --abort      # restore all branches to pre-rebase state
```

## Navigating

```bash
gh stack top / bottom / trunk / up / down
gh stack checkout <stack-number|pr-number|pr-url|branch>
```

## Merging

```bash
gh stack merge --yes --squash    # merge whole stack, squash
gh stack merge 42 --yes --squash # merge everything up to and including PR 42
```

Atomic: if any PR in the range can't merge, none are. Respects merge queues
automatically. Bypassing branch protection isn't supported for stacks.

## Removing a stack

```bash
gh stack unstack           # unstack current stack, locally + on GitHub
gh stack unstack --local   # local tracking only, leave GitHub stack intact
```

## Notes

- Requires `gh` >= 2.90.0 and git >= 2.20 (already satisfied in this
  environment).
- `gh stack merge` will not bypass required reviews/status checks — failures
  surface from GitHub's own branch protection evaluation at merge time.
