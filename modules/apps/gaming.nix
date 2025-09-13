{ config, pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    prismlauncher
    pkgs-unstable.r2modman
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    protontricks = {
      enable = true;
    };
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
