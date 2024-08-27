{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/bundle.nix
  ];

  modules = {
    doh.enable = true;
    hosts.enable = true;
    podman.enable = true;
    nh.enable = true;
    nvidia.enable = true;
    nix.enable = true;
    sshd.enable = true;
    steam.enable = true;
    syncthing.enable = true;
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_zen;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Moscow";
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
  };

  fonts = { 
    packages = with pkgs; [
      noto-fonts
      (nerdfonts.override {
        fonts = [
          "Hack"
          "JetBrainsMono"
          "Iosevka"
          "NerdFontsSymbolsOnly"
        ];
      })

      # unicode
      unifont
    ];

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

  xdg.portal = {
    enable = true;
    config.common.default = [ "hyprland" ];
  };

  users.users.ayako = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    agenix
    vim
    wget
    git
    bat
    podman-compose
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
    polkit-kde-agent
    killall
    xdg-utils
    pavucontrol
    bubblewrap
    mangohud
    wl-clipboard
  ];

  programs = {
    adb.enable = true;
    droidcam.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    firejail.enable = true;
    fish.enable = true;

    gamescope = {
      enable = true;
#     capSysNice = true;
    };

    gamemode.enable = true;
  };

  services = {
    blueman.enable = true;
    
    greetd = {
      enable = true;

      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "greeter";
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    thermald.enable = true;
    udisks2.enable = true;
    zerotierone.enable = true;
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

    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        groups = [ "wheel" ];
        persist = true;
      }];
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 25565 ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE connect
    ];
  };

  system.stateVersion = "24.05";
}