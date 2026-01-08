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
    teams-for-linux
    plexamp
    gitkraken
    drawio
    blockbench
    synology-drive-client
  ];

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
}
