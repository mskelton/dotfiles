---
name: work-queue
description:
  Run one iteration of a work queue — either a markdown document or a Linear
  ticket queue. Pick the next item, implement it end-to-end, commit it as a
  stacked branch via the graphite skill, submit the stack as draft PRs with `gt
  submit --stack --draft`, then mark it done.
user-invocable: true
disable-model-invocation: true
---

# Work Queue

Implement **one** item from a work queue, commit it as a **stacked branch**,
then mark it done. The queue can be a **markdown document** or a **Linear ticket
queue**. Designed to be the body of a `/loop` so a queue gets ground down
one-branch-at-a-time, but works fine as a one-shot too. After each branch, push
and open/update **draft** PRs with `gt submit --stack --draft`.

## Input

The argument tells you which queue to drain. If none is given, ask which queue
to use — do not guess.

- **Markdown document** — a path to a markdown file (e.g.
  `/work-queue ~/Documents/roadmap.md`).
- **Linear ticket queue** — anything that points at Linear: the word `linear`, a
  Linear URL, a project / cycle / team / view name, an issue identifier prefix,
  or a filter description (e.g. `/work-queue linear project Treasury`,
  `/work-queue linear my todo issues`). Resolve it with the Linear MCP tools
  (`list_projects`, `list_teams`, `list_cycles`, `list_issue_statuses`) before
  pulling items. If the source is ambiguous, ask which project/team/cycle to
  drain rather than guessing.

## The document's own rules win

The document may contain its own `## Rules`, `## Conventions`, or
`## Instructions` section (and may name the work section, the parked section,
conventions, test commands, where the file lives, whether to commit it, etc.).
**When such a section exists, it is authoritative — follow it exactly.**
Everything below is the default behavior for documents that don't specify.

## One iteration

1. **Load the queue.** For a markdown document, read the file at the given path.
   For a Linear queue, resolve the source (project / cycle / team / view) with
   the Linear MCP tools.

2. **Pick the next item.**

   **Markdown document:** Look only in the active work section — the document's
   named work section if it specifies one, otherwise the first checklist under a
   heading like `## Features`, `## Queue`, `## Todo`, or `## Tasks`. Within it,
   take the **first `[ ]` checkbox that has a real description.**

   - **Ignore parked sections** — any heading containing words like _undecided,
     wait, parked, backlog, icebox, later, deferred, ideas, someday_. Never pull
     from those.
   - **Ignore empty/placeholder checkboxes** (a bare `- [ ]` with no text).

   **Linear ticket queue:** `list_issues` scoped to the resolved source (project
   / cycle / team / view), filtered to the **`Todo`** status only — skip
   `Backlog`, `In Progress`, `In Review`, `Done`, `Canceled`, and `Duplicate`.
   The Linear MCP does **not** expose manual board order, so on the **first
   iteration** show the user the `Todo` issues and **ask them for the explicit
   order** to work them in. Remember that ordering for the rest of the run (e.g.
   note it at the top of the loop's scratch space) and take the next issue from
   it each iteration — do not re-ask every tick. Then `get_issue` to read the
   full description, acceptance criteria, comments, and linked docs before
   implementing.

3. **Stop if empty.** If there is no ready item (no described unchecked
   checkbox, or no unstarted Linear issue), report "queue empty" and **end** —
   when running inside a `/loop`, do not schedule another iteration.

4. **Implement only that one item, end-to-end.** Do not bundle multiple items
   into one branch.

   - **Linear:** claim the ticket first — `save_issue` to move it to
     `In Progress` so the loop never double-picks it — then implement.
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

6. **Mark it done.** Grab the **branch name** and **PR URL** from
   `gt branch info` first.

   **Markdown document:** Edit the document in place — change the item's box to
   `[x]`, append the branch name and PR URL, and move the line into a `## Done`
   section (create one if absent). Only `git commit` this doc edit if the
   document's rules say to — otherwise just save the file (queues often live
   outside the repo on purpose, to keep diffs clean).

   **Linear ticket queue:** Use `save_issue` to move the issue to the
   appropriate workflow status — **`In Review`** since the PR is open as a draft
   (use the queue's own convention if it names one; never jump straight to
   `Done` for unmerged work). Attach the PR URL to the issue (as a link/comment
   per what `save_issue` supports) and leave the branch name in the issue so the
   next iteration and reviewers can trace it.

7. **End the iteration.** Briefly report what shipped, the item (checkbox text
   or Linear issue identifier), the branch name, and the PR URL. Inside a
   `/loop`, this hands control back so the next tick picks up the following
   item.

## Guardrails

- Start from a **clean working tree** — uncommitted changes will confuse
  `gt create`. If the tree is dirty, stop and tell the user rather than sweeping
  unrelated changes into the branch.
- Keep each branch **small and self-contained** so the stack stays reviewable.
- If implementing an item turns out to be ambiguous or much larger than one
  branch, stop and surface that to the user instead of guessing or shipping a
  half-feature.
