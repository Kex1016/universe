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
      settings = {
        general = {
          overlay = true;
        };
        viewer = {
          window = "#1e1e2eff";
        };
      };
    };
    zathura = {
      enable = true;
    };
    mpv = {
      enable = true;
    };
  };
}
