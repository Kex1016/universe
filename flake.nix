{
  description = "Witchforge Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-dynamic-cursors = {
    #   url = "github:VirtCode/hypr-dynamic-cursors";
    #   inputs.hyprland.follows = "hyprland";
    # };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
    };

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
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
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
        overlays = [ inputs.niri-flake.overlays.niri ];
      };

      # hypr
      # hyprland = inputs.hyprland;
      # hyprland-dynamic-cursors = inputs.hyprland-dynamic-cursors;

      #spicetify = spicetify-nix.lib.mkSpicetify pkgs { };

      args = {
        inherit
          # hyprland
          # hyprland-dynamic-cursors
          noctalia
          spicetify-nix
          ;
      };

      commonHomeModules = [
        nvf.homeManagerModules.default
        stylix.homeModules.stylix
        # inputs.niri-flake.homeModules.niri
        (spicetify-nix.homeManagerModules.default)
        ./home.nix
      ];
      commonSystemModules = [
        ./system.nix
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        inputs.niri-flake.nixosModules.niri
        (spicetify-nix.nixosModules.spicetify)
        {
          home-manager = {
            extraSpecialArgs = args;
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
          };
        }
      ];
    in
    {
      nixosConfigurations = {
        coven = lib.nixosSystem {
          inherit system pkgs;

          modules = commonSystemModules ++ [
            ./modules/wms/niri/system.nix
            ./modules/apps/hyprland/system.nix
            ./setups/coven/system.nix
            {
              home-manager.users.majo.imports = commonHomeModules ++ [
                ./modules/wms/niri/home.nix
                ./modules/apps/hyprland/home.nix
                ./setups/coven/home.nix
              ];
            }
          ];

          specialArgs = args;
        };

        balefire = lib.nixosSystem {
          inherit system pkgs;

          modules = commonSystemModules ++ [
            ./modules/wms/hyprland/system.nix
            ./modules/apps/hyprland/system.nix
            ./setups/balefire/system.nix
            {
              home-manager.users.majo.imports = commonHomeModules ++ [
                ./modules/wms/hyprland/home.nix
                ./modules/apps/hyprland/home.nix
                ./setups/balefire/home.nix
              ];
            }
          ];

          specialArgs = args;
        };
      };
    };
}
