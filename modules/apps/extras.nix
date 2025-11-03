{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    pkgs-unstable.showmethekey
    nmap
    electron-mail
    pkgs-unstable.proton-pass
    wayvnc
    handbrake
    libreoffice-fresh
  ];
}
