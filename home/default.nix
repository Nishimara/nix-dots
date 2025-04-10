{ pkgs, ... }:
{
  imports = [ ./bundle.nix ];

  programs = {
    feh.enable = true;
    fzf.enable = true;
    home-manager.enable = true;
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
        obs-pipewire-audio-capture
        obs-vaapi
      ];
    };
    mpv.enable = true;
  };

  services = {
    easyeffects.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    mpris-proxy.enable = true; # control audio via bluetooth headphones buttons
  };

  home = {
    username = "ayako";
    homeDirectory = "/home/ayako";

    sessionVariables = {
      EDITOR = "nvim";

      # for gamescope
      XKB_DEFAULT_LAYOUT = "us,ru";
      XKB_DEFAULT_OPTIONS = "grp:lalt_lshift_toggle";
    };
  };

  home.packages = with pkgs; [
    # gui
    fractal # matrix
    grimblast # screenshots
    gimp
    prismlauncher # minecraft
    vesktop # discord with vencord
    libreoffice-qt
    libnotify
    keepassxc # password manager
    qbittorrent
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    eog # image viewer
    materialgram
    nautilus # file manager
    (lutris-free.override {
      extraLibraries = _: [
        libadwaita
        pango
        gtk4
      ];
      extraPkgs = _: [
        mangohud
        bubblewrap
        gamemode
        gamescope
      ];
    }) # yay windows games (dont forget bubblewrap for them)
    vlc

    # tools
    file
    fd # user-friendly find
    grc # needed for fish colorizing plugin
    pamixer # pulseaudio control
    ripgrep
    wl-clipboard

    # misc
    cmus # music
    graphite-gtk-theme
    graphite-kde-theme
    man-pages
    playerctl # control media
  ];

  home.stateVersion = "24.11";
}