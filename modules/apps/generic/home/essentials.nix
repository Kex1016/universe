{ pkgs, spicetify-nix, ... }:

let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  home.packages = with pkgs; [
    pavucontrol
    gnome-font-viewer
    qpwgraph
    inotify-tools
    gapless
    file
    jetbrains.idea-community-bin
  ];

  programs = {
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

    zathura = {
      enable = true;
    };
  };

  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
