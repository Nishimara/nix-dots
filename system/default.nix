{ pkgs, inputs, ... }:

{
  imports = [ ./bundle.nix ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };
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
      "sg-public-data-api.hoyoverse.com"
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
    supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
    };
  };

  fonts = { 
    packages = with pkgs; [
      jetbrains-mono
      noto-fonts
      (nerdfonts.override {
        fonts = [
          "NerdFontsSymbolsOnly"
          "Hack"
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
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
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
    pavucontrol
  ] ++ [ inputs.agenix.packages.${pkgs.system}.default ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
    "nvidia-x11"
    "zerotierone"
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
#     capSysNice = true; # broken? atleast require program penetration
    };
    gamemode.enable = true;
    steam = {
      package = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          mangohud

          # needed for gamescope
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
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
      gamescopeSession.enable = true;
    };
  };

  services = {
    blueman.enable = true;
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
    fail2ban = {
      enable = true;
      maxretry = 3;
      bantime = "168h";
    };
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

    doas.enable = true;
    sudo.enable = false;
    doas.extraRules = [{
      groups = [ "wheel" ];
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