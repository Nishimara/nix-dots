{ config, lib, ... }: {
  options.modules.nix.enable = lib.mkEnableOption "Enable default settings for nix";

  config = lib.mkIf config.modules.nix.enable {
    nix = {
      channel.enable = false;

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
      optimise.automatic = true;
    };
  };
}