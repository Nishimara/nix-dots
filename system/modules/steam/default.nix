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
    };
  };
}