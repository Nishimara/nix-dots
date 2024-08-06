{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/bundle.nix
  ];

  modules.nvidia.enable = true;

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
    nameservers = [ "127.0.0.1" "::1" ];
    dhcpcd.extraConfig = "nohook resolv.conf";
    networkmanager.dns = "none";
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };

  # i really hate mail ru lmao
  networking.hosts = {
    "0.0.0.0" = [
      "ok.ru"
      "api.ok.ru"
      "r.mail.ru"
      "mail.ru"
      "api.mail.ru"

      "overseauspider.yuanshen.com"
      "log-upload-os.hoyoverse.com"
      "log-upload-os.mihoyo.com"
      "dump.gamesafe.qq.com"

      "log-upload.mihoyo.com"
      "devlog-upload.mihoyo.com"
      "uspider.yuanshen.com"
      "osuspider.yuanshen.com"
      "sg-public-data-api.hoyoverse.com"
      "ys-log-upload-os.hoyoverse.com"
      "public-data-api.mihoyo.com"

      "prd-lender.cdp.internal.unity3d.com"
      "thind-prd-knob.data.ie.unity3d.com"
      "thind-gke-usc.prd.data.corp.unity3d.com"
      "cdp.cloud.unity3d.com"
      "remote-config-proxy-prd.uca.cloud.unity3d.com"
    ];
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
      jetbrains-mono
      noto-fonts
      (nerdfonts.override {
        fonts = [
          "Hack"
          "Iosevka"
          "NerdFontsSymbolsOnly"
        ];
      })
      monocraft

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
        "JetBrains Mono NL Light"
        "Symbols Nerd Font Mono"
        "Monocraft"
      ];
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;

      substituters = [
        "https://hyprland.cachix.org"
        "https://nix-gaming.cachix.org"
      ];

      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
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

    steam = {
      package = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          mangohud
        ];
        extraEnv = {
          # support cyrillic symbols
          LANG = "ru_RU.UTF-8";
        };
        extraBwrapArgs = [
          "--bind $HOME/steamhome $HOME"
          "--bind $HOME/Games/Steam $HOME/.local/share/Steam"
        ];
      };

      enable = true;
    };
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
    
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
    
    fail2ban.enable = true;
    
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    
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

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    
    defaultNetwork.settings.dns_enabled = true;

    autoPrune = {
      enable = true;
      flags = [ "--all" ];
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

  systemd.oomd.enable = true;

  system.stateVersion = "24.05";
}