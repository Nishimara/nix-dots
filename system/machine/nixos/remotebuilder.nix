{ ... }: {
  users = {
    users.remotebuilder = {
      isNormalUser = true;
      createHome = false;
      group = "remotebuilder";

      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHhVtMgHvh+9llT0wtGz9bH1O8chr0V7UBoP1plCoMm" ];
    };

    groups.remotebuilder = {};
  };

  nix.settings.trusted-users = [ "remotebuilder" ];
}