{ ... }: {
  nix.buildMachines  = [{
    hostName = "builder";
    system = "x86_64-linux";
    protocol = "ssh-ng";
    maxJobs = 3;
    speedFactor = 2;
    supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    mandatoryFeatures = [ ];
  }];

  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;
}
