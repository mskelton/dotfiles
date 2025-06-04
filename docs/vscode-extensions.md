# VS Code Extensions

Before installing extensions, you first need to run the
[`Install 'code' command in PATH`](https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line)
command.

```bash
code --install-extension anthropic.claude-code
code --install-extension biomejs.biome
code --install-extension charliermarsh.ruff
code --install-extension dbaeumer.vscode-eslint
code --install-extension eamodio.gitlens
code --install-extension editorconfig.editorconfig
code --install-extension esbenp.prettier-vscode
code --install-extension formulahendry.auto-rename-tag
code --install-extension github.vscode-pull-request-github
code --install-extension golang.go
code --install-extension mkhl.shfmt
code --install-extension ms-playwright.playwright
code --install-extension ms-python.debugpy
code --install-extension ms-python.mypy-type-checker
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension mskelton.adjacent
code --install-extension mskelton.notify
code --install-extension mskelton.open-url-under-cursor
code --install-extension mskelton.unix-chmod
code --install-extension patricknasralla.tokyo-night-moon
code --install-extension pkief.material-icon-theme
code --install-extension plorefice.devicetree
code --install-extension rodrigoscola.vscode-textobjects
code --install-extension rust-lang.rust-analyzer
code --install-extension sleistner.vscode-fileutils
code --install-extension sygene.auto-correct
code --install-extension tamasfe.even-better-toml
code --install-extension undefined_publisher.vscode-dtsfmt
code --install-extension usernamehw.errorlens
code --install-extension vitest.explorer
code --install-extension vscodevim.vim
code --install-extension wycliffeassociates.usfmvscode
```

You can regenerate the above script using this command:

```bash
code --list-extensions | xargs -L 1 echo code --install-extension | pbcopy
```
