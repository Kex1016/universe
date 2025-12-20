{ pkgs, ... }:

{
  home.username = "majo";
  home.homeDirectory = "/home/majo";
  home.stateVersion = "25.05";
  home.sessionPath = [ "$HOME/.local/bin" ];
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "vivaldi-stable.desktop";
      "x-scheme-handler/http" = "vivaldi-stable.desktop";
      "x-scheme-handler/https" = "vivaldi-stable.desktop";
      "x-scheme-handler/about" = "vivaldi-stable.desktop";
      "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/ogg" = "mpv.desktop";
      "video/x-msvideo" = "mpv.desktop";
      "video/x-flv" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop";
      "video/x-m4v" = "mpv.desktop";
      "video/x-ms-wmv" = "mpv.desktop";
      "video/x-ms-asf" = "mpv.desktop";
      "video/x-mpeg" = "mpv.desktop";
      "video/mp2t" = "mpv.desktop";
      "video/x-mpegurl" = "mpv.desktop";
      "application/vnd.apple.mpegurl" = "mpv.desktop";
      "video/x-f4v" = "mpv.desktop";
      "video/x-smv" = "mpv.desktop";
      "audio/mpeg" = "com.github.neithern.g4music.desktop";
      "audio/mp4" = "com.github.neithern.g4music.desktop";
      "audio/ogg" = "com.github.neithern.g4music.desktop";
      "audio/webm" = "com.github.neithern.g4music.desktop";
      "audio/flac" = "com.github.neithern.g4music.desktop";
      "audio/wav" = "com.github.neithern.g4music.desktop";
      "audio/aac" = "com.github.neithern.g4music.desktop";
      "audio/x-aiff" = "com.github.neithern.g4music.desktop";
      "audio/x-m4a" = "com.github.neithern.g4music.desktop";
      "audio/x-ms-wma" = "com.github.neithern.g4music.desktop";
      "audio/x-wavpack" = "com.github.neithern.g4music.desktop";
      "audio/x-ape" = "com.github.neithern.g4music.desktop";
      "audio/x-mod" = "com.github.neithern.g4music.desktop";
      "audio/x-it" = "com.github.neithern.g4music.desktop";
      "audio/x-s3m" = "com.github.neithern.g4music.desktop";
      "application/pdf" = "zathura.desktop";
    };
  };

  home.packages = [ pkgs.gcr ];
}