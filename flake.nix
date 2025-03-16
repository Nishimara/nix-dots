{
  description = "Flake";

  inputs = {
    # https://github.com/nixOS/nixpkgs/tree/nixos-unstable
    nixpkgs.url = "github:nixOS/nixpkgs/nixos-unstable";

    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/ryantm/agenix
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };

    # https://github.com/nix-community/nixvim
    nixvim.url = "github:nix-community/nixvim";

    # https://github.com/hyprwm/Hyprland
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # https://gitlab.com/rycee/nur-expressions/-/tree/master/pkgs/firefox-addons
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/nix-community/lanzaboote/tree/v0.4.2
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/wamserma/flake-programs-sqlite
    nix-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/gerg-l/spicetify-nix
    spicetify = {
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/catppuccin/vscode
    catppuccin-vsc = {
      url = "github:catppuccin/vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, agenix, nixvim, hyprland, lanzaboote, nix-programs-sqlite, spicetify, catppuccin-vsc, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;

      overlays = [
        agenix.overlays.default
        catppuccin-vsc.overlays.default
      ];

      config = {
        allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "spotify"
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
        spicetify.homeManagerModules.default
      ];

      extraSpecialArgs = { inherit inputs; };
    };
  };
}