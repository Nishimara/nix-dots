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

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, agenix, nixvim, hyprland, lanzaboote, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./system/machine/nixos

        hyprland.nixosModules.default {
          programs.hyprland.enable = true; #needed in system and in user configurations
        }

        agenix.nixosModules.default
      ];

      specialArgs = { inherit inputs; };
    };

    nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./system/machine/thinkpad
        lanzaboote.nixosModules.lanzaboote
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