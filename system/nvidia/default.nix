{ pkgs, ... }:
{
  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = false;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  # with nvidia it's forbidden to sleep
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
}