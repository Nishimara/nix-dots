{ pkgs, ... }:
{
  imports = [ ./bundle.nix ];

  programs = {
    feh.enable = true;
    home-manager.enable = true;
    obs-studio.enable = true;
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
    };
    pointerCursor = {
      name = "Adwaita";
      size = 16;
      package = pkgs.gnome3.adwaita-icon-theme;
    };
  };

  home.packages = with pkgs; [
    # development
    gnumake
    clang
    clang-tools
    nil
    nixpkgs-fmt

    # gui
    hyprpaper
    grimblast # screenshots
    telegram-desktop
    gimp
    prismlauncher # minecraft
    vesktop # discord with vencord
    libnotify
    keepassxc # password manager
    qbittorrent
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    gnome.eog # image viewer
    gnome.nautilus # file manager
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

    # tools
    file
    fd # user-friendly find
    grc # needed for fish colorizing plugin
    pamixer # pulseaudio control
    ranger # file manager in terminal
    ripgrep
    wl-clipboard
    xclip

    # misc
    cmus # music
    man-pages
#   mindustry-wayland # ahh games
    playerctl # control media
  ];

  home.stateVersion = "24.05";
}