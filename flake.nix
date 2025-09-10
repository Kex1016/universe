{
  description = "Witchforge Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs-unstable = inputs.unstable.legacyPackages.${system};
    in {
      nixosConfigurations = {
        coven = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit pkgs-unstable; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.majo = import ./home.nix;
                backupFileExtension = "backup";
              };
            }
          ];
          specialArgs = { inherit pkgs-unstable; };
        };
      };
    };
}
