{
  description = "Witchforge Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix/release-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs-unstable = inputs.unstable.legacyPackages.${system};
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
                extraSpecialArgs = { inherit pkgs-unstable; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.majo = {
		  imports = [
		    ./home.nix
                    catppuccin.homeModules.catppuccin
		  ];
		};
                backupFileExtension = "backup";
              };
            }
          ];

          specialArgs = { inherit pkgs-unstable; };
        };
      };
    };
}
