{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings.env = [
    "HYPRCURSOR_THEME,catppuccin-mocha-mauve-cursors"
    "HYPRCURSOR_SIZE,24"
  ];

  # xcursor
  home.pointerCursor = {
    name = "catppuccin-mocha-mauve-cursors";
    package = pkgs.catppuccin-cursors.mochaMauve;
    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };
}