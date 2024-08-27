{ config, pkgs, lib, ... }:
{
  options.modules.gnome.enable = lib.mkEnableOption "gnome";

  config = lib.mkIf config.modules.gnome.enable {
    hardware.pulseaudio.enable = false;

    environment.gnome.excludePackages = with pkgs; [
      atomix # game
      baobab # disk usage analyzer
      cheese # webcam view
      epiphany # browser
      file-roller # archive manager
      geary # email client
      gedit # gui text editor
      gnome-characters
      gnome-music
      gnome-photos
      gnome-terminal
      gnome-tour # gnome guide
      hitori # game
      iagno # game
      seahorse # password manager
      tali # game
      totem # video player
      yelp # help viewer
    ];

    environment.systemPackages = with pkgs; [
      gnome-tweaks
    ];

    services.udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];

    services = {
      xserver = {
        enable = true;
        desktopManager.gnome.enable = true;
        displayManager.gdm.enable = true;
        excludePackages = with pkgs; [ xterm ];
      };
    };
  };
}