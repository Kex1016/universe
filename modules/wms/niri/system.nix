{ pkgs, ... }:
{
  imports = [
    ../generic/system/ananicy.nix
    ../generic/system/boot.nix
    ../generic/system/fonts.nix
    ../generic/system/gaming.nix
    ../generic/system/updater.nix
  ];
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;
}
