{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    zathura
    pavucontrol
    gnome-font-viewer
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
