# Editor setup checklist

Use this optional list after installing or replacing a code editor.

## Core behavior

- Confirm files open from the command line.
- Confirm the expected font is available.
- Confirm whitespace rendering is intentional.
- Confirm files end with a newline.
- Confirm format-on-save behavior.

## Language tooling

- Check that language servers start successfully.
- Confirm formatter selection per language.
- Confirm lint diagnostics appear once.
- Confirm project-local tools take precedence.
- Check that generated directories are excluded.

## Source control

- Confirm the editor uses the expected Git binary.
- Confirm diffs preserve line endings.
- Confirm commit signing works outside the editor first.
- Review automatic fetch settings.
- Disable automatic publishing when unnecessary.

## Terminal integration

- Confirm the integrated shell matches the system shell.
- Confirm login-shell behavior is intentional.
- Check environment variables in a new terminal.
- Confirm keyboard shortcuts do not conflict.
- Test opening a repository from the terminal.

## Finish

Export only settings that are safe and portable. Machine-specific paths, tokens,
and private extension data should stay out of version control.
