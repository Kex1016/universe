{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs
  ];

  /* programs.floorp = {
    enable = true;
    package = (
      pkgs.floorp-bin.override {
        nativeMessagingHosts = with pkgs; [
          tridactyl-native
        ];
      }
    );
  }; */
}
