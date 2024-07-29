{ config, pkgs, lib, ... }:
{
  options.modules.gnome.enable = lib.mkEnableOption "gnome";

  config = lib.mkIf config.modules.gnome.enable {
    hardware.pulseaudio.enable = false;

    environment.gnome.excludePackages = (with pkgs; [
      baobab # disk usage analyzer
      cheese # webcam view
      epiphany # browser
      file-roller # archive manager
      geary # email client
      gedit # gui text editor
      gnome-photos
      gnome-tour # gnome guide
      seahorse # password manager
      totem # video player
      yelp # help viewer

      gnome-terminal
    ]) ++ (with pkgs.gnome; [
      atomix # game
      hitori # game
      iagno # game
      tali # game

      gnome-characters
      gnome-music
    ]);

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
        excludePackages = with pkgs; [ xterm ];
      };
    };
  };
}