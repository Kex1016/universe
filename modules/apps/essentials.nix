{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zathura
    pavucontrol
    gnome-font-viewer
    qpwgraph
    cider
    spotify
  ];

  programs = {
    swayimg = {
      enable = true;
    };
    zathura = {
      enable = true;
    };
    mpv = {
      enable = true;
    };
  };
}
