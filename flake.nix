{
  description = "Witchforge Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
    };

    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell"; # Use same quickshell version
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      catppuccin,
      noctalia,
      spicetify-nix,
      nvf,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      # PACKAGES
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      # hypr
      hyprland = inputs.hyprland;
      hyprland-dynamic-cursors = inputs.hyprland-dynamic-cursors;

      #spicetify = spicetify-nix.lib.mkSpicetify pkgs { };

      args = {
        inherit
          hyprland
          hyprland-dynamic-cursors
          noctalia
          spicetify-nix
          ;
      };
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
            (spicetify-nix.nixosModules.spicetify)
            {
              home-manager = {
                extraSpecialArgs = args;

                useGlobalPkgs = true;
                useUserPackages = true;
                users.majo = {
                  imports = [
                    nvf.homeManagerModules.default
                    catppuccin.homeModules.catppuccin
                    noctalia.homeModules.default
                    (spicetify-nix.homeManagerModules.default)
                    inputs.nix-doom-emacs-unstraightened.homeModule
                    ./home.nix
                    ./modules/setups/coven/home.nix
                  ];
                };
                backupFileExtension = "backup";
              };
            }
          ];

          specialArgs = args;
        };

        balefire = lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./system.nix
            ./modules/setups/balefire/system.nix
            home-manager.nixosModules.home-manager
            catppuccin.nixosModules.catppuccin
            (spicetify-nix.nixosModules.spicetify)
            {
              home-manager = {
                extraSpecialArgs = args;

                useGlobalPkgs = true;
                useUserPackages = true;
                users.majo = {
                  imports = [
                    nvf.homeManagerModules.default
                    noctalia.homeModules.default
                    catppuccin.homeModules.catppuccin
                    (spicetify-nix.homeManagerModules.default)
                    inputs.nix-doom-emacs-unstraightened.homeModule
                    ./home.nix
                    ./modules/setups/balefire/home.nix
                  ];
                };
                backupFileExtension = "backup";
              };
            }
          ];

          specialArgs = args;
        };
      };
    };
}
