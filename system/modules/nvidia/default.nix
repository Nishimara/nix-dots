{ config, lib, ... }:
{
  options.modules.nvidia.enable = lib.mkEnableOption "nvidia";

  config = lib.mkIf config.modules.nvidia.enable {
    hardware = {
      graphics.enable = true;

      nvidia = {
        modesetting.enable = true;
        open = false;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        nvidiaSettings = false;
      };
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    # with nvidia it's forbidden to sleep
    systemd.targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };
}