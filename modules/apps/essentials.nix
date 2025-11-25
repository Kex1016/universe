{
  pkgs,
  spicetify-nix,
  config,
  ...
}:

let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  home.packages = with pkgs; [
    zathura
    pavucontrol
    gnome-font-viewer
    qpwgraph
    cider
    inotify-tools
    gapless
    file
    jetbrains.idea-community-bin
  ];

  programs = {
    swayimg = {
      enable = true;
      settings = {
        general = {
          overlay = "yes";
        };
        viewer = {
          window = "#1e1e2eff";
        };
        "keys.viewer" = {
          "Y" = ''exec ${config.home.homeDirectory}/.local/bin/hyprimgcpy "%"'';
        };
      };
    };
    zathura = {
      enable = true;
    };
    mpv = {
      enable = true;
    };

    spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        shuffle
      ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
  };

  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
