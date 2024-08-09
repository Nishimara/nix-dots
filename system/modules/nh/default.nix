{ config, lib, pkgs, ... }: {
  options.modules.nh.enable = lib.mkEnableOption "Enable nh";

  config = lib.mkIf config.modules.nh.enable {
    programs.nh = {
      enable = true;
      
      package = pkgs.nh.overrideAttrs (prev: {
        patches = prev.patches ++ [
          # until https://github.com/viperML/nh/pull/92 is merged
          ./0001-Use-doas-over-sudo.patch
        ];
      });
      
      flake = "/etc/nixos";
      clean = {
        enable = true;
        extraArgs = "--keep-since 15d --keep 10";
      };
    };
  };
}