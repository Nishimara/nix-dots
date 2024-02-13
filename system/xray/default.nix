{ config, pkgs, ... }:
{
  age = {
    secrets = {
      xray = {
        name = "xray.json";
        file = ../../secrets/xray.age;
        mode = "440";
      };
    };
    identityPaths = [ "/root/.ssh/secrets" ];
  };

  services.xray = {
    enable = true;
    settingsFile = config.age.secrets.xray.path;
  };

  # dummy way but i don't have any other solutions
  systemd.services.xray.serviceConfig = {
    LoadCredential = "config.json:${config.age.secrets.xray.path}";
    ExecStart = pkgs.lib.mkForce "${pkgs.xray}/bin/xray -c \${CREDENTIALS_DIRECTORY}/config.json";
  };
}