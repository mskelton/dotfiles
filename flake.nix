{
  description = "Mark's system flake";

  nixConfig = {
    commit-lockfile-summary = "chore(flake.lock): update inputs";
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
    }:
    let
      mkHomeManagerModule =
        { username, contextPath }:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} =
            { ... }:
            {
              home.stateVersion = "25.11";

              home.file.".config/byte/config.yaml" = {
                source = ./.config/byte/config.yaml;
                force = true;
              };
              #               home.file.".config/gh-dash/config.yml".source = ./.config/gh-dash/config.yml;
              #               home.file.".config/gh/config.yml".source = ./.config/gh/config.yml;
              #               home.file.".config/graphite/aliases".source = ./.config/graphite/aliases;
              #               home.file.".config/graphite/custom-aliases".source = ./.config/graphite/custom-aliases;
              #               home.file.".config/starship.toml".source = ./.config/starship.toml;
              #
              #               home.file.".config/direnv".source = ./.config/direnv;
              #               home.file.".config/fd".source = ./.config/fd;
              #               home.file.".config/ghostty".source = ./.config/ghostty;
              #               home.file.".config/git".source = ./.config/git;
              #               home.file.".config/kitty".source = ./.config/kitty;
              #               home.file.".config/task".source = ./.config/task;
              #               home.file.".config/tmux".source = ./.config/tmux;

              # home.file.".config/fish/context.fish" = {
              #   source = contextPath;
              #               # Symlink Fish configuration
              #               home.file = {
              #                 # Main Fish config directory
              #                 ".config/fish" = {
              #                   source = ./.config/fish;
              #                   recursive = true;
              #                 };
              #
              #                 # Context-specific Fish config
              #                 ".config/fish/context.fish" = {
              #                   source = contextPath;
              #                 };
              #               };
            };
        };
      mkConfiguration =
        { username }:
        { pkgs, ... }:
        {
          # Necessary for using flakes on this system
          nix.settings.experimental-features = "nix-command flakes";

          # Allow unfree software
          nixpkgs.config.allowUnfree = true;

          # Enable alternative shell support in nix-darwin
          programs.fish.enable = true;

          # Set Git commit hash for darwin-version
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # Required for nix-darwin
          system.primaryUser = "mark";

          # Setup user
          users.users.${username} = {
            name = username;
            home = "/Users/${username}";
          };

          # macOS system configuration
          system.defaults = {
            dock = {
              autohide = true;
              autohide-delay = 0.0;
              autohide-time-modifier = 0.25;
              tilesize = 45;
              show-recents = false;
            };

            #             finder = {
            #               ShowPathbar = true;
            #               FXPreferredViewStyle = "clmv";
            #               _FXSortFoldersFirst = true;
            #               FXDefaultSearchScope = "SCcf";
            #               FXRemoveOldTrashItems = true;
            #             };
            #
            #             NSGlobalDomain = {
            #               AppleInterfaceStyle = "Dark";
            #               ApplePressAndHoldEnabled = false;
            #               KeyRepeat = 2;
            #               InitialKeyRepeat = 15;
            #               "com.apple.keyboard.fnState" = true;
            #               NSAutomaticQuoteSubstitutionEnabled = false;
            #               NSAutomaticDashSubstitutionEnabled = false;
            #               NSAutomaticPeriodSubstitutionEnabled = false;
            #               NSToolbarTitleViewRolloverDelay = 0.0;
            #               "com.apple.swipescrolldirection" = false;
            #               NSScrollViewRubberbanding = false;
            #               AppleShowScrollBars = "WhenScrolling";
            #               "com.apple.trackpad.scaling" = 0.875;
            #             };

            screencapture = {
              location = "~/Downloads";
              show-thumbnail = false;
            };
          };

          # Enable touch ID for sudo
          security.pam.services.sudo_local.touchIdAuth = true;

          # The platform the configuration will be used on
          nixpkgs.hostPlatform = "aarch64-darwin";

          # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enableCompletion
          environment.pathsToLink = [ "/share/zsh" ];

          environment.shells = with pkgs; [
            bashInteractive
            zsh
            fish
          ];

          environment.systemPackages = with pkgs; [
            ast-grep
            bash
            bat
            blueutil
            direnv
            fd
            ffmpeg
            fish
            flyctl
            fnm
            fzf
            gh
            git
            go
            graphite-cli
            imagemagick
            jq
            just
            lazygit
            neovim
            nixd
            nixfmt-rfc-style
            ripgrep
            starship
            stylua
            tmux
            trash-cli
            tree
            tree-sitter
            vim
            wget
            yq
            zoxide
          ];

          homebrew = {
            enable = false;
            # "gnu-sed"
            brews = [ ];

            casks = [
              # "android-studio"
              # "arc"
              # "cursor"
              # "docker"
              # "figma"
              # "firefox"
              # "font-jetbrains-mono"
              # "font-symbols-only-nerd-font"
              # "hammerspoon"
              # "kitty"
              # "logi-options-plus" # if work
              # "logitune" # if work
              # "mic-drop" # if work
              # "raycast"
              # "shottr"
              # "slack" # if work
              # "telegram" # if home
              # "visual-studio-code"
              # "zoom"
            ];

            taps = [
              "homebrew/cask-drivers"
              "homebrew/cask-fonts"
              "withgraphite/tap"
            ];

            onActivation.cleanup = "zap";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          programs.zsh = {
            enable = true;
            # defaultKeymap = "emacs";
            # dotDir = ".config/zsh";
            # envExtra = "";
            enableAutosuggestions = true;
            enableCompletion = true;
            enableFastSyntaxHighlighting = true;
            enableFzfCompletion = true;
            #             variables = {
            #               FZF_DEFAULT_OPTS = "--reverse --info=inline";
            #               STARSHIP_LOG = "error";
            #               EDITOR = "nvim";
            #               GOPATH = "${homeDirectory}/go";
            #               BUN_INSTALL = "${homeDirectory}/.bun";
            #               HOMEBREW_NO_ENV_HINTS = "true";
            #               GH_NO_UPDATE_NOTIFIER = "true";
            #               PYENV_ROOT = "${homeDirectory}/.pyenv";
            #               ANDROID_HOME = "${homeDirectory}/Library/Android/sdk";
            #               CLOUDSDK_PYTHON = "python3";
            #               TURBO_NO_UPDATE_NOTIFIER = "1";
            #               PAGER = "less";
            #               COREPACK_ENABLE_DOWNLOAD_PROMPT = "0";
            #
            #               # Claude
            #               IS_DEMO = "1";
            #               MAX_THINKING_TOKENS = "16000";
            #             };
            # history.size = 10000;
            # shellAliases = {
            #   ll = "ls -l";
            #   update = "sudo nixos-rebuild switch";
            # };
          };
        };

    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#home
      # $ darwin-rebuild build --flake .#work
      darwinConfigurations."home" = nix-darwin.lib.darwinSystem {
        modules = [
          (mkConfiguration {
            username = "mark";
          })
          home-manager.darwinModules.home-manager
          (mkHomeManagerModule {
            username = "mark";
            contextPath = ./personal/.config/fish/context.fish;
          })
        ];
      };

      darwinConfigurations."work" = nix-darwin.lib.darwinSystem {
        modules = [
          (mkConfiguration {
            username = "mskelton";
          })
          home-manager.darwinModules.home-manager
          (mkHomeManagerModule {
            username = "mskelton";
            contextPath = ./work/.config/fish/context.fish;
          })
        ];
      };
    };
}
