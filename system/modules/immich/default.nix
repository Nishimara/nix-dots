{ config, lib, ... }: {
  options.modules.immich.enable = lib.mkEnableOption "Enable immich";

  config = lib.mkIf config.modules.immich.enable {
    services.immich = {
      enable = true;

      openFirewall = true;
      host = "0.0.0.0";

      accelerationDevices = [ "/dev/dri/renderD128" ];
    };

    users.users.immich.extraGroups = [ "video" "render" ];
  };
}