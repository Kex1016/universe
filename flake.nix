{
  description = "Witchforge Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
        # to have it up-to-date or simply don't specify the nixpkgs input
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nix-alien.url = "github:thiagokokada/nix-alien";

    hytale-launcher.url = "github:Kex1016/HytaleLauncherFlake";
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
      firefox-addons,
      zen-browser,
      nix-alien,
      hytale-launcher,
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
          permittedInsecurePackages = [
            "nexusmods-app-0.21.1" # fuck you nexus
          ];
        };
        overlays = [
          nix-alien.overlays.default
          inputs.niri-flake.overlays.niri
          (final: prev: {
            vesktop = prev.vesktop.overrideAttrs (old: {
              preBuild = ''
                cp -r ${prev.electron.dist} electron-dist
                chmod -R u+w electron-dist
              '';
              buildPhase = ''
                runHook preBuild

                pnpm build
                pnpm exec electron-builder \
                  --dir \
                  -c.asarUnpack="**/*.node" \
                  -c.electronDist="electron-dist" \
                  -c.electronVersion=${prev.electron.version}

                runHook postBuild
              '';
            });
          })
        ];
      };

      ffaddons = pkgs.callPackage firefox-addons { };

      args = {
        inherit
          noctalia
          spicetify-nix
          ffaddons
          zen-browser
          hytale-launcher
          ;
      };

      commonHomeModules = [
        nvf.homeManagerModules.default
        inputs.zen-browser.homeModules.beta
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
            ./modules/apps/niri/system.nix
            ./setups/coven/system.nix
            {
              home-manager.users.majo.imports = commonHomeModules ++ [
                ./modules/wms/niri/home.nix
                ./modules/apps/niri/home.nix
                ./setups/coven/home.nix
              ];
            }
          ];

          specialArgs = args;
        };

        balefire = lib.nixosSystem {
          inherit system pkgs;

          modules = commonSystemModules ++ [
            ./modules/wms/niri/system.nix
            ./modules/apps/niri/system.nix
            ./setups/balefire/system.nix
            {
              home-manager.users.majo.imports = commonHomeModules ++ [
                ./modules/wms/niri/home.nix
                ./modules/apps/niri/home.nix
                ./setups/balefire/home.nix
              ];
            }
          ];

          specialArgs = args;
        };
      };
    };
}
