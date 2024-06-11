{ pkgs, inputs, ... }:
{
  hardware.pulseaudio.enable = false;

  environment.gnome.excludePackages = (with pkgs; [
    gedit # gui text editor
    gnome-photos
    gnome-tour # gnome guide
  ]) ++ (with pkgs.gnome; [
    atomix # game
    baobab # disk usage analyzer
    cheese # webcam view
    epiphany # browser
    file-roller # archive manager
    geary # email client
    hitori # game
    iagno # game
    seahorse # password manager
    totem # video player
    tali # game
    yelp # help viewer

    gnome-characters
    gnome-terminal
    gnome-music
  ]);

  environment.systemPackages = with pkgs.gnome; [
    gnome-tweaks
  ];

  services.udev.packages = with pkgs; [
    gnome.gnome-settings-daemon
  ];

  xdg.portal = {
    enable = true;
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