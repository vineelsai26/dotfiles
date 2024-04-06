{config, pkgs, ... }: 
{
    dconf.settings = { 
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    home.pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 16;
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome.gnome-themes-extra;
      };
    };

    #systemd.user.sessionVariables = config.home-manager.users.vineel.home.sessionVariables;
 
    wayland.windowManager.hyprland.plugins = [];

    home.stateVersion = "23.11";
}
