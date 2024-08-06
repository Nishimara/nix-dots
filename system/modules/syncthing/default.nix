{ config, lib, ... }: {
  options.modules.syncthing.enable = lib.mkEnableOption "Enable syncthing";

  config = lib.mkIf config.modules.syncthing.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
    };
  };
}