{ config, lib, inputs, ... }: {
  options.modules.nix.enable = lib.mkEnableOption "Enable default settings for nix";

  config = lib.mkIf config.modules.nix.enable {
    nix = {
      channel.enable = false;

      registry = (lib.mapAttrs (_: flake: { inherit flake; }) inputs) // { n.flake = inputs.nixpkgs; };

      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;

        substituters = lib.mkForce [
          "https://nixos-cache-proxy.cofob.dev"
          "https://hyprland.cachix.org"
          "https://nishimara.cachix.org"
          "https://nix-gaming.cachix.org"
        ];

        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nishimara.cachix.org-1:QC+NoP8D4tsIicaGBXRwQVn9Pl26q77AFVbPkZKEmis="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        ];
      };

      extraOptions = ''
        warn-dirty = false
      '';

      optimise.automatic = true;
    };
  };
}