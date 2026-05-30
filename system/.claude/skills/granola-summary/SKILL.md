---
name: granola-summary
description:
  Generate a daily summary of Mark's action items from Granola meeting notes in
  the last 24h (or since Friday on Mondays) and post to Slack via webhook. Use
  when Mark types /granola-summary or when the weekday 9am launchd cron fires.
user-invocable: true
---

# Granola Daily Follow-ups

Each weekday morning, review Mark's Granola meeting notes from the last 24 hours
(or since Friday on Mondays), pull full transcripts, and produce a clean list of
**Mark's** action items (with due dates and links back to the meeting notes).
Post the result to Slack via an incoming webhook.

## Inputs

- No manual inputs.
- Timezone: America/Chicago.
- Define:
  - `NOW` = current timestamp
  - If today (in America/Chicago) is **Monday**: `WINDOW_START` =
    `NOW - 72 hours` (so Friday's notes plus anything from the weekend are
    included).
  - Otherwise: `WINDOW_START` = `NOW - 24 hours`.
  - `WINDOW_END` = `NOW`
  - `WINDOW_LABEL` = `"since Friday"` on Monday, otherwise `"last 24h"`. Use
    this label anywhere the prompt says "last 24h" / "last 24 hours" (Step 1
    heading, the no-meetings message, the Slack header, the Slack template).

## Step 1 — Find meeting notes

Query Granola meeting notes within `WINDOW_START..WINDOW_END`.

Filter guidance (use whichever property is available in the meeting notes
schema):

- Prefer filtering by meeting note `created_time` (or equivalent).
- Use `date_is_on_or_after` = `WINDOW_START` and `date_is_on_or_before` =
  `WINDOW_END` if available.
- If only relative filters are available, use `date_is_within: the_past_day`.

Return a list of meeting notes with at least:

- Meeting title
- Meeting note URL
- Created time (or meeting time)
- Attendees (if available)

If there are **no** meetings in the window, output
`No Granola meetings in the {WINDOW_LABEL}` (e.g. "No Granola meetings in the
last 24h" or "No Granola meetings since Friday") and stop. Do not post anything
to Slack.

## Step 2 — Pull full transcripts

For each meeting note returned in Step 1:

- Load the **full transcript** for the meeting note.
- Keep a reference to:
  - Meeting title
  - Meeting note URL
  - Transcript text

## Step 3 — Extract follow-ups (action items)

From each transcript + the meeting note summary, extract:

- **Action items**: tasks someone needs to do after the meeting
- **Decisions** (optional but useful): decisions made that imply follow-up work
- **Open questions / risks** that need answers

For each action item, include:

- **Task** (clear verb + object; no vague phrasing)
- **Due** (explicit date/time if mentioned; otherwise "No due date")
- **Context** (1 short sentence)
- **Source**: meeting title + meeting note URL + a brief transcript
  quote/snippet if it helps disambiguate

Rules:

- Only include action items where the owner is Mark (match "Mark Skelton" or
  "Mark"`). Exclude everything else.
- Do not invent due dates.
- Deduplicate repeats across meetings, but keep **all sources** (multiple
  meeting links).

## Step 4 — Output format

Produce a section in chat:

### Action items (Mark)

- [ ] Task — _Due:_ … — _Source:_ <meeting link>
  - Context…

## Step 5 — Slack message (for #alerts-mskelton)

Post Mark's action items to Slack using an incoming webhook. If there are no
Granola notes, don't post anything.

**Webhook**

- Use the environment variable `$ALERTS_MSKELTON_WEBHOOK_URL`
- Do not echo or print the webhook URL anywhere (it's a secret)

**Block Kit payload shape (example)**

```json
{
  "blocks": [
    {
      "type": "header",
      "text": { "type": "plain_text", "text": "Granola follow-ups (last 24h)" }
    },
    {
      "type": "context",
      "elements": [
        {
          "type": "mrkdwn",
          "text": "*America/Chicago* · Summarized by Granola"
        }
      ]
    },
    { "type": "divider" },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*My action items*\n• <meeting_url|Meeting title> — Task (Due)\n• <meeting_url|Meeting title> — Task (Due)"
      }
    },
    {
      "type": "context",
      "elements": [{ "type": "mrkdwn", "text": "Updated: <TIMESTAMP>" }]
    }
  ]
}
```

**Rules for Block Kit text**

- Use Slack mrkdwn (`*bold*`), not markdown headers
- Keep it scannable (aim for <2 minutes)
- No raw URLs — use `<url|label>` link syntax
- Substitute `WINDOW_LABEL` into the header text (e.g. "Granola follow-ups
  (since Friday)" on Mondays)

**Post it with curl** (write JSON to a temp file to avoid shell quoting issues):

```bash
cat > /tmp/granola-followups-payload.json <<'JSON'
{ "blocks": [] }
JSON
curl -X POST -H 'Content-type: application/json' \
  --data @/tmp/granola-followups-payload.json \
  "$ALERTS_MSKELTON_WEBHOOK_URL"
rm /tmp/granola-followups-payload.json
```

## Slack message template

Use this exact structure:

```
Granola follow-ups (<WINDOW_LABEL>) (America/Chicago)

My action items

<meeting_url|Meeting title> — Task (Due)
<meeting_url|Meeting title> — Task (Due)

Updated: <timestamp>
```

## Guardrails

- If `$ALERTS_MSKELTON_WEBHOOK_URL` is unset, abort before constructing the
  payload and print a clear error to stderr. Do not attempt to POST.
- If the Granola MCP is unavailable or errors, note the failure in chat and exit
  — do not post a partial message.
- Never log or echo the webhook URL anywhere (chat, files, stdout).
