{ pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/bundle.nix
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
    auto-cpufreq.enable = true;
    power-profiles-daemon.enable = lib.mkForce false;

    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
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
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };

  system.stateVersion = "24.05";
}