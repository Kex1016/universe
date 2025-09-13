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
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    catppuccin.url = "github:catppuccin/nix/release-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      # unstable nixpkgs
      pkgs-unstable = import unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      # hypr
      hyprland = inputs.hyprland;
      hyprland-dynamic-cursors = inputs.hyprland-dynamic-cursors;
      # hyprland-plugins = inputs.hyprland-plugins;
    in {
      nixosConfigurations = {
        coven = lib.nixosSystem {
          inherit system;
          modules = [
            ./system.nix
            home-manager.nixosModules.home-manager
            catppuccin.nixosModules.catppuccin
            {
              home-manager = {
                extraSpecialArgs = {
                  inherit pkgs-unstable;
                  
                  # hypr
                  inherit hyprland;
                  inherit hyprland-dynamic-cursors;
                  # inherit hyprland-plugins;
                };

                useGlobalPkgs = true;
                useUserPackages = true;
                users.majo = {
                  imports = [ ./home.nix catppuccin.homeModules.catppuccin ];
                };
                backupFileExtension = "backup";
              };
            }
          ];

          specialArgs = {
            inherit pkgs-unstable;

            # hypr
            inherit hyprland;
            inherit hyprland-dynamic-cursors;
            # inherit hyprland-plugins;
          };
        };
      };
    };
}
