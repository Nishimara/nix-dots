{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings.env = [
    "HYPRCURSOR_THEME,catppuccin-mocha-mauve-cursors"
    "HYPRCURSOR_SIZE,18"
  ];

  # xcursor
  home.pointerCursor = {
    name = "catppuccin-mocha-mauve-cursors";
    package = pkgs.catppuccin-cursors.mochaMauve;
    size = 18;

    gtk.enable = true;
    x11.enable = true;
  };
}