# VS Code Extensions

Before installing extensions, you first need to run the
[`Install 'cursor' command in PATH`](https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line)
command.

```bash
cursor --install-extension dbaeumer.vscode-eslint
cursor --install-extension esbenp.prettier-vscode
cursor --install-extension formulahendry.auto-rename-tag
cursor --install-extension golang.go
cursor --install-extension mskelton.open-url-under-cursor
cursor --install-extension patricknasralla.tokyo-night-moon
cursor --install-extension pkief.material-icon-theme
cursor --install-extension rust-lang.rust-analyzer
cursor --install-extension tamasfe.even-better-toml
cursor --install-extension vscodevim.vim
```

You can regenerate the above script using this command:

```bash
cursor --list-extensions | xargs -L 1 echo cursor --install-extension | pbcopy
```
