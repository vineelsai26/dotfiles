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
            NSGlobalDomain = {
              AppleInterfaceStyle = "Dark";
              AppleShowAllExtensions = true;
              NSAutomaticCapitalizationEnabled = true;
              NSAutomaticPeriodSubstitutionEnabled = true;
              "com.apple.springing.delay" = 0.5;
              "com.apple.springing.enabled" = true;
              "com.apple.trackpad.forceClick" = true;
            };

            dock = {
              autohide = true;
              autohide-delay = 0.0;
              expose-group-apps = true;
              largesize = 70;
              magnification = true;
              minimize-to-application = true;
              mru-spaces = false;
              persistent-apps = [
                "/System/Applications/Apps.app"
                "/System/Applications/App Store.app"
                "/System/Applications/Mail.app"
                "/Applications/Obsidian.app"
                "/System/Applications/Reminders.app"
                "/Applications/Google Chrome.app"
                "/Applications/Visual Studio Code.app"
                "/Applications/T3 Code (Nightly).app"
                "/Applications/ChatGPT.app"
                "/Applications/Ghostty.app"
                "/System/Applications/iPhone Mirroring.app"
                "/System/Applications/Siri AI.app"
                "/System/Applications/System Settings.app"
              ];
              persistent-others = [
                {
                  folder = {
                    path = "/Users/vineel/Downloads";
                    arrangement = "date-added";
                    displayas = "stack";
                    showas = "fan";
                  };
                }
              ];
              show-recents = false;
              wvous-br-corner = 1;
            };

            finder = {
              AppleShowAllExtensions = true;
              FXDefaultSearchScope = "SCcf";
              FXPreferredViewStyle = "Nlsv";
              FXRemoveOldTrashItems = true;
              NewWindowTarget = "Home";
              ShowExternalHardDrivesOnDesktop = true;
              ShowHardDrivesOnDesktop = false;
              ShowMountedServersOnDesktop = true;
              ShowPathbar = true;
              ShowRemovableMediaOnDesktop = false;
            };

            trackpad = {
              ActuateDetents = true;
              Clicking = true;
              DragLock = false;
              Dragging = false;
              FirstClickThreshold = 1;
              ForceSuppressed = false;
              SecondClickThreshold = 1;
              TrackpadCornerSecondaryClick = 0;
              TrackpadFourFingerHorizSwipeGesture = 2;
              TrackpadFourFingerPinchGesture = 2;
              TrackpadFourFingerVertSwipeGesture = 2;
              TrackpadMomentumScroll = true;
              TrackpadPinch = true;
              TrackpadRightClick = true;
              TrackpadRotate = true;
              TrackpadThreeFingerDrag = false;
              TrackpadThreeFingerHorizSwipeGesture = 2;
              TrackpadThreeFingerTapGesture = 0;
              TrackpadThreeFingerVertSwipeGesture = 2;
              TrackpadTwoFingerDoubleTapGesture = true;
              TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
            };

            WindowManager = {
              AppWindowGroupingBehavior = true;
              AutoHide = false;
              EnableTiledWindowMargins = false;
              GloballyEnabled = false;
              HideDesktop = true;
              StageManagerHideWidgets = false;
              StandardHideWidgets = false;
            };

            ActivityMonitor = {
              OpenMainWindow = true;
              ShowCategory = 100;
            };

            CustomUserPreferences.NSGlobalDomain = {
              AppleLanguages = [ "en-IN" ];
              AppleLocale = "en_IN";
              AppleMiniaturizeOnDoubleClick = 0;
            };

            SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
            controlcenter.BatteryShowPercentage = true;
            iCal.CalendarSidebarShown = false;
            loginwindow.GuestEnabled = false;
            magicmouse.MouseButtonMode = "OneButton";
            menuExtraClock = {
              ShowAMPM = true;
              ShowDate = 0;
              ShowDayOfWeek = true;
            };
            screencapture.location = "/Users/vineel/Pictures/Screenshots";
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
