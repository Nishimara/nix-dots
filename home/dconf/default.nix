{ pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    pip-on-top
    dash-to-dock
    media-controls
    gnome-clipboard
#   user-themes
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Adwaita";
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "mediacontrols@cliffniff.github.com"
        "pip-on-top@rafostar.github.com"
        "rounded-window-corners@yilozt"
        "unredirect@vaina.lt"
#       "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
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