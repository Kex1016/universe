{ pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    vivaldi
    vivaldi-ffmpeg-codecs
  ];

  programs.floorp = {
    enable = true;
    package = (
      pkgs-unstable.floorp-bin.override {
        nativeMessagingHosts = with pkgs-unstable; [
          tridactyl-native
        ];
      }
    );
  };
}
