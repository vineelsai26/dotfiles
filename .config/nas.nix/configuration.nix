# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
      dns = "none";
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
    dhcpcd.extraConfig = "nohook resolv.conf";
    hostName = "nixnas";
    firewall = {
      allowedTCPPorts = [ 22 ];
      enable = true;
      allowPing = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.vineel = {
      isNormalUser = true;
      description = "Vineel Sai";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.zsh;
      packages = with pkgs; [];
      openssh = {
        authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHJu++Ud9JG3QBZWZD0Ox44ZibqDLb9BtfA/LcjW3IMo"
        ];
      };
    };

    defaultUserShell = pkgs.zsh;
  };

  # Environment
  environment = {
    shells = with pkgs; [ zsh ];

    # This is using a rec (recursive) expression to set and access XDG_BIN_HOME within the expression
    # For more on rec expressions see https://nix.dev/tutorials/first-steps/nix-language#recursive-attribute-set-rec
    sessionVariables = rec {
      POLKIT_BIN = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_STATE_HOME  = "$HOME/.local/state";

      # Not officially in the specification
      XDG_BIN_HOME    = "$HOME/.local/bin";
      PATH = [
        "${XDG_BIN_HOME}"
      ];
    };

    systemPackages = with pkgs; [
      # CLI Tools
      awscli2
      vim
      wget
      neofetch
      curl
      bat
      eza
      neovim
      zsh
      git
      htop
      btop
      gnupg
      killall
      ripgrep
      trash-cli
      jq
      starship
      efibootmgr
      gnumake
      cmake
      meson
      ninja
      pkg-config
      cpio
      gh
      distrobox
      fzf
      fastfetch
      zoxide

      # fs progs
      ntfs3g
      btrfs-progs

      # Utils
      tailscale
      cockpit
    ];
  };

  programs = {
    zsh = {
      enable = true;
    };

    # Enable Gnupg
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Configure SMB
  services = {
    qemuGuest = {
      enable = true;
    };
    samba = {
      enable = true;
      securityType = "user";
      openFirewall = true;
      extraConfig = ''
        workgroup = WORKGROUP
        server string = smbnix
        netbios name = smbnix
        security = user
        #use sendfile = yes
        #max protocol = smb2
        # note: localhost is the ipv6 localhost ::1
        # hosts allow = 192.168.0. 127.0.0.1 localhost
        # hosts deny = 0.0.0.0/0
        guest account = nobody
        map to guest = bad user
        browseable = yes
      '';
      shares = {
        Dekku = {
          path = "/home/vineel/dekku";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "vineel";
          "force group" = "users";
        };
        TimeMachine = {
          path = "/home/vineel/dekku/TimeMachine";
          "valid users" = "vineel";
          public = "no";
          writeable = "yes";
          "force user" = "vineel";
          "fruit:aapl" = "yes";
          "fruit:time machine" = "yes";
          "fruit:time machine max size" = "400G";
          "vfs objects" = "catia fruit streams_xattr";
        };
      };
    };

    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    cockpit = {
      enable = true;
      port = 9090;
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
      extraConfig = ''
        MaxAuthTries 10
      '';
    };

    tailscale.enable = true;
  };

  # NixOS Version
  system.stateVersion = "24.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
