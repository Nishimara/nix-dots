{ pkgs, ... }:
let
  notify-mic-status = pkgs.writeShellScriptBin "notify-mic-status" ''
    mic_status=$(amixer get Capture | awk '/\[on\]/{print $6; exit}')

    if [ "$mic_status" == "[on]" ]; then
      notify-send "Mic unmuted"
    else
      notify-send "Mic muted"
    fi
  '';
in
{
  imports = [
    ./mako
    ./swaylock
    ./waybar
    ./wofi
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      monitor = ",preferred,auto,auto";

      env = [
        "MOZ_ENABLE_WAYLAND,1"
        "GDK_BACKEND,wayland"
        "NIXOS_OZONE_WL,1"
        "QT_QPA_PLATFORM,wayland-egl"
        "CLITTER_BACKEND,wayland"
        "SDL_VIDEODRIVER,wayland"
        "XCURSOR_SIZE,12"
        "GTK_THEME,Adwaita:dark"

        # tearing
#       "WLR_DRM_NO_ATOMIC,1" # only for kernel < 6.8

        # nvidia shit
#       "LIBVA_DRIVER_NAME,nvidia"
#       "XDG_SESSION_TYPE,wayland"
#       "GBM_BACKEND,nvidia-drm"
#       "__GLX_VENDOR_LIBRARY_NAME,nvidia"
#       "WLR_NO_HARDWARE_CURSORS,1"
      ];

      exec-once = [
        "hyprpaper"
        "mako"
        "waybar"
        "[workspace 1 silent] firefox"
        "[workspace 2 silent] telegram-desktop"
        "[workspace 3 silent] foot"
        "[workspace 4 silent] vesktop"
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
#       allow_tearing = true;
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

      gestures = {
        workspace_swipe = "off";
      };

      misc = {
        no_direct_scanout = false;
      };

      windowrulev2 = [
        "float, class:^(org.kde.polkit-kde-authentication-agent-1)$"

        "float, class:^(org.telegram.desktop|telegramdesktop)$,title:^(Media viewer)$"
        "fullscreen, class:^(org.telegram.desktop|telegramdesktop)$,title:^(Media viewer)$"

        "workspace 4, class:vesktop"
        "float, class:^(vesktop)$,initialTitle:^(Discord Popout)$"
        "float, class:^(firefox)$,title:^(Picture-in-Picture)$"

        "float, class:^(steam)$,title:^(Screenshot Manager)$"
        "float, class:^(steam)$,title:^(Friends List)$"

#       "immediate, fullscreen:1"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindr = [
        "$mod, G, exec, pkill wofi || wofi --show drun"
        "$mod, Y, exec, pkill -SIGUSR1 waybar" # hide/unhide waybar
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, amixer -q sset Master 5%+"
        ", XF86AudioLowerVolume, exec, amixer -q sset Master 5%-"
      ];

      bind = [
        "$mod, I, exec, foot"
        "$mod, Q, killactive,"
        "$mod SHIFT, Q, exit,"
        "$mod, E, exec, nautilus"
        "$mod, V, toggleFloating,"
        "$mod, P, pseudo," #dwindle
        "$mod, J, togglesplit," #dwindle
        "CTRL, Print, exec, grimblast --notify copysave output \"$HOME/Pictures/Screenshots/Screenshot from $(date +%Y-%m-%d\\ %H-%M-%S).png\""
        ", Print, exec, grimblast --notify --freeze copysave area \"$HOME/Pictures/Screenshots/Screenshot from $(date +%Y-%m-%d\\ %H-%M-%S).png\""
        "$mod, L, exec, swaylock -e"
        ", F8, exec, amixer set Capture toggle && ${notify-mic-status}/bin/notify-mic-status"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

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
    preload = ${../../../imgs/wallpaper.jpg}

    wallpaper = ,${../../../imgs/wallpaper.jpg}
    ipc = off
  '';
}