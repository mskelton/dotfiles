{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "mark";
  home.homeDirectory = "/Users/mark";

  # This value determines the Home Manager release which your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "23.11";

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    # Development
    direnv

    # Additional CLI tools that might not be in the system config
    nushell
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # Neovim configuration
    ".config/nvim".source = ./nvim;

    # Fish configuration
    ".config/fish".source = ./home/.config/fish;

    # Git configuration
    ".config/git".source = ./home/.config/git;

    # Tmux configuration
    ".config/tmux".source = ./home/.config/tmux;

    # Starship configuration
    ".config/starship.toml".source = ./home/.config/starship.toml;

    # Kitty configuration
    ".config/kitty".source = ./home/.config/kitty;

    # Ghostty configuration
    ".config/ghostty".source = ./home/.config/ghostty;

    # Task configuration
    ".config/task".source = ./home/.config/task;

    # fd configuration
    ".config/fd".source = ./home/.config/fd;

    # direnv configuration
    ".config/direnv".source = ./home/.config/direnv;

    # GitHub CLI configuration
    ".config/gh/config.yml".source = ./home/.config/gh/config.yml;

    # gh-dash configuration
    ".config/gh-dash/config.yml".source = ./home/.config/gh-dash/config.yml;

    # Graphite configuration
    ".config/graphite/aliases".source = ./home/.config/graphite/aliases;
    ".config/graphite/custom-aliases".source = ./home/.config/graphite/custom-aliases;

    # Byte configuration
    ".config/byte/config.yaml".source = ./home/.config/byte/config.yaml;

    # Pomo configuration
    ".config/pomo/config.json".source = ./home/.config/pomo/config.json;

    # Hammerspoon configuration
    ".hammerspoon".source = ./home/.hammerspoon;

    # SSH configuration
    ".ssh/config".source = ./home/.ssh/config;

    # Emacs configuration
    ".emacs.d/early-init.el".source = ./home/.emacs.d/early-init.el;
    ".emacs.d/init.el".source = ./home/.emacs.d/init.el;

    # Skeletons
    ".skeletons".source = ./home/.skeletons;

    # Local bin
    ".local/bin".source = ./bin;

    # Lazygit configuration
    "Library/Application Support/lazygit/config.yml".source = ./lazygit/config.yml;

    # ngrok configuration
    "Library/Application Support/ngrok/ngrok.yml".source = ./ngrok/ngrok.yml;

    # Nushell configuration
    "Library/Application Support/nushell".source = ./nushell;

    # Claude configuration
    ".claude".source = ./claude;
  };

  # VS Code configuration via Home Manager
  home.file."Library/Application Support/Code/User/settings.json".source = ./vscode/settings.json;
  home.file."Library/Application Support/Code/User/keybindings.json".source = ./vscode/keybindings.json;
  home.file."Library/Application Support/Code/User/snippets".source = ./vscode/snippets;

  # Cursor configuration (same as VS Code)
  home.file."Library/Application Support/Cursor/User/settings.json".source = ./vscode/settings.json;
  home.file."Library/Application Support/Cursor/User/keybindings.json".source = ./vscode/keybindings.json;
  home.file."Library/Application Support/Cursor/User/snippets".source = ./vscode/snippets;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Configure Git
  programs.git = {
    enable = true;
    # You can add git configuration here if you want to manage it via Nix
    # Otherwise it will use the files from home.file above
  };

  # Configure Fish shell
  programs.fish = {
    enable = true;
    # Fish configuration will be loaded from the files above
  };

  # Configure Starship prompt
  programs.starship = {
    enable = true;
    # Configuration will be loaded from the file above
  };

  # Configure direnv
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  # Configure fzf
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  # Configure zoxide
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
