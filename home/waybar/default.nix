{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        layer = "top";
        position = "top";
        height = 42;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
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
      };
    };
    style = ./style.css;
  };
}