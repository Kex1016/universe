{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ ];

  programs.rofi = { enable = true; };
}
