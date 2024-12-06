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

  nix.gc = {
    automatic = true;
    options = "-d";
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
    # development
    gnumake
    clang
    clang-tools
    nil

    # gui
    grimblast # screenshots
    gimp
    prismlauncher # minecraft
    vesktop # discord with vencord
    libreoffice-qt
    librewolf
    libnotify
    keepassxc # password manager
    qbittorrent
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    element-desktop
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
    man-pages
    playerctl # control media
  ];

  home.stateVersion = "24.05";
}