# macOS permission checklist

Some command-line and automation tools need explicit macOS permissions.

## Privacy settings

- Open Privacy & Security in System Settings.
- Review Accessibility access.
- Review Automation access.
- Review Full Disk Access.
- Review Screen Recording access.
- Review Input Monitoring access.

## Terminal applications

- Confirm the active terminal application is listed.
- Remove entries for applications no longer installed.
- Re-enable access after application replacements.
- Restart applications after changing permissions.
- Test the smallest affected action first.

## Automation tools

- Confirm Hammerspoon can use Accessibility features.
- Confirm screenshot tools can record the screen.
- Confirm launchers can automate intended applications.
- Confirm editors can access removable volumes when needed.
- Avoid granting permissions unrelated to actual use.

## Troubleshooting order

1. Reproduce the denied action.
2. Note the exact application requesting access.
3. Check the narrowest relevant permission.
4. Restart only that application.
5. Re-run the original action.
6. Record any permission that fixed the issue.

## Reminder

Permissions are stored by application identity, so reinstalling or replacing an
application may require reviewing its entries again.
