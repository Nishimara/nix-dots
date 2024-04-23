{ ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      include = "${./mocha.conf}";
      mouse_hide_wait = "2.0";
      font_family = "jetbrains mono nerd font";
      font_size = 14;
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      cursor_shape = "block";
      url_color = "#0087bd";
      url_style = "dotted";
      confirm_os_window_close = 0;
      background_opacity = "0.8";

      tab_powerline_style = "angled";
      active_tab_background = "#040D12";
      active_tab_foreground = "#93B1A6";
      inactive_tab_background = "#183D3D";
      inactive_tab_foreground = "#93B1A6";

      foreground = "#93B1A6";
      background = "#040D12";
    };
  };
}