{ config, pkgs, pkgs-unstable, lib, ... }:

{
  home.packages = with pkgs; [
    pkgs-unstable.showmethekey
    nmap
  ];
}
