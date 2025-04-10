{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        layer = "top";
        position = "top";
        height = 42;
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "custom/media" ];
        modules-right = [ "pulseaudio" "cpu" "disk" "memory" "hyprland/language" "clock" "tray" ];

        "hyprland/workspaces" = {
          disable-scroll = true;
        };

        "hyprland/language" = {
          format = "{}";
          format-en = "en";
          format-ru = "ru";
        };

        "tray" = {
          icon-size = 18;
          spacing = 10;
        };

        "clock" = {
          format = "{:%d %h %Y %H:%M}";
          format-alt = "{:%d %h %Y %H:%M:%S}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              today = "<span color='#ff6699'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              months = "<span color='#ffead3'><b>{}</b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
          interval = 1;
        };

        "bluetooth" = {
          format = " {status}";
          format-disable = "";
          format-connected = " {num_connections}";
          tooltip-format = "{device_alias}";
          tooltip-format-connected = " {device_enumerate}";
          tooptip-format-enumerate-connected = "{device_alias}";
        };

        "cpu" = {
          format = " {usage}%";
          tooltip-format = "CPU";
        };

        "memory" = {
          format = "󰍛 {percentage}%";
          tooltip-format = "RAM {used} / {total} G";
        };

        "disk" = {
          interval = 10;
          format = " {percentage_used}%";
          tooltip-format = "{used} used out of {total} on {path}";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          tooltip = true;
          format-muted = " Muted";
          on-click = "pamixer -t";
          on-scroll-up = "amixer -q sset Master 5%+";
          on-scroll-down = "amixer -q sset Master 5%-";
          scroll-step = 5;
          format-icons = {
            headfone = "";
            headset = "";
            default = [ "" "" "" ];
          };
        };

        "custom/media" = {
          format = "{icon}<span background='#89b4fa' foreground='#0A1929'> {} </span>";
          format-icons = {
            Paused = "<span background='#fa89b4' foreground='#0A1929'>  </span>";
            Playing = "<span background='#fa89b4' foreground='#0A1929'>  </span>";
          };
          return-type = "json";
          escape = true;
          max-length = 40;
          exec = "playerctl -a metadata --format '{\"text\": \"{{markup_escape(artist)}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(artist)}} - {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          on-click = "playerctl play-pause";
          on-click-middle = "playerctl previous";
          on-click-right = "playerctl next";
          on-scroll-up = "playerctl volume 0.05+";
          on-scroll-down = "playerctl volume 0.05-";
        };
      };

   };
   style = ./style.css;
  };
}