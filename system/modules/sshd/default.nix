{ config, lib, ... }: {
  options.modules.sshd.enable = lib.mkEnableOption "sshd";

  config = lib.mkIf config.modules.sshd.enable {
    services.openssh = {
      enable = true;

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        KbdInteractiveAuthentication = false;
      };
    };
  };
}
