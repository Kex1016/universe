{
  pkgs-unstable,
  ...
}:

{
  programs.obs-studio = {
    enable = true;
    package = pkgs-unstable.obs-studio;
    plugins = with pkgs-unstable.obs-studio-plugins; [
      wlrobs
      obs-tuna
      waveform
      obs-vaapi
      obs-vkcapture
      input-overlay
      obs-browser-transition
      # obs-composite-blur
    ];
  };
}
