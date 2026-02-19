---
name: create-pr
description:
  Create GitHub pull requests using the gh CLI. Use when the user asks to create
  a PR, open a pull request, or submit changes for review.
---

# Create Pull Request

Create a pull request using the GitHub CLI (gh).

## Instructions

1. The title should match the first commit message
2. Inspect the diff to understand changes and generate a brief description
3. Keep the description terse - just a very brief summary

## Example

```bash
gh pr create -t "Add QR code scanner" -b "## Description

Implement QR code scanner in the account settings page."
```

## Special Cases

If the branch is named alpha, beta, charlie, delta, or echo, first run
`gn "commit message"` to rename the branch and commit changes, then proceed with
PR creation.

## Output

After creating the PR, display only the pull request URL with no other details.

## Notes

- Ignore any `.github/PULL_REQUEST_TEMPLATE.md` file
- Use the format `## Description` followed by a simple description
