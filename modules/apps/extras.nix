{ pkgs, ... }:

{
  home.packages = with pkgs; [
    showmethekey
    nmap
    electron-mail
    proton-pass
    wayvnc
    handbrake
    libreoffice-fresh
  ];
}
