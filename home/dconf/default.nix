{ pkgs, ... }:

let
  extensionsList = [
    "appindicator"
    "auto-move-windows"
    "blur-my-shell"
    "caffeine"
    "dash-to-dock"
    "disable-unredirect"
    "gsconnect"
    "media-controls"
    "pip-on-top"
    "rounded-window-corners-reborn"
  ];
in
{
  home.packages = builtins.map (x: pkgs.gnomeExtensions."${x}") extensionsList;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-input-source = [ "<Shift>Alt_L" ];
      switch-input-source-backward = [ "<Alt>Shift_L" ];
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = builtins.map (x: pkgs.gnomeExtensions."${x}".extensionUuid) extensionsList;
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}