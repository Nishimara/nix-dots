{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./tmux
      ./neovim
      ./xray
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp = {
    useTmpfs = true;
    cleanOnBoot = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # proud nvidia user
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; # sadly
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
  
  # i really hate mail ru lmao
  networking.extraHosts = ''
    0.0.0.0 ok.ru
    0.0.0.0 api.ok.ru
    0.0.0.0 r.mail.ru
    0.0.0.0 mail.ru
    0.0.0.0 api.mail.ru
  '';

  time.timeZone = "Europe/Moscow";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LC_ALL = "en_US.UTF-8";
    };
  };

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  fonts = { 
    packages = with pkgs; [
      nerdfonts
      monocraft
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "monocraft" ];
	      sansSerif = [ "monocraft" ];
	      monospace = [ "monocraft" ];
      };
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      substituters = [ "https://hyprland.cachix.org" ]; # this needed to not build hyprland package and its dependencies
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
  };

  environment.interactiveShellInit = ''
    export EDITOR=nvim
  '';

  xdg.portal= {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = "hyprland";
  };

  users.users.ayako = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    bat
    podman-compose
    vlc
    ffmpeg
    alsa-lib
    alsa-tools
    alsa-utils
    alsa-oss
    ntfs3g
    unzip
    htop
    man-pages
    man-pages-posix
    dig
    gnome3.adwaita-icon-theme
    wayland
    polkit-kde-agent
    killall
    xdg-utils
  ] ++ [ inputs.agenix.packages.${pkgs.system}.default ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
    "nvidia-x11"
  ];

  programs = {
    adb.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    fish.enable = true;
    gamemode.enable = true;
    steam = {
      package = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          mangohud
        ];
      };
      enable = true;
      gamescopeSession.enable = true;
    };
    # should be very concerned about this thing tho
    # it manages SYS_CAP_RESOURCE
    # probably want to move away to self-written rnnoise
    noisetorch.enable = true;
  };

  services = {
    blueman.enable = true;
    openssh.enable = true;
    fail2ban = {
      enable = true;
      maxretry= 3;
      bantime = "168h";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    udisks2.enable = true;
  };

  security = {
    pam.services.swaylock = {};

    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("wheel") && (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions"
            )
          )
          {
            return polkit.Result.YES;
          }
        })
      '';
    };

    doas.enable = true;
    sudo.enable = false;
    doas.extraRules = [{
      groups = ["wheel"];
      persist = true;
    }];
  };

  virtualisation = {
    oci-containers = {
      backend = "podman";
    };
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE connect
    ];
  };

  systemd.oomd.enable = true;

  system.stateVersion = "23.11";
}