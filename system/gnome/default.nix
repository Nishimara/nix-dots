{ pkgs, ... }:
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

  services = {
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      excludePackages = with pkgs; [ xterm ];
    };
  };
}