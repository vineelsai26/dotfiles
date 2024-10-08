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
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
      };
      grub = {
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        theme = pkgs.stdenv.mkDerivation {
          pname = "distro-grub-themes";
          version = "3.1";
          src = pkgs.fetchFromGitHub {
            owner = "AdisonCavani";
            repo = "distro-grub-themes";
            rev = "v3.1";
            hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
          };
          installPhase = "cp -r customize/nixos $out";
        };
      };
    };

    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelParams = [
      "amd_iommu=on"
      "pcie_acs_override=downstream,multifunction"
    ];
    kernelModules = [ "kvm-amd" "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];
    extraModulePackages = [ ];
    extraModprobeConfig = "options vfio-pci ids=03:00.0,03:00.1";

    #kernelPackages = pkgs.linuxPackages_latest;

    postBootCommands = ''
      DEVS="03:00.0 03:00.1"

      for DEV in $DEVS; do
        echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
      done
      modprobe -i vfio-pci
    '';
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
      dns = "none";
    };
    bridges = {
      vmbr0 = {
        interfaces = [
          "enp4s0"
        ];
        rstp = true;
      };
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
    interfaces.vmbr0.useDHCP = true;
    dhcpcd.extraConfig = "nohook resolv.conf";
    hostName = "nixos";
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
      extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
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
 
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
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
      zoxide
      fastfetch
      unzip
      pciutils

      # fs progs
      ntfs3g
      btrfs-progs

      # Dev Tools
      vscode
      docker

      # Terminal
      alacritty
      kitty

      # Programing Languages
      python312
      go
      gcc
      zig
      rustup
      bun
      nodejs_20

      # Browser
      brave
      firefox
      google-chrome

      # Window Managers
      hyprland
      i3
      sway

      # Window Manager Tools
      xdg-desktop-portal-hyprland
      waybar
      hypridle
      hyprpaper
      hyprcursor
      hyprlock
      rofi-wayland
      dunst
      grim
      slurp
      wl-clipboard
      xclip
      polkit
      polkit_gnome
      xorg.xhost
      cliphist

      # Utils
      gnome.nautilus
      gnome.gnome-system-monitor
      gnome.gnome-disk-utility
      gparted
      ventoy-full
      virt-manager
      libvirt
      bridge-utils
      packagekit
      networkmanagerapplet
      pavucontrol
      bitwarden-desktop
      bitwarden-cli
      pinentry-all
      tailscale
      cockpit
      playerctl

      # social
      discord

      # Themes
      materia-theme
      bibata-cursors
      papirus-icon-theme
      ubuntu_font_family
      gnome.gnome-themes-extra
      bibata-cursors
    ];
  };

  programs = {
    zsh = {
      enable = true;
    };

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };

    sway = {
      enable = true;
    };

    dconf.enable = true; # virt-manager requires dconf to remember settings

    # Enable Gnupg
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Configure keymap in X11
  services = {
    libinput.enable = true;
    xserver = {
      enable = true;
      xkb = {
        variant = "";
        layout = "us";
      };

      # Enable gdm and wayland
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };

      # Gnome Desktop Manager
      # desktopManager.gnome = {
      #   enable = true;
      # };

      # Enable i3
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          polybar
        ];
      };
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
      '';
      shares = {
        Alpha = {
          path = "/home/vineel";
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

    gnome.gnome-keyring.enable = true;

    cockpit = {
      enable = true;
      port = 9090;
    };

    # CUPS to print documents.
    printing.enable = false;

    # For Mounting USB Devices
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;

    blueman.enable = true;

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
      extraConfig = ''
        MaxAuthTries 10
      '';
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    tailscale.enable = true;
  };

  security = {
    pam.services.gdm.enableGnomeKeyring = true;
    rtkit.enable = true;
    polkit.enable = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;

  hardware = {
    pulseaudio.enable = false;
    bluetooth = {
      enable = true; # enables support for Bluetooth
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
      settings = {
        General = {
          FastConnectable = true;
        };
      };
      input = {
        General = {
          IdleTimeout = 600;
        };
      };
    };
  };

  # Fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  # Enable libvirt
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
        swtpm.enable = true;
      };
      allowedBridges = [
        "vmbr0"
      ];
    };
    docker.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    tmpfiles.rules = [
      "L+ /bin - - - - /run/current-system/sw/bin/"
    ];
  };

  # NixOS Version
  system.stateVersion = "24.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
