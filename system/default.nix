{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./tmux
      ./neovim
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp = {
    useTmpfs = true;
    cleanOnBoot = true;
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
    layout = "us";
    xkbVariant = "";
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

    alias wttr="curl wttr.in"
    alias tb="nc termbin.com 9999"
  '';

  xdg.portal= {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = "hyprland";
  };

  sound.enable = true;

  users.users.ayako = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    kitty
    bat
    podman-compose
    vlc
    ffmpeg
    alsa-lib
    alsa-tools
    alsa-firmware
    alsa-oss
    yt-dlp
    keepassxc
    ntfs3g
    unzip
    ranger
    pavucontrol
    busybox
    htop
    pamixer
    man-pages
    man-pages-posix
    dig
    gnome3.adwaita-icon-theme
    wayland
  ];

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    adb.enable = true;
    fish.enable = true;
    # should be very concerned about this thing tho
    # it manages SYS_CAP_RESOURCE
    # probably want to move away to self-written rnnoise
    # noisetorch.enable = true;
  };

  services = {
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
  };

  security = {
    pam.services.swaylock = {};

    polkit.extraConfig = ''
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

    doas.enable = true;
    sudo.enable = false;
    doas.extraRules = [{
      groups = ["wheel"];
      persist = true;
    }];
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  systemd.oomd.enable = true;

  system.stateVersion = "23.11";
}