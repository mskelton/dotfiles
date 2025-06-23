# {
#   outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }:
#   let
#     configuration = { pkgs, ... }: {
#       # List packages installed in system profile. To search by name, run:
#       # $ nix-env -qaP | grep wget
#       environment.systemPackages = with pkgs; [
#         # Development tools
#         git
#         neovim
#         fish
#         starship
#         tmux
#         fzf
#         ripgrep
#         fd
#         bat
#         tree
#         jq
#         yq
#         wget
#         curl
#
#         # Languages and tools
#         go
#         nodejs
#         python3
#
#         # CLI utilities
#         gh
#         lazygit
#         zoxide
#         just
#         task
#         trash-cli
#
#         # Media tools
#         ffmpeg
#         imagemagick
#
#         # System tools
#         htop
#         tree-sitter
#         stylua
#       ];
#
#       # Homebrew
#       homebrew = {
#         enable = false;
#         brews = [
#           "1password-cli"
#           "as-tree"
#           "ast-grep"
#           "bash"
#           "blueutil"
#           "ccache"
#           "clang-format"
#           "cmake"
#           "cocoapods"
#           "dict"
#           "flyctl"
#           "fnm"
#           "gnu-sed"
#           "jesseduffield/lazygit/lazygit"
#           "keith/formulae/reminders-cli"
#           "luarocks"
#           "ngrok/ngrok/ngrok"
#           "ninja"
#           "opam"
#           "p7zip"
#           "rename"
#           "sponge"
#           "swiftformat"
#           "timg"
#           "watchman"
#           "withgraphite/tap/graphite"
#         ];
#
#         casks = [
#           "arc"
#           "docker"
#           "figma"
#           "firefox"
#           "font-jetbrains-mono"
#           "font-symbols-only-nerd-font"
#           "ghostty"
#           "hammerspoon"
#           "kitty"
#           "logi-options-plus"
#           "logitune"
#           "mic-drop"
#           "microsoft-edge"
#           "mimestream"
#           "raycast"
#           "shottr"
#           "telegram"
#           "visual-studio-code"
#           "zoom"
#         ];
#
#         taps = [
#           "homebrew/cask-drivers"
#           "homebrew/cask-fonts"
#           "ngrok/ngrok"
#           "withgraphite/tap"
#         ];
#
#         onActivation.cleanup = "zap";
#         onActivation.autoUpdate = true;
#         onActivation.upgrade = true;
#       };
#
#       # macOS system configuration
#       system.defaults = {
#         dock = {
#           autohide = true;
#           autohide-delay = 0.0;
#           autohide-time-modifier = 0.25;
#           tilesize = 45;
#           show-recents = false;
#         };
#
#         finder = {
#           ShowPathbar = true;
#           FXPreferredViewStyle = "clmv";
#           _FXSortFoldersFirst = true;
#           FXDefaultSearchScope = "SCcf";
#           FXRemoveOldTrashItems = true;
#         };
#
#         NSGlobalDomain = {
#           AppleInterfaceStyle = "Dark";
#           ApplePressAndHoldEnabled = false;
#           KeyRepeat = 2;
#           InitialKeyRepeat = 15;
#           "com.apple.keyboard.fnState" = true;
#           NSAutomaticQuoteSubstitutionEnabled = false;
#           NSAutomaticDashSubstitutionEnabled = false;
#           NSAutomaticPeriodSubstitutionEnabled = false;
#           NSToolbarTitleViewRolloverDelay = 0.0;
#           "com.apple.swipescrolldirection" = false;
#           NSScrollViewRubberbanding = false;
#           AppleShowScrollBars = "WhenScrolling";
#           "com.apple.trackpad.scaling" = 0.875;
#         };
#
#         screencapture = {
#           location = "~/Downloads";
#           show-thumbnail = false;
#         };
#       };
#
#       # Auto upgrade nix package and the daemon service.
#       services.nix-daemon.enable = true;
#       # nix.package = pkgs.nix;
#
#       # Necessary for using flakes on this system.
#       nix.settings.experimental-features = "nix-command flakes";
#
#       # # Create /etc/zshrc that loads the nix-darwin environment.
#       # programs.fish.enable = true;
#
#       # Set Git commit hash for darwin-version.
#       system.configurationRevision = self.rev or self.dirtyRev or null;
#
#       # Used for backwards compatibility, please read the changelog before changing.
#       # $ darwin-rebuild changelog
#       system.stateVersion = 4;
#
#       # The platform the configuration will be used on.
#       nixpkgs.hostPlatform = "aarch64-darwin";
#
#       # Users configuration
#       users.users.mark = {
#         name = "mark";
#         home = "/Users/mark";
#       };
#     };
#   in
#   {
#     # Build darwin flake using:
#     # $ darwin-rebuild build --flake .#personal
#     darwinConfigurations."personal" = nix-darwin.lib.darwinSystem {
#       modules = [
#         configuration
#         home-manager.darwinModules.home-manager
#         {
#           home-manager.useGlobalPkgs = true;
#           home-manager.useUserPackages = true;
#           home-manager.users.mark = import ./home.nix;
#         }
#       ];
#     };
#
#     darwinConfigurations."work" = nix-darwin.lib.darwinSystem {
#       modules = [
#         configuration
#         home-manager.darwinModules.home-manager
#         {
#           home-manager.useGlobalPkgs = true;
#           home-manager.useUserPackages = true;
#           home-manager.users.mark = import ./work.nix;
#         }
#       ];
#     };
#
#     # Expose the package set, including overlays, for convenience.
#     darwinPackages = self.darwinConfigurations."personal".pkgs;
#   };
# }
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
          environment.shells = with pkgs; [
            bashInteractive
            zsh
            fish
          ];

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = with pkgs; [
            vim
            nixfmt-rfc-style
            nixd
          ];

          # Homebrew
          homebrew = {
            enable = false;
            brews = [
              "1password-cli"
              "as-tree"
              "ast-grep"
              "bash"
              "blueutil"
              "ccache"
              "clang-format"
              "cmake"
              "cocoapods"
              "dict"
              "flyctl"
              "fnm"
              "gnu-sed"
              "jesseduffield/lazygit/lazygit"
              "keith/formulae/reminders-cli"
              "luarocks"
              "ngrok/ngrok/ngrok"
              "ninja"
              "opam"
              "p7zip"
              "rename"
              "sponge"
              "swiftformat"
              "timg"
              "watchman"
              "withgraphite/tap/graphite"
            ];

            casks = [
              "arc"
              "docker"
              "figma"
              "firefox"
              "font-jetbrains-mono"
              "font-symbols-only-nerd-font"
              "ghostty"
              "hammerspoon"
              "kitty"
              "logi-options-plus"
              "logitune"
              "mic-drop"
              "microsoft-edge"
              "mimestream"
              "raycast"
              "shottr"
              "telegram"
              "visual-studio-code"
              "zoom"
            ];

            taps = [
              "homebrew/cask-drivers"
              "homebrew/cask-fonts"
              "ngrok/ngrok"
              "withgraphite/tap"
            ];

            onActivation.cleanup = "zap";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#home
      darwinConfigurations."home" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };
    };
}
