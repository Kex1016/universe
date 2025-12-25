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
    jetbrains.idea-oss
    yubioath-flutter
  ];

  xdg.autostart.enable = true;

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
    };

    zathura = {
      enable = true;
    };

    keepassxc = {
      enable = true;
      autostart = true;
    };
  };

  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
