{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs;
    [
      (wrapOBS {
        plugins = with obs-studio-plugins; [
          wlrobs
          obs-tuna
          waveform
          obs-vaapi
          obs-vkcapture
          input-overlay
          obs-composite-blur
        ];
      })
    ];
}
