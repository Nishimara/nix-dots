{ config, lib, ... }: {
  options.modules.tailscale.enable = lib.mkEnableOption "Enable tailscale";

  config = lib.mkIf config.modules.tailscale.enable {
    services.tailscale = {
      enable = true;
      permitCertUid = "caddy";
    };

    services.caddy = {
      enable = true;

      virtualHosts."https://nixos.tail938297.ts.net".extraConfig = ''
        tls {
          get_certificate tailscale
        }

        reverse_proxy http://${config.services.immich.host}:${builtins.toString config.services.immich.port}
      '';
    };
  };
}