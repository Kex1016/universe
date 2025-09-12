{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    zathura
  ];

  programs = {
    swayimg = {
      enable = true;
    };
    zathura = {
      enable = true;
    };
  };
}
