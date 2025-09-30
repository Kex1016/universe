{ config, pkgs, pkgs-unstable, lib, ... }:

{
  home.packages = with pkgs; [
    pkgs-unstable.showmethekey
    nmap
    electron-mail
    pkgs-unstable.proton-pass
  ];
}
