{ pkgs, ... }:

let
  extensionsList = [
    "appindicator"
    "auto-move-windows"
    "blur-my-shell"
    "dash-to-dock"
    "disable-unredirect"
    "gsconnect"
    "media-controls"
    "pip-on-top"
    "rounded-window-corners"
  ];
in
{
  home.packages = builtins.map (x: pkgs.gnomeExtensions."${x}") extensionsList;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Adwaita";
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