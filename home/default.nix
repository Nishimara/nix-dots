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
    hyprpaper
    grim
    slurp
    wl-clipboard
    mako
    wofi
    telegram-desktop
    swaylock-effects
    gimp
    prismlauncher
    vesktop
    bun
    feh
    clang
    clang-tools
    file
    gnumake
    grc # needed for fish colorizing plugin
    eza # colorful ls
    libnotify
    playerctl
    man-pages
  ];

  home.stateVersion = "24.05";
}