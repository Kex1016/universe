{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.departure-mono
    nerd-fonts.symbols-only
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.caskaydia-cove
    noto-fonts
    roboto-flex
    roboto-slab
    roboto-mono
    nerd-fonts.roboto-mono
    liberation_ttf
  ];
}
