{ system, pkgs, config, ... }:
{
  imports = [
    ./waybar
    ./nixvim
    ./bat
    ./kitty
    ./fish
    ./git
    ./hyprland
    ./firefox
    ./wofi
    ./mako
    ./swaylock
    ./vsc
    ./dconf
    ./yt-dlp
  ];

  programs = {
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

    # gui
    hyprpaper
    grimblast # screenshots
    telegram-desktop
    gimp
    prismlauncher # minecraft
    vesktop # discord with vencord
    feh # image viewing tool
    libnotify
    keepassxc # password manager
    qbittorrent
    gnome.eog # image viewer
    gnome.nautilus # file manager
    (lutris-free.override {
      extraLibraries = pkgs: [
        libadwaita
        pango
        gtk4
      ];
      extraPkgs = pkgs: [
        mangohud
        bubblewrap
        gamemode
        gamescope
      ];
    }) # yay windows games (dont forget bubblewrap for them)
    spotube # spotify without electron wow

    # tools
    file
    pamixer # pulseaudio control
    ranger # file manager in terminal
    grc # needed for fish colorizing plugin
    eza # colorful ls
    fd # user-friendly find
    wl-clipboard
    btop # amazing top

    # misc
    man-pages
    playerctl # control media
    mindustry-wayland # ahh games
  ];

  home.stateVersion = "24.05";
}