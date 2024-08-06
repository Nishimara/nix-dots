{ config, lib, ... }: {
  options.modules.podman.enable = lib.mkEnableOption "podman";

  config = lib.mkIf config.modules.podman.enable {
    virtualisation.podman = {
      enable = true;

      autoPrune = {
        enable = true;
        flags = [ "--all" ];
      };
    };

    hardware.nvidia-container-toolkit.enable = lib.mkIf config.modules.nvidia.enable true;
  };
}