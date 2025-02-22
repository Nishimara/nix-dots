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

  nix = {
    nrBuildUsers = 64;
    settings = {
      trusted-users = [ "remotebuilder" ];

      min-free = 10 * 1024 * 1024;

      max-jobs = "auto";
      cores = 0;
    };
  };

  systemd.services.nix-daemon.serviceConfig = {
    MemoryAccounting = true;
    MemoryMax = "80%";
    OOMScoreAdjust = 500;
  };
}