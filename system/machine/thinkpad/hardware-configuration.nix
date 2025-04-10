{ config, lib, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      luks.devices."luks-4999b589-d9f9-4921-b1e0-f793821e36b2".device = "/dev/disk/by-uuid/4999b589-d9f9-4921-b1e0-f793821e36b2";
      availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ ];
    };

    kernelParams = [
      # Force use of the thinkpad_acpi driver for backlight control.
      # This allows the backlight save/load systemd service to work.
      "acpi_backlight=native"

      # Needed for touchpad to work properly (click doesn't register by pushing down the touchpad).
      "psmouse.synaptics_intertouch=0"
    ];

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/0507ade3-69f9-4a8f-ae5d-3a4f8da76c6c";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd:5" "ssd" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/F55E-2D4D";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" "umask=0077" "nodev" "nosuid" ];
    };
  };

  swapDevices = [ ];
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}