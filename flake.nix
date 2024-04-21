{
  description = "Flake";

  inputs = {
    nixpkgs.url = "github:nixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";

    hyprland.url = "github:hyprwm/Hyprland";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, agenix, nixvim, hyprland, firefox-addons }@inputs: 
  let
    system = "x86_64-linux";

    # pin telegram to v4.15.2
    pkgs = nixpkgs.legacyPackages.${system}.extend (final: prev: {
      telegram-desktop = (import (builtins.fetchTree {
        type = "github";
        owner = "NixOS";
        repo = "nixpkgs";
        rev = "3f178e415639bd509b2cb09f9e56b7994f11ed17";
        narHash = "sha256-1Q0Tk3hBHfZ7RxK1YtcsUMfdUWLhqYCsy6bP1piEVOs=";
      }) { inherit system; }).pkgs.telegram-desktop;
    });
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./system

        hyprland.nixosModules.default {
          programs.hyprland.enable = true; #needed in system and in user configurations
        }

        agenix.nixosModules.default
      ];

      specialArgs = { inherit inputs; };
    };

    homeConfigurations."ayako" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./home
        nixvim.homeManagerModules.nixvim
      ];

      extraSpecialArgs = { inherit inputs; };
    };
  };
}