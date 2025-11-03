{ pkgs-unstable, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    protontricks = {
      enable = true;
    };
    extraCompatPackages = with pkgs-unstable; [
      proton-ge-bin
    ];
  };
}
