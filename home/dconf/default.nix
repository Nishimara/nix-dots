{ pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    pip-on-top
    dash-to-dock
    media-controls
    gnome-clipboard
#   user-themes
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "rounded-window-corners@yilozt"
        "pip-on-top@rafostar.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "unredirect@vaina.lt"
        "mediacontrols@cliffniff.github.com"
        "eepresetselector@ulville.github.io"
        "appindicatorsupport@rgcjonas.gmail.com"
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

    gtk3.extraConfig.Settings = "gtk-application-prefer-dark-theme=1";
    gtk4.extraConfig.Settings = "gtk-application-prefer-dark-theme=1";
  };
}