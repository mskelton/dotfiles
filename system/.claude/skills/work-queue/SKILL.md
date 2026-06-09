---
name: work-queue
description:
  Run one iteration of a feature work-queue document — pick the next unchecked
  item, implement it end-to-end, commit it as a stacked branch via the graphite
  skill, submit the stack as draft PRs with `gt submit --stack --draft`, then
  mark it done.
user-invocable: true
disable-model-invocation: true
---

# Work Queue

Implement **one** item from a work-queue document, commit it as a **stacked
branch**, then check it off. Designed to be the body of a `/loop` so a queue
gets ground down one-branch-at-a-time, but works fine as a one-shot too. After
each branch, push and open/update **draft** PRs with
`gt submit --stack --draft`.

## Input

A path to a markdown work-queue document is passed as the argument (e.g.
`/work-queue ~/Documents/roadmap.md`). If no path is given, ask the user which
document to use — do not guess.

## The document's own rules win

The document may contain its own `## Rules`, `## Conventions`, or
`## Instructions` section (and may name the work section, the parked section,
conventions, test commands, where the file lives, whether to commit it, etc.).
**When such a section exists, it is authoritative — follow it exactly.**
Everything below is the default behavior for documents that don't specify.

## One iteration

1. **Read the document** at the given path.

2. **Pick the next item.** Look only in the active work section — the document's
   named work section if it specifies one, otherwise the first checklist under a
   heading like `## Features`, `## Queue`, `## Todo`, or `## Tasks`. Within it,
   take the **first `[ ]` checkbox that has a real description.**

   - **Ignore parked sections** — any heading containing words like _undecided,
     wait, parked, backlog, icebox, later, deferred, ideas, someday_. Never pull
     from those.
   - **Ignore empty/placeholder checkboxes** (a bare `- [ ]` with no text).

3. **Stop if empty.** If there is no ready (described, unchecked) item, report
   "queue empty" and **end** — when running inside a `/loop`, do not schedule
   another iteration.

4. **Implement only that one item, end-to-end.** Do not bundle multiple items
   into one branch.

   - Honor the repo's own conventions (`AGENTS.md` / `CLAUDE.md`,
     component/design-system rules, etc.) and the document's rules.
   - Add tests scoped to what changed. Run the project's typecheck, lint, and
     the affected test file(s) — fix what you break before committing.
   - If the repo uses a changelog/changeset workflow, add an entry.

5. **Commit a stacked branch** using the /graphite skill, stacking on **wherever
   you currently are**, then **submit the stack**.

   - Do **not** navigate first — no `gt repo sync`, no `gt checkout master`, no
     jumping to the trunk or the tip of the stack. Start from the current
     branch, wherever it sits in the stack (mid-stack, tip, or trunk — all
     fine).
   - Run `gt create -am "<message>"`. This creates the new branch as a child of
     the current branch, so the work stacks directly on top of where you
     started.
   - Run `gt submit --stack --draft` to push all branches in the stack and
     create or update **draft** PRs on GitHub. New PRs must open as drafts — do
     not publish. Do **not** use `gh pr create` — Graphite owns PR creation and
     base-branch targeting.
   - `gt create` leaves you checked out on the new branch, so the **next**
     iteration naturally stacks on this one — the queue chains into a clean
     stack from your starting point onward.
   - Each item = one branch, stacked on the previous. Write a clear, tight
     commit message.

6. **Mark it done.** Edit the work-queue document in place: change the item's
   box to `[x]`, append the **branch name** and **PR URL** (from
   `gt branch info`), and move the line into a `## Done` section (create one if
   absent). Only `git commit` this doc edit if the document's rules say to —
   otherwise just save the file (queues often live outside the repo on purpose,
   to keep diffs clean).

7. **End the iteration.** Briefly report what shipped, the branch name, and the
   PR URL. Inside a `/loop`, this hands control back so the next tick picks up
   the following item.

## Guardrails

- Start from a **clean working tree** — uncommitted changes will confuse
  `gt create`. If the tree is dirty, stop and tell the user rather than sweeping
  unrelated changes into the branch.
- Keep each branch **small and self-contained** so the stack stays reviewable.
- If implementing an item turns out to be ambiguous or much larger than one
  branch, stop and surface that to the user instead of guessing or shipping a
  half-feature.
