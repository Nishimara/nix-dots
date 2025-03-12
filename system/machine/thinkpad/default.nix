{ pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./remotebuilder.nix
    ../../modules
  ];

  modules = {
    doh.enable = true;
    gnome.enable = true;
    hosts.enable = true;
    podman.enable = true;
    nh.enable = true;
    nix.enable = true;
    sshd.enable = true;
    steam.enable = true;
    syncthing.enable = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
  };

  networking = {
    hostName = "thinkpad";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Moscow";

  console = {
    font = "Lat2-Terminus16";
  };

  fonts = { 
    packages = with pkgs; [
      noto-fonts

      # unicode
      unifont
    ] ++ (with nerd-fonts; [
      hack
      jetbrains-mono
      iosevka
      symbols-only
    ]);

    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif"
        "Symbols Nerd Font"
      ];
      sansSerif = [
        "Noto Sans"
        "Symbols Nerd Font"
      ];
      monospace = [
        "Hack Nerd Font Mono"
        "Iosevka Nerd Font Mono"
        "JetBrainsMono Nerd Font NL Light"
        "Symbols Nerd Font Mono"
      ];
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "all" ];
  };

  services = {
#   auto-cpufreq.enable = true;
    power-profiles-daemon.enable = lib.mkForce false;

    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    fstrim.enable = true;
    tlp = {
      enable = true;

      settings = {
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balanced";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        AMDGPU_ABM_LEVEL_ON_AC = 0;
        AMDGPU_ABM_LEVEL_ON_BAT = 0;

        RADEON_DPM_PERF_LEVEL_ON_AC = "high";
        RADEON_DPM_PERF_LEVEL_ON_BAT = "high";

        RADEON_DPM_STATE_ON_AC = "performance";
        RADEON_DPM_STATE_ON_BAT = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_BAT = 0;
        CPU_MAX_PERF_BAT = 40;

        START_CHARGE_THRESH_BAT0 = 85;
        STOP_CHARGE_THRESH_BAT0 = 95;
      };
    };
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  security = {
    rtkit.enable = true;
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        persist = true;
        groups = [ "wheel" ];
      }];
    };
  };

  users.users.ayako = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    agenix
    btop
    git
    killall
    neovim
    sbctl
    wget
  ];

  programs = {
    adb.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    firejail.enable = true;
    fish.enable = true;
    nano.enable = false;
  };

  networking.firewall = {
    allowedTCPPorts = [
      57621 # spotify sync
    ];
    allowedUDPPorts = [
      5353 # spotify discovery
    ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };

  system.stateVersion = "24.11";
}