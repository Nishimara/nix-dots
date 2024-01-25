{
  description = "Flake";

  inputs = {
    nixpkgs.url = "github:nixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, hyprland, hyprland-plugins }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      nixvimModule = nixvim.homeManagerModules.nixvim;
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [
          hyprland.nixosModules.default {
            programs.hyprland.enable = true; #needed in system and in user so the hyprland always up-to-date
          }
	        ./system
	      ];
      };
      defaultPackage.${system} = home-manager.defaultPackage.${system};

      homeConfigurations."ayako" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	      modules = [
	        ./home
          nixvimModule
        ];
        extraSpecialArgs = { inherit inputs; };
      };
  };
}