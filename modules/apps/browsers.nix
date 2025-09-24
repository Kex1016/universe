{ config, pkgs, pkgs-unstable, lib, ... }:

{
  home.packages = with pkgs; [
    pkgs-unstable.vivaldi
    pkgs-unstable.vivaldi-ffmpeg-codecs
  ];

  programs.floorp = {
    enable = true;
    package = (pkgs-unstable.floorp-bin.override {
      nativeMessagingHosts = [
        pkgs-unstable.tridactyl-native
      ];
    });
  };
}
