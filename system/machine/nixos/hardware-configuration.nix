{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];

    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/69d44200-f0a1-4e02-afa2-11ca83a24a09";
      fsType = "btrfs";
      options = [ "subvol=@" "ssd" "compress=zstd" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/E92D-47BE";
      fsType = "vfat";
      options = [ "umask=077" "nodev" "nosuid" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/be118546-895f-4e8b-8e93-8939d149b1ff";
      fsType = "ext4";
      options = [ "nodev" "nosuid" ];
    };

    "/var/lib/immich" = {
      device = "/dev/disk/by-uuid/66381039-13ec-4aa5-9282-3fec7805491e";
      fsType = "ext4";
      options = [ "nodev" "nosuid" "noexec" ];
    };
  };

  swapDevices = [];
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}