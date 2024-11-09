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

    nix-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, agenix, nixvim, hyprland, lanzaboote, nix-programs-sqlite, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;

      overlays = [
        agenix.overlays.default
      ];

      config = {
        allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "steam"
          "steam-unwrapped"
          "steam-run"
          "nvidia-x11"
        ];
      };
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system pkgs;

      modules = [
        ./system/machine/nixos
        agenix.nixosModules.default
        hyprland.nixosModules.default {
          programs.hyprland.enable = true; #needed in system and in user configurations
        }
        nix-programs-sqlite.nixosModules.programs-sqlite
      ];

      specialArgs = { inherit inputs; };
    };

    nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
      inherit pkgs;

      modules = [
        ./system/machine/thinkpad
        agenix.nixosModules.default
        lanzaboote.nixosModules.lanzaboote
        nix-programs-sqlite.nixosModules.programs-sqlite
      ];

      specialArgs = { inherit inputs; };
    };

    homeConfigurations.ayako = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./home
        nixvim.homeManagerModules.nixvim
      ];

      extraSpecialArgs = { inherit inputs; };
    };
  };
}