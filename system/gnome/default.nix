{ pkgs, inputs, ... }:
{
  hardware.pulseaudio.enable = false;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    gnome-terminal
    epiphany
    geary
    evince
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix
  ]);

  environment.systemPackages = with pkgs.gnome; [
    gnome-tweaks
  ];

  services.udev.packages = with pkgs; [
    gnome.gnome-settings-daemon
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "gnome";
  };

  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = false;
        };
      };  
      desktopManager.gnome.enable = true;
      excludePackages = with pkgs; [ xterm ];
    };
    displayManager.sessionPackages = [ inputs.hyprland.packages.${pkgs.system}.hyprland ];
  };
}