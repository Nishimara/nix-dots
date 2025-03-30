{ pkgs, ... }:
let
  notify-mic-status = pkgs.writeShellScript "notify-mic-status.sh" ''
    mic_status=$(${pkgs.alsa-utils}/bin/amixer get Capture | ${pkgs.gawk}/bin/awk '/\[on\]/{print $6; exit}')

    if [ "$mic_status" == "[on]" ]; then
      ${pkgs.libnotify}/bin/notify-send "Mic unmuted"
    else
      ${pkgs.libnotify}/bin/notify-send "Mic muted"
    fi
  '';
in
{
  imports = [
    ./mako
    ./swaylock
    ./waybar
    ./wofi
    ./hypridle
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
      ];

      exec-once = [
        "hyprpaper"
        "mako"
        "waybar"
        "[workspace 1 silent] librewolf"
        "[workspace 2 silent] materialgram"
        "[workspace 3 silent] foot"
        "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"

        "tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE \"$HYPRLAND_INSTANCE_SIGNATURE\""
      ];

      input = {
        kb_layout = "us,ru";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:alt_shift_toggle";
        kb_rules = "";

        follow_mouse = 1;
        accel_profile = "flat";

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

      render = {
        direct_scanout = true;
      };

      windowrulev2 = [
        "float, class:^(org.kde.polkit-kde-authentication-agent-1)$"

        "float, class:^(io.github.kukuruzka165.materialgram)$,title:^(Media viewer)$"
        "fullscreen, class:^(io.github.kukuruzka165.materialgram)$,title:^(Media viewer)$"

        "workspace 4, class:vesktop"
        "float, class:^(vesktop)$,initialTitle:^(Discord Popout)$"
        "float, class:^(librewolf)$,title:^(Picture-in-Picture)$"
        "pin, class:$(librewolf)$,title:^(Picture-in-Picture)$"

        "float, class:^(steam)$,title:^(Screenshot Manager)$"
        "float, class:^(steam)$,title:^(Friends List)$"

        "fullscreen, initialClass:^steam_app_\\d+$"
        "fullscreen, initialClass:^gamescope$"
        "noborder, initialClass:^steam_app_\\d+$"
        "noborder, initialClass:^gamescope$"
        "rounding 0, initialClass:^steam_app_\\d+$"
        "rounding 0, initialClass:^gamescope$"
        "immediate, initialClass:^steam_app_\\d+$"
        "immediate, initialClass:^gamescope$"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindr = [
        "$mod, G, exec, pkill wofi || wofi --show drun"
        "$mod, Y, exec, pkill -SIGUSR1 waybar" # hide/unhide waybar
        "$mod, F, fullscreen, 0"
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
        ", F8, exec, amixer set Capture toggle && ${notify-mic-status}"

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

  services.hyprpaper = let
    wallpaper = builtins.fetchurl {
      url = "https://livewallp.com/wp-content/uploads/2023/02/JK-in-the-reeds.png";
      sha256 = "sha256:0vpx9vr4s4a5n4xqmhc7h9j5s3n7y1s9ps0azfdxipkgqxr5w400";
    };
  in {
    enable = true;

    settings = {
      preload = [ wallpaper ];

      wallpaper = [ ",${wallpaper}" ];

      ipc = false;
    };
  };
}