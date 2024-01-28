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
  ];

  programs.home-manager.enable = true;

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

    # gui
    hyprpaper
    grim
    slurp
    wl-clipboard
    mako
    telegram-desktop
    swaylock-effects
    gimp
    prismlauncher
    vesktop # discord with vencord
    feh # image viewing tool
    libnotify
    keepassxc

    # tools
    file
    pamixer # pulseaudio control
    ranger # file manager in terminal
    grc # needed for fish colorizing plugin
    eza # colorful ls

    # misc
    yt-dlp
    man-pages
    playerctl
  ];

  home.stateVersion = "24.05";
}