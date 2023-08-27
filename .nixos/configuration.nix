# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # CLI Tools
    vim
    wget
    neofetch
    curl
    bat
    exa
    neovim
    zsh
    git
    htop
    btop
    gnupg
    killall

    # fs progs
    ntfs3g

    # Dev Tools
    vscode
    docker

    # Terminal
    alacritty
    kitty

    # Programing Languages
    python3
    go
    gcc
    zig

    # Browser
    brave
    firefox
    google-chrome

    # Window Managers
    # Hyprland
    hyprland
    hyprpaper
    waybar
    wofi

    # I3
    i3
    sway

    # 1Password
    _1password-gui
    _1password

    # File Managers
    gnome.nautilus
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vineel = {
    isNormalUser = true;
    description = "Vineel Sai";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  thunderbird
    ];
    openssh = {
      authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHJu++Ud9JG3QBZWZD0Ox44ZibqDLb9BtfA/LcjW3IMo"
      ];
    };
  };

  # ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Environment
  environment.shells = with pkgs; [ zsh ];

  # This is using a rec (recursive) expression to set and access XDG_BIN_HOME within the expression
  # For more on rec expressions see https://nix.dev/tutorials/first-steps/nix-language#recursive-attribute-set-rec
  environment.sessionVariables = rec {
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

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    # Enable gdm and wayland
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    # Enable i3
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        polybar
      ];
    };
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Sway
  programs.sway.enable = true;

  # Enable Gnome Keyring
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # CUPS to print documents.
  services.printing.enable = false;

  # For Mounting USB Devices
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Fonts
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  # Enable Gnupg
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Define your hostname.
  networking.hostName = "nixos";

  # NixOS Version
  system.stateVersion = "unstable";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
