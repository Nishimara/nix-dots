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
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./system
        hyprland.nixosModules.default {
          programs.hyprland.enable = true; #needed in system and in user so the hyprland always up-to-date
        }
        agenix.nixosModules.default
      ];
      specialArgs = { inherit inputs; };
    };
    defaultPackage.${system} = home-manager.defaultPackage.${system};

    homeConfigurations."ayako" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        nixvim.homeManagerModules.nixvim
        ./home
      ];
      extraSpecialArgs = { inherit inputs; };
    };
  };
}