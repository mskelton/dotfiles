---
name: create-vscode-extension
description:
  Scaffold a new VS Code extension project with GitHub repository. Use when the
  user wants to create a VS Code extension, start a new extension project, or
  set up a vscode extension.
---

# Create VS Code Extension

Scaffold a complete VS Code extension using
https://github.com/mskelton/vscode-notify as a template.

## Required Information

- **Title**: Extension name (repo will be `vscode-{title}`)
- **Description**: Brief description of what the extension does

## Setup Steps

1. **Fetch Reference Files** from https://github.com/mskelton/vscode-notify:

   - `.github/workflows/build.yml`
   - `.gitignore`
   - `.prettierignore`
   - `.prettierrc`
   - `eslint.config.mjs`
   - `package.json`
   - `tsconfig.json`

2. **Create Project Directory**: `vscode-{title}`

3. **Create Files**:

   - Copy config files from reference
   - Adapt `package.json` with new title, description, and repository URL
   - Create `README.md` and `src/extension.ts` from templates below

4. **Initialize Git and GitHub**:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   gh auth switch -u mskelton
   gh repo create vscode-{title} --description "{description}" --public --source . --remote origin --push
   ```

## File Templates

### src/extension.ts

```typescript
import * as vscode from "vscode"

export function activate(context: vscode.ExtensionContext) {
  console.log('Congratulations, your extension "{title}" is now active!')

  const disposable = vscode.commands.registerCommand(
    "{title}.helloWorld",
    () => {
      vscode.window.showInformationMessage("Hello World from {title}!")
    },
  )

  context.subscriptions.push(disposable)
}

export function deactivate() {
  console.log('Your extension "{title}" is now deactivated!')
}
```

### README.md

```markdown
# {title}

{description}

## Features

Describe specific features of your extension including screenshots.

## Extension Settings

This extension contributes the following settings:

- `{title}.thing`: Set to `blah` to do something
```

## Output Format

After creation, provide:

- Extension name and GitHub repository URL
- List of created files
- Next steps: `cd`, `npm install`, `code .`, `ext-pub`
- Development commands: `npm run package`, `npm run watch`, `npm run lint`
