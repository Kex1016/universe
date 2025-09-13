{ config, pkgs-unstable, lib, ... }:

{
  programs.floorp = {
    enable = true;
    package = (pkgs-unstable.floorp.override {
      nativeMessagingHosts = [
        pkgs-unstable.tridactyl-native
      ];
    });
  };
}
