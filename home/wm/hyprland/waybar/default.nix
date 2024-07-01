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
        modules-right = [ "pulseaudio" "pulseaudio#microphone" "cpu" "disk" "memory" "hyprland/language" "clock" "tray" ];

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

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = " Muted";
          on-click = "amixer set Capture toggle";
          on-scroll-up = "amixer -q sset Capture 5%+";
          on-scroll-down = "amixer -q sset Capture 5%-";
          scoll-step = 5;
        }; #thanks to https://github.com/Cybersnake223/Hypr
        
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