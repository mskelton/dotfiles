# VS Code Extensions

Before installing extensions, you first need to run the
[`Install 'cursor' command in PATH`](https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line)
command.

```bash
cursor --install-extension biomejs.biome
cursor --install-extension charliermarsh.ruff
cursor --install-extension dbaeumer.vscode-eslint
cursor --install-extension eamodio.gitlens
cursor --install-extension esbenp.prettier-vscode
cursor --install-extension formulahendry.auto-rename-tag
cursor --install-extension github.vscode-pull-request-github
cursor --install-extension golang.go
cursor --install-extension ms-playwright.playwright
cursor --install-extension ms-python.debugpy
cursor --install-extension ms-python.python
cursor --install-extension ms-python.vscode-pylance
cursor --install-extension mskelton.adjacent
cursor --install-extension mskelton.open-url-under-cursor
cursor --install-extension mskelton.unix-chmod
cursor --install-extension patricknasralla.tokyo-night-moon
cursor --install-extension pkief.material-icon-theme
cursor --install-extension rodrigoscola.vscode-textobjects
cursor --install-extension rust-lang.rust-analyzer
cursor --install-extension sleistner.vscode-fileutils
cursor --install-extension sygene.auto-correct
cursor --install-extension tamasfe.even-better-toml
cursor --install-extension usernamehw.errorlens
cursor --install-extension vitest.explorer
cursor --install-extension vscodevim.vim
cursor --install-extension wycliffeassociates.usfmvscode
```

You can regenerate the above script using this command:

```bash
cursor --list-extensions | xargs -L 1 echo cursor --install-extension | pbcopy
```
