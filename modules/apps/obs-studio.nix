{ config, pkgs, lib, ... }:

{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-tuna
      waveform
      obs-vaapi
      obs-vkcapture
      input-overlay
      # obs-composite-blur
    ];
  };
}
