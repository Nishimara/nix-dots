{ pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      csgo-vulkan-fix
    ];

    settings = {
      "$mod" = "SUPER";

      monitor = ",preferred,auto,auto";

      env = [
        "MOZ_ENABLE_WAYLAND,1"
        "_JAVA_AWT_WM_NONREPARENTING,1"
        "GDK_BACKEND,wayland"
        "NIXOS_OZONE_WL,1"
        "QT_QPA_PLATFORM,wayland-egl"
        "CLITTER_BACKEND,wayland"
        "SDL_VIDEODRIVER,wayland"
        "XCURSOR_SIZE,12"
        "GTK_THEME,Adwaita:dark"
      ];

      exec-once = [
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.mako}/bin/mako"
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.firefox}/bin/firefox"
        "${pkgs.telegram-desktop}/bin/telegram-desktop"
        "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
      ];

      input = {
        kb_layout = "us,ru";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:alt_shift_toggle";
        kb_rules = "";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = "no";
        };
          
        sensitivity = "0";
      };

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };

      decoration = {
        rounding = 10;
        blur = {};
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_is_master = true;
      };

      gestures = {
        workspace_swipe = "off";
      };

      windowrulev2 = [
        "float, class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "float, class:^(org.telegram.desktop|telegramdesktop)$,title:^(Media viewer)$"
        "fullscreen, class:^(org.telegram.desktop|telegramdesktop)$,title:^(Media viewer)$"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        "$mod, I, exec, kitty"
        "$mod, Q, killactive,"
        "$mod SHIFT, Q, exit,"
        "$mod, E, exec, thunar"
        "$mod, V, toggleFloating,"
        "$mod, G, exec, wofi --show drun"
        "$mod, P, pseudo," #dwindle
        "$mod, J, togglesplit," #dwindle
        "CTRL, Print, exec, grimblast copysave area ~/Pictures/Screenshots/Screenshot\ from\ $(date +Y-%m-%d\ %H-%M-%S).png --notify"
        ", Print, exec, grimblast copysave output ~/Pictures/Screenshots/Screenshot\ from\ $(date +Y-%m-%d\ %H-%M-%S).png --notify"
        "$mod, L, exec, swaylock -e -i ${../../imgs/screenlock.png}"
        ", F8, exec, amixer set Capture toggle"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        ", XF86AudioRaiseVolume, exec, amixer -q sset Master 5%+"
        ", XF86AudioLowerVolume, exec, amixer -q sset Master 5%-"
        ", XF86AudioMicMute, exec, amixer set Capture toggle"
        ", XF86AudioMute, exec, amixer set Master toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ] ++ (
      # workspaces
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      builtins.concatLists (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in [
          "$mod, ${ws}, workspace, ${toString (x + 1)}"
          "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        ]
      ) 10));
    };
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${../../imgs/wallpaper.jpg}

    wallpaper = ,${../../imgs/wallpaper.jpg}
    ipc = off
  '';
}