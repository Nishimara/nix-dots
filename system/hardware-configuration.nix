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
      device = "/dev/disk/by-uuid/6b777328-7a9f-4993-9975-dbf108f9bbb9";
      fsType = "btrfs";
      options = [ "subvol=@" "ssd" ];
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

    "/home/ayako/Games" = {
      device = "/dev/disk/by-uuid/6b777328-7a9f-4993-9975-dbf108f9bbb9";
      fsType = "btrfs";
      options = [ "subvol=Games" "ssd" "compress=zstd" "nodev" "nosuid" ];
    };
  };

  swapDevices = [{
    device = "/dev/disk/by-partuuid/c488f151-05";
    randomEncryption.enable = true;
  }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}