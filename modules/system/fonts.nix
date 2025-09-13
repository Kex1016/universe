{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.departure-mono
    nerd-fonts.symbols-only
    noto-fonts
  ];
}
