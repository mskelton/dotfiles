<instructions>
You are now an agent to help create a new VS Code extension project. You will scaffold a complete VS Code extension using https://github.com/mskelton/vscode-notify as a template source, create all necessary files, and set up a GitHub repository.

IMPORTANT RULES:

1. Use the vscode-notify repo as a reference for project structure and
   configuration files
2. Create a minimal but complete VS Code extension setup
3. The repository name should be vscode-{title} where {title} is provided by the
   user
4. Use `gh auth switch -u mskelton` before creating the repo
5. Use flags for `gh repo create`, not interactive mode
6. Create an empty extension.ts with activate/deactivate methods
7. Ensure all necessary configuration files are created </instructions>

<questions>
  <question id="title">
    <text>What is the title of your VS Code extension?</text>
    <description>This will be used for the extension name and repository name (repo will be vscode-{title})</description>
  </question>
  <question id="description">
    <text>What is the description of your VS Code extension?</text>
    <description>A brief description of what your extension does</description>
  </question>
</questions>

<setup-steps>
1. Fetch Reference Files:
   - Use WebFetch to get key configuration files from https://github.com/mskelton/vscode-notify
   - Files to reference:
      - .github/workflows/build.yml
      - .gitignore
      - .prettierignore
      - .prettierrc
      - eslint.config.mjs
      - package.json
      - tsconfig.json

2. Create Project Directory:

   - Create directory named vscode-{title}
   - Navigate into the directory

3. Create Essential Files:

   - .github/workflows/build.yml (copy from reference)
   - .gitignore (copy from reference)
   - .prettierignore (copy from reference)
   - .prettierrc (copy from reference)
   - eslint.config.mjs (copy from reference)
   - package.json (adapted with new title, description, and repository URL)
   - tsconfig.json (copy from reference)
   - README.md (using file template)
   - src/extension.ts (using file template)

4. Initialize Git and Create GitHub Repo:
   - Initialize git repository
   - Add all files
   - Create initial commit
   - Switch GitHub auth: `gh auth switch -u mskelton`
   - Create repo:
     `gh repo create vscode-{title} --description "{description}" --public --source . --remote origin --push`
     </setup-steps>

<file-templates>
  <template name="extension.ts">
import * as vscode from 'vscode';

export function activate(context: vscode.ExtensionContext) {
console.log('Congratulations, your extension "{title}" is now active!');

    const disposable = vscode.commands.registerCommand('{title}.helloWorld', () => {
        vscode.window.showInformationMessage('Hello World from {title}!');
    });

    context.subscriptions.push(disposable);

}

export function deactivate() { console.log('Your extension "{title}" is now
deactivated!'); } </template>

  <template name="README.md">
# {title}

{description}

## Features

Describe specific features of your extension including screenshots of your
extension in action.

## Extension Settings

This extension contributes the following settings:

- `{title}.thing`: Set to `blah` to do something </template> </file-templates>

<output-format>
After creating the extension, provide output in this format:

## VS Code Extension Created Successfully! 🎉

### Project Details

- Extension Name: {title}
- Repository: https://github.com/mskelton/vscode-{title}
- Description: {description}

### Created Files

- List of files created

### Next Steps

1. Navigate to your project: `cd vscode-{title}`
2. Install dependencies: `npm install`
3. Open in VS Code: `code .`
4. Publish to the regsitry (`ext-pub`)

### Development Commands

- `npm run package`: Package the extension
- `npm run watch`: Watch for changes
- `npm run lint`: Run ESLint </output-format>
