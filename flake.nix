{
  description = "Mark's system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
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
      configuration =
        { pkgs, ... }:
        {
          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Allow unfree software
          nixpkgs.config.allowUnfree = true;

          # Enable alternative shell support in nix-darwin.
          programs.zsh.enable = true;
          programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

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
          security.pam.enableSudoTouchIdAuth = true;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          # Declare the user that will be running `nix-darwin`.
          users.users.mark = {
            name = "mark";
            home = "/Users/mark";
          };

          environment.shells = with pkgs; [
            bashInteractive
            zsh
            fish
          ];

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = with pkgs; [
            # vscode
            vim
            nixfmt-rfc-style
            nixd
            direnv
          ];

          # Homebrew
          homebrew = {
            enable = false;
            brews = [
              # "1password-cli"
              # "ast-grep"
              # "bash"
              # "bat"
              # "blueutil"
              # "ccache"
              # "clang-format"
              # "cmake"
              # "cocoapods"
              # "dict"
              # "fd"
              # "ffmpeg"
              # "fish"
              # "flyctl"
              # "fnm"
              # "fzf"
              # "gh"
              # "git"
              # "gnu-sed"
              # "go"
              # "imagemagick"
              # "jesseduffield/lazygit/lazygit"
              # "jq"
              # "just"
              # "keith/formulae/reminders-cli"
              # "luarocks"
              # "neovim"
              # "ngrok/ngrok/ngrok"
              # "ninja"
              # "opam"
              # "p7zip"
              # "rename"
              # "ripgrep"
              # "sponge"
              # "starship"
              # "stylua"
              # "swiftformat"
              # "task"
              # "timg"
              # "tmux"
              # "trash"
              # "tree"
              # "tree-sitter"
              # "watchman"
              # "wget"
              # "withgraphite/tap/graphite"
              # "yq"
              # "zoxide"
            ];

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
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#home
      darwinConfigurations."home" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
    };
}
