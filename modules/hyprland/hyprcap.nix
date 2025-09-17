{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    wf-recorder
    grim
    slurp
  ];

  # The rest is done in ~/.local/bin :D
}
