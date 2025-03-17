{ config, lib, ... }: {
  options.modules.tailscale.enable = lib.mkEnableOption "Enable tailscale";

  config = lib.mkIf config.modules.tailscale.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
    };
  };
}