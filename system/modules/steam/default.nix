{ config, lib, pkgs, ... }: {
  options.modules.steam.enable = lib.mkEnableOption "Enable steam";

  config = lib.mkIf config.modules.steam.enable {
    programs.steam = {
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

      localNetworkGameTransfers.openFirewall = true;

      gamescopeSession = {
        enable = true;
        args = [
          "-W 1920"
          "-H 1080"
          "--force-grab-cursor"
          "--expose-wayland"
        ];
        env = {
          XKB_DEFAULT_LAYOUT = "us,ru";
          XKB_DEFAULT_OPTIONS = "grp:lalt_lshift_toggle";
        };
      };
    };
  };
}