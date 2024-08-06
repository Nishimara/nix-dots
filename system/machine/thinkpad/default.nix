{ pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/bundle.nix
  ];

  modules.gnome.enable = true;

  boot = {
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

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

  nix = {
    settings = {
      experimental-features = [ "flakes" "nix-command" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    optimise.automatic = true;
  };

  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    displayManager = {
      defaultSession = "gnome";
      autoLogin = {
        enable = true;
        user = "ayako";
      };
    };

    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    agenix
    btop
    neovim
    sbctl
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "24.05";
}