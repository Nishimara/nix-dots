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
  ];

  programs = {
    home-manager.enable = true;
    obs-studio.enable = true;
  };

  services = {
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
    bun # typescript
    gnumake
    clang
    clang-tools
    python3Minimal

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

    # tools
    file
    pamixer # pulseaudio control
    ranger # file manager in terminal
    grc # needed for fish colorizing plugin
    eza # colorful ls
    fd # user-friendly find
    wl-clipboard
    btop # amazing top
    wineWowPackages.waylandFull

    # misc
    yt-dlp
    man-pages
    playerctl # control media
  ];

  home.stateVersion = "24.05";
}