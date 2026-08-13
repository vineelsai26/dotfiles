{
  description = "Vineel's nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      configuration = { ... }: {
        imports = [ ./homebrew.nix ];

        # Nix manages macOS and Homebrew policy. Packages and applications are
        # installed by Homebrew in homebrew.nix, not into the Nix system profile.
        environment.systemPackages = [ ];

        nix.settings = {
          experimental-features = [ "nix-command" "flakes" ];
          sandbox = true;
        };
        nixpkgs.hostPlatform = "aarch64-darwin";

        nix.gc = {
          automatic = true;
          options = "--delete-older-than 30d";
        };

        programs.zsh.enable = true;
        security.pam.services.sudo_local.touchIdAuth = true;

        system = {
          primaryUser = "vineel";
          configurationRevision = self.rev or self.dirtyRev or null;

          # Latest compatibility version supported by nix-darwin 26.05.
          stateVersion = 7;

          activationScripts.postActivation.text = ''
            screenshot_dir="/Users/vineel/Pictures/Screenshots"
            if [ ! -d "$screenshot_dir" ]; then
              /usr/bin/install -d -m 0755 -o vineel -g staff "$screenshot_dir"
            fi
          '';

          defaults = {
            dock.autohide = true;
            dock.mru-spaces = false;
            finder.AppleShowAllExtensions = true;
            finder.FXPreferredViewStyle = "clmv";
            screencapture.location = "/Users/vineel/Pictures/screenshots";
            screensaver.askForPasswordDelay = 10;
          };
        };
      };
    in
    {
      darwinConfigurations."Vineels-MacBook-Air" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };

      darwinPackages = self.darwinConfigurations."Vineels-MacBook-Air".pkgs;
    };
}
