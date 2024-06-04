{ pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    dash-to-dock
    gnome-clipboard
    media-controls
    pip-on-top
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Adwaita";
    };
    "org/gnome/shell" = {
      disabled-user-extensions = false;

      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "blur-my-shell@aunetx"
        "dash-to-dock@micxgx.gmail.com"
        "mediacontrols@cliffniff.github.com"
        "pip-on-top@rafostar.github.com"
        "rounded-window-corners@yilozt"
        "unredirect@vaina.lt"
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