{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.departure-mono
    nerd-fonts.symbols-only
    nerd-fonts.fantasque-sans-mono
    noto-fonts
    roboto-flex
    roboto-slab
    roboto-mono
    nerd-fonts.roboto-mono
  ];
}
