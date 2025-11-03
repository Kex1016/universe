{
  description = "Witchforge Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
    };

    catppuccin.url = "github:catppuccin/nix/release-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      catppuccin,
      unstable,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      # CHANGE THIS IF ON LAPTOP
      hostname = "coven";
      lib = nixpkgs.lib;

      # PACKAGES
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      pkgs-unstable = import unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      # hypr
      hyprland = inputs.hyprland;
      hyprland-dynamic-cursors = inputs.hyprland-dynamic-cursors;
    in
    {
      nixosConfigurations = {
        coven = lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./system.nix
            ./modules/setups/coven/system.nix
            home-manager.nixosModules.home-manager
            catppuccin.nixosModules.catppuccin
            {
              home-manager = {
                extraSpecialArgs = {
                  inherit
                    pkgs-unstable
                    hyprland
                    hyprland-dynamic-cursors
                    hostname
                    ;
                };

                useGlobalPkgs = true;
                useUserPackages = true;
                users.majo = {
                  imports = [
                    ./home.nix
                    ./modules/setups/coven/home.nix
                    catppuccin.homeModules.catppuccin
                  ];
                };
                backupFileExtension = "backup";
              };
            }
          ];

          specialArgs = {
            inherit
              pkgs-unstable
              hyprland
              hyprland-dynamic-cursors
              hostname
              ;
          };
        };

        balefire = lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./system.nix
            ./modules/setups/balefire/system.nix
            home-manager.nixosModules.home-manager
            catppuccin.nixosModules.catppuccin
            {
              home-manager = {
                extraSpecialArgs = {
                  inherit
                    pkgs-unstable
                    hyprland
                    hyprland-dynamic-cursors
                    hostname
                    ;
                };

                useGlobalPkgs = true;
                useUserPackages = true;
                users.majo = {
                  imports = [
                    ./home.nix
                    ./modules/setups/balefire/home.nix
                    catppuccin.homeModules.catppuccin
                  ];
                };
                backupFileExtension = "backup";
              };
            }
          ];

          specialArgs = {
            inherit
              pkgs-unstable
              hyprland
              hyprland-dynamic-cursors
              hostname
              ;
          };
        };
      };
    };
}
